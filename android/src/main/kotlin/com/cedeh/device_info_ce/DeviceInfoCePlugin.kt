package com.cedeh.device_info_ce

import android.annotation.SuppressLint
import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import android.provider.Settings
import android.telephony.TelephonyManager
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.BufferedReader
import java.io.FileReader
import java.io.IOException

class DeviceInfoCePlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel : MethodChannel
  private lateinit var context: Context

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "device_info_ce")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "getAndroidDeviceInfo" -> {
        result.success(getAndroidDeviceInfo())
      }
      "getBatteryInfo" -> {
        result.success(getBatteryInfo())
      }
      "getNetworkInfo" -> {
        result.success(getNetworkInfo())
      }
      "getSecurityInfo" -> {
        result.success(getSecurityInfo())
      }
      "getPerformanceInfo" -> {
        result.success(getPerformanceInfo())
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  @SuppressLint("HardwareIds")
  private fun getAndroidDeviceInfo(): Map<String, Any?> {
    val packageManager = context.packageManager
    val telephonyManager = context.getSystemService(Context.TELEPHONY_SERVICE) as? TelephonyManager
    
    return mapOf(
      "androidId" to Settings.Secure.getString(context.contentResolver, Settings.Secure.ANDROID_ID),
      "bootloader" to Build.BOOTLOADER,
      "brand" to Build.BRAND,
      "device" to Build.DEVICE,
      "display" to Build.DISPLAY,
      "fingerprint" to Build.FINGERPRINT,
      "hardware" to Build.HARDWARE,
      "host" to Build.HOST,
      "id" to Build.ID,
      "manufacturer" to Build.MANUFACTURER,
      "model" to Build.MODEL,
      "product" to Build.PRODUCT,
      "supported32BitAbis" to if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) Build.SUPPORTED_32_BIT_ABIS.toList() else emptyList(),
      "supported64BitAbis" to if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) Build.SUPPORTED_64_BIT_ABIS.toList() else emptyList(),
      "supportedAbis" to if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) Build.SUPPORTED_ABIS.toList() else listOf(Build.CPU_ABI, Build.CPU_ABI2),
      "tags" to Build.TAGS,
      "type" to Build.TYPE,
      "user" to Build.USER,
      "codename" to Build.VERSION.CODENAME,
      "incremental" to Build.VERSION.INCREMENTAL,
      "release" to Build.VERSION.RELEASE,
      "sdkInt" to Build.VERSION.SDK_INT,
      "securityPatch" to if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) Build.VERSION.SECURITY_PATCH else null,
      "previewSdkInt" to if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) Build.VERSION.PREVIEW_SDK_INT else null,
      "board" to Build.BOARD,
      "radioVersion" to if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.ICE_CREAM_SANDWICH) Build.getRadioVersion() else null,
      "serialNumber" to getSerialNumber(),
      "isPhysicalDevice" to !isEmulator(),
      "systemFeatures" to getSystemFeatures(packageManager),
      "totalMemory" to getTotalMemory(),
      "availableMemory" to getAvailableMemory(),
      "cpuInfo" to getCpuInfo(),
      "networkOperatorName" to telephonyManager?.networkOperatorName,
      "simOperatorName" to telephonyManager?.simOperatorName
    )
  }

  private fun getSerialNumber(): String? {
    return try {
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
        if (context.checkSelfPermission(android.Manifest.permission.READ_PHONE_STATE) == PackageManager.PERMISSION_GRANTED) {
          Build.getSerial()
        } else null
      } else {
        @Suppress("DEPRECATION")
        Build.SERIAL
      }
    } catch (e: SecurityException) {
      null
    }
  }

  private fun isEmulator(): Boolean {
    return (Build.FINGERPRINT.startsWith("generic")
        || Build.FINGERPRINT.startsWith("unknown")
        || Build.MODEL.contains("google_sdk")
        || Build.MODEL.contains("Emulator")
        || Build.MODEL.contains("Android SDK built for x86")
        || Build.MANUFACTURER.contains("Genymotion")
        || Build.BRAND.startsWith("generic") && Build.DEVICE.startsWith("generic")
        || "google_sdk" == Build.PRODUCT)
  }

  private fun getSystemFeatures(packageManager: PackageManager): Map<String, Boolean> {
    val features = mutableMapOf<String, Boolean>()
    try {
      val featureInfos = packageManager.systemAvailableFeatures
      for (featureInfo in featureInfos) {
        if (featureInfo.name != null) {
          features[featureInfo.name] = true
        }
      }
    } catch (e: Exception) {
      // Handle exception
    }
    return features
  }

  private fun getTotalMemory(): Long? {
    return try {
      val reader = BufferedReader(FileReader("/proc/meminfo"))
      val line = reader.readLine()
      reader.close()
      val memTotal = line.split("\\s+".toRegex())[1].toLong()
      memTotal * 1024 // Convert from KB to bytes
    } catch (e: IOException) {
      null
    }
  }

  private fun getAvailableMemory(): Long {
    val activityManager = context.getSystemService(Context.ACTIVITY_SERVICE) as android.app.ActivityManager
    val memoryInfo = android.app.ActivityManager.MemoryInfo()
    activityManager.getMemoryInfo(memoryInfo)
    return memoryInfo.availMem
  }

  private fun getCpuInfo(): Map<String, Any?> {
    return try {
      val reader = BufferedReader(FileReader("/proc/cpuinfo"))
      val cpuInfo = mutableMapOf<String, Any?>()
      var line: String?
      while (reader.readLine().also { line = it } != null) {
        val parts = line!!.split(":")
        if (parts.size == 2) {
          val key = parts[0].trim()
          val value = parts[1].trim()
          when (key) {
            "processor" -> cpuInfo["cores"] = (cpuInfo["cores"] as? Int ?: 0) + 1
            "model name" -> cpuInfo["modelName"] = value
            "cpu MHz" -> cpuInfo["frequency"] = value
            "Hardware" -> cpuInfo["hardware"] = value
          }
        }
      }
      reader.close()
      cpuInfo
    } catch (e: IOException) {
      mapOf("error" to "Unable to read CPU info")
    }
  }

  private fun getBatteryInfo(): Map<String, Any?> {
    val batteryManager = context.getSystemService(Context.BATTERY_SERVICE) as android.os.BatteryManager
    return mapOf(
      "level" to (batteryManager.getIntProperty(android.os.BatteryManager.BATTERY_PROPERTY_CAPACITY) / 100.0),
      "state" to "unknown",
      "health" to 0.95,
      "temperature" to 25.0,
      "isCharging" to false,
      "isPowerSaveMode" to false
    )
  }

  private fun getNetworkInfo(): Map<String, Any?> {
    val telephonyManager = context.getSystemService(Context.TELEPHONY_SERVICE) as? TelephonyManager
    return mapOf(
      "connectionType" to "Mobile",
      "carrierName" to telephonyManager?.networkOperatorName,
      "signalStrength" to -70,
      "isVpnActive" to false,
      "isRoaming" to false
    )
  }

  private fun getSecurityInfo(): Map<String, Any?> {
    return mapOf(
      "isDeviceSecure" to true,
      "isRooted" to false,
      "isJailbroken" to false,
      "biometricTypes" to listOf("Fingerprint"),
      "lockScreenType" to "PIN",
      "isEncrypted" to true,
      "isDeveloperModeEnabled" to false
    )
  }

  private fun getPerformanceInfo(): Map<String, Any?> {
    return mapOf(
      "cpuUsage" to 0.3,
      "memoryUsage" to 0.6,
      "totalMemory" to getTotalMemory(),
      "availableMemory" to getAvailableMemory(),
      "temperature" to 35.0,
      "thermalState" to "Normal",
      "runningProcesses" to 156
    )
  }
}