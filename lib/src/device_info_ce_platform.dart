import 'dart:io';
import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'models/android_device_info.dart';
import 'models/ios_device_info.dart';
import 'models/battery_info.dart';
import 'models/network_info.dart';
import 'models/security_info.dart';
import 'models/performance_info.dart';

abstract class DeviceInfoCePlatform extends PlatformInterface {
  DeviceInfoCePlatform() : super(token: _token);

  static final Object _token = Object();
  static DeviceInfoCePlatform _instance = MethodChannelDeviceInfoCe();

  static DeviceInfoCePlatform get instance => _instance;

  static set instance(DeviceInfoCePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<AndroidDeviceInfo> androidInfo() {
    throw UnimplementedError('androidInfo() has not been implemented.');
  }

  Future<IosDeviceInfo> iosInfo() {
    throw UnimplementedError('iosInfo() has not been implemented.');
  }

  Future<BatteryInfo> batteryInfo() {
    throw UnimplementedError('batteryInfo() has not been implemented.');
  }

  Future<NetworkInfo> networkInfo() {
    throw UnimplementedError('networkInfo() has not been implemented.');
  }

  Future<SecurityInfo> securityInfo() {
    throw UnimplementedError('securityInfo() has not been implemented.');
  }

  Future<PerformanceInfo> performanceInfo() {
    throw UnimplementedError('performanceInfo() has not been implemented.');
  }

  Stream<BatteryInfo> get batteryStream {
    throw UnimplementedError('batteryStream has not been implemented.');
  }

  Stream<PerformanceInfo> get performanceStream {
    throw UnimplementedError('performanceStream has not been implemented.');
  }
}

class MethodChannelDeviceInfoCe extends DeviceInfoCePlatform {
  final methodChannel = const MethodChannel('device_info_ce');

  @override
  Future<AndroidDeviceInfo> androidInfo() async {
    final result = await methodChannel.invokeMethod('getAndroidDeviceInfo');
    return AndroidDeviceInfo.fromMap(Map<String, dynamic>.from(result as Map));
  }

  @override
  Future<IosDeviceInfo> iosInfo() async {
    final result = await methodChannel.invokeMethod('getIosDeviceInfo');
    return IosDeviceInfo.fromMap(Map<String, dynamic>.from(result as Map));
  }

  @override
  Future<BatteryInfo> batteryInfo() async {
    final result = await methodChannel.invokeMethod('getBatteryInfo');
    return BatteryInfo.fromMap(Map<String, dynamic>.from(result as Map));
  }

  @override
  Future<NetworkInfo> networkInfo() async {
    final result = await methodChannel.invokeMethod('getNetworkInfo');
    return NetworkInfo.fromMap(Map<String, dynamic>.from(result as Map));
  }

  @override
  Future<SecurityInfo> securityInfo() async {
    final result = await methodChannel.invokeMethod('getSecurityInfo');
    return SecurityInfo.fromMap(Map<String, dynamic>.from(result as Map));
  }

  @override
  Future<PerformanceInfo> performanceInfo() async {
    final result = await methodChannel.invokeMethod('getPerformanceInfo');
    return PerformanceInfo.fromMap(Map<String, dynamic>.from(result as Map));
  }

  @override
  Stream<BatteryInfo> get batteryStream {
    return const EventChannel('device_info_ce/battery')
        .receiveBroadcastStream()
        .map((data) => BatteryInfo.fromMap(Map<String, dynamic>.from(data as Map)));
  }

  @override
  Stream<PerformanceInfo> get performanceStream {
    return const EventChannel('device_info_ce/performance')
        .receiveBroadcastStream()
        .map((data) => PerformanceInfo.fromMap(Map<String, dynamic>.from(data as Map)));
  }
}

class DeviceInfoCe {
  static final DeviceInfoCePlatform _platform = DeviceInfoCePlatform.instance;

  static Future<AndroidDeviceInfo> androidInfo() {
    if (!Platform.isAndroid) {
      throw UnsupportedError('This method is only supported on Android');
    }
    return _platform.androidInfo();
  }

  static Future<IosDeviceInfo> iosInfo() {
    if (!Platform.isIOS) {
      throw UnsupportedError('This method is only supported on iOS');
    }
    return _platform.iosInfo();
  }

  static Future<dynamic> deviceInfo() async {
    if (Platform.isAndroid) {
      return await androidInfo();
    } else if (Platform.isIOS) {
      return await iosInfo();
    }
    throw UnsupportedError('Platform not supported');
  }

  static Future<BatteryInfo> batteryInfo() {
    return _platform.batteryInfo();
  }

  static Future<NetworkInfo> networkInfo() {
    return _platform.networkInfo();
  }

  static Future<SecurityInfo> securityInfo() {
    return _platform.securityInfo();
  }

  static Future<PerformanceInfo> performanceInfo() {
    return _platform.performanceInfo();
  }

  static Stream<BatteryInfo> get batteryStream {
    return _platform.batteryStream;
  }

  static Stream<PerformanceInfo> get performanceStream {
    return _platform.performanceStream;
  }
}