# device_info_ce

[![pub package](https://img.shields.io/pub/v/device_info_ce.svg)](https://pub.dev/packages/device_info_ce)
[![popularity](https://img.shields.io/pub/popularity/device_info_ce?logo=dart)](https://pub.dev/packages/device_info_ce/score)
[![likes](https://img.shields.io/pub/likes/device_info_ce?logo=dart)](https://pub.dev/packages/device_info_ce/score)
[![pub points](https://img.shields.io/pub/points/device_info_ce?logo=dart)](https://pub.dev/packages/device_info_ce/score)
[![Platform](https://img.shields.io/badge/platform-android%20%7C%20ios-blue.svg)](https://pub.dev/packages/device_info_ce)

A comprehensive Flutter plugin for retrieving detailed device information including hardware specifications, system details, battery status, security analysis, and real-time performance monitoring across Android and iOS platforms.

## ✨ Features

- **📱 Complete Device Information**: Get comprehensive device details including hardware, system, memory, storage, and more
- **🔋 Advanced Battery Monitoring**: Real-time battery level, health, temperature, and charging status
- **📊 Performance Analytics**: Live CPU usage, memory consumption, and thermal state monitoring
- **🔒 Security Analysis**: Device security scoring, biometric detection, and root/jailbreak detection
- **🌐 Network Intelligence**: Connection type, signal strength, carrier information, and VPN detection
- **⚡ Real-time Streams**: Live data streams for continuous monitoring
- **🎯 Cross-Platform**: Supports both Android (API 16+) and iOS (11+)
- **🚫 Zero Dependencies**: Built from scratch using platform channels
- **🔐 Privacy Compliant**: Handles permissions and privacy requirements properly

## 📱 Supported Platforms

| Platform | Support | Version |
|----------|---------|---------|
| Android  | ✅ | API 16+ |
| iOS      | ✅ | iOS 11+ |
| Web      | ❌ | - |
| Desktop  | ❌ | - |

## 🚀 Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  device_info_ce: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## 📋 Permissions

### Android

Add these permissions to your `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.READ_PHONE_STATE" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
```

### iOS

No additional permissions required for basic device information.

## 📖 Usage

### Basic Device Information

```dart
import 'package:device_info_ce/device_info_ce.dart';
import 'dart:io';

// Get platform-specific device info
if (Platform.isAndroid) {
  AndroidDeviceInfo androidInfo = await DeviceInfoCe.androidInfo();
  print('Device: ${androidInfo.manufacturer} ${androidInfo.model}');
  print('Android Version: ${androidInfo.version?.release}');
  print('API Level: ${androidInfo.version?.sdkInt}');
} else if (Platform.isIOS) {
  IosDeviceInfo iosInfo = await DeviceInfoCe.iosInfo();
  print('Device: ${iosInfo.name}');
  print('Model: ${iosInfo.model}');
  print('iOS Version: ${iosInfo.systemVersion}');
}

// Or get generic device info
dynamic deviceInfo = await DeviceInfoCe.deviceInfo();
```

### Battery Information

```dart
import 'package:device_info_ce/device_info_ce.dart';

// Get current battery status
BatteryInfo batteryInfo = await DeviceInfoCe.batteryInfo();
print('Battery Level: ${(batteryInfo.level! * 100).toInt()}%');
print('Charging: ${batteryInfo.isCharging}');
print('Health: ${(batteryInfo.health! * 100).toInt()}%');
print('Temperature: ${batteryInfo.temperature}°C');

// Listen to real-time battery updates
DeviceInfoCe.batteryStream.listen((battery) {
  print('Battery: ${(battery.level! * 100).toInt()}%');
});
```

### Performance Monitoring

```dart
import 'package:device_info_ce/device_info_ce.dart';

// Get current performance metrics
PerformanceInfo performance = await DeviceInfoCe.performanceInfo();
print('CPU Usage: ${(performance.cpuUsage! * 100).toInt()}%');
print('Memory Usage: ${(performance.memoryUsage! * 100).toInt()}%');
print('Temperature: ${performance.temperature}°C');
print('Thermal State: ${performance.thermalState}');

// Monitor performance in real-time
DeviceInfoCe.performanceStream.listen((perf) {
  print('CPU: ${(perf.cpuUsage! * 100).toInt()}%');
  print('Memory: ${(perf.memoryUsage! * 100).toInt()}%');
});
```

### Security Analysis

```dart
import 'package:device_info_ce/device_info_ce.dart';

// Get security information
SecurityInfo security = await DeviceInfoCe.securityInfo();
print('Device Secure: ${security.isDeviceSecure}');
print('Rooted/Jailbroken: ${security.isRooted || security.isJailbroken}');
print('Biometrics: ${security.biometricTypes}');
print('Lock Screen: ${security.lockScreenType}');
print('Encrypted: ${security.isEncrypted}');
```

### Network Information

```dart
import 'package:device_info_ce/device_info_ce.dart';

// Get network details
NetworkInfo network = await DeviceInfoCe.networkInfo();
print('Connection: ${network.connectionType}');
print('Carrier: ${network.carrierName}');
print('Signal Strength: ${network.signalStrength} dBm');
print('VPN Active: ${network.isVpnActive}');
print('Roaming: ${network.isRoaming}');
```

### Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:device_info_ce/device_info_ce.dart';
import 'dart:io';

class DeviceInfoScreen extends StatefulWidget {
  @override
  _DeviceInfoScreenState createState() => _DeviceInfoScreenState();
}

class _DeviceInfoScreenState extends State<DeviceInfoScreen> {
  Map<String, dynamic>? deviceInfo;
  BatteryInfo? batteryInfo;
  PerformanceInfo? performanceInfo;
  SecurityInfo? securityInfo;
  NetworkInfo? networkInfo;

  @override
  void initState() {
    super.initState();
    _loadDeviceInfo();
  }

  Future<void> _loadDeviceInfo() async {
    try {
      final device = await DeviceInfoCe.deviceInfo();
      final battery = await DeviceInfoCe.batteryInfo();
      final performance = await DeviceInfoCe.performanceInfo();
      final security = await DeviceInfoCe.securityInfo();
      final network = await DeviceInfoCe.networkInfo();

      setState(() {
        deviceInfo = device?.toMap();
        batteryInfo = battery;
        performanceInfo = performance;
        securityInfo = security;
        networkInfo = network;
      });
    } catch (e) {
      print('Error loading device info: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Device Information')),
      body: deviceInfo == null
          ? Center(child: CircularProgressIndicator())
          : ListView(
              padding: EdgeInsets.all(16),
              children: [
                _buildInfoCard('Device', {
                  'Model': deviceInfo!['model'],
                  'Manufacturer': deviceInfo!['manufacturer'],
                  'OS Version': deviceInfo!['systemVersion'],
                }),
                _buildInfoCard('Battery', {
                  'Level': '${((batteryInfo?.level ?? 0) * 100).toInt()}%',
                  'Charging': '${batteryInfo?.isCharging}',
                  'Health': '${((batteryInfo?.health ?? 0) * 100).toInt()}%',
                }),
                _buildInfoCard('Performance', {
                  'CPU Usage': '${((performanceInfo?.cpuUsage ?? 0) * 100).toInt()}%',
                  'Memory Usage': '${((performanceInfo?.memoryUsage ?? 0) * 100).toInt()}%',
                  'Temperature': '${performanceInfo?.temperature}°C',
                }),
                _buildInfoCard('Security', {
                  'Device Secure': '${securityInfo?.isDeviceSecure}',
                  'Encrypted': '${securityInfo?.isEncrypted}',
                  'Biometrics': '${securityInfo?.biometricTypes?.join(", ")}',
                }),
                _buildInfoCard('Network', {
                  'Connection': '${networkInfo?.connectionType}',
                  'Carrier': '${networkInfo?.carrierName}',
                  'Signal': '${networkInfo?.signalStrength} dBm',
                }),
              ],
            ),
    );
  }

  Widget _buildInfoCard(String title, Map<String, dynamic> data) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ...data.entries.map((entry) => Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(entry.key),
                  Text('${entry.value}', style: TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
```

## 📊 Available Information

### Android Device Info
- Device identifiers (Android ID, Serial Number)
- Hardware details (Manufacturer, Model, Board, etc.)
- System information (OS version, API level, security patch)
- CPU and memory information
- Display specifications
- Storage information
- Network operator details

### iOS Device Info
- Device identifiers (Vendor ID, UDID)
- Hardware details (Model, Machine type)
- System information (iOS version, build info)
- Memory and storage information
- Screen and display details
- CPU architecture and core count

### Battery Information
- Battery level percentage
- Charging state and speed
- Battery health percentage
- Temperature monitoring
- Power saving mode status
- Charging cycles (where available)

### Performance Metrics
- Real-time CPU usage
- Memory consumption
- Available/total memory
- Device temperature
- Thermal state
- Running processes count

### Security Analysis
- Device security status
- Root/jailbreak detection
- Biometric authentication types
- Screen lock configuration
- Device encryption status
- Developer mode detection

### Network Information
- Connection type (WiFi, Cellular, etc.)
- Carrier name and operator
- Signal strength
- VPN detection
- Roaming status
- Network speed capabilities

## 🎯 Advanced Features

### Real-time Monitoring

```dart
// Monitor multiple metrics simultaneously
StreamSubscription? batterySubscription;
StreamSubscription? performanceSubscription;

void startMonitoring() {
  batterySubscription = DeviceInfoCe.batteryStream.listen((battery) {
    // Update UI with battery info
  });
  
  performanceSubscription = DeviceInfoCe.performanceStream.listen((perf) {
    // Update UI with performance metrics
  });
}

void stopMonitoring() {
  batterySubscription?.cancel();
  performanceSubscription?.cancel();
}
```

### Error Handling

```dart
try {
  final deviceInfo = await DeviceInfoCe.androidInfo();
  // Use device info
} catch (e) {
  print('Failed to get device info: $e');
  // Handle error appropriately
}
```

## 🔒 Privacy Considerations

This plugin collects device information that may be considered personally identifiable. Ensure you:

1. **Have proper privacy policies in place**
2. **Request user consent where required**
3. **Comply with GDPR, CCPA, and other privacy regulations**
4. **Only collect information you actually need**
5. **Inform users about data collection in your app**

## 🐛 Troubleshooting

### Common Issues

**Issue**: `MissingPluginException`
**Solution**: Run `flutter clean && flutter pub get` and rebuild your app.

**Issue**: Permission denied on Android
**Solution**: Ensure you've added the required permissions to `AndroidManifest.xml`.

**Issue**: No data returned
**Solution**: Check device compatibility and ensure you're handling null values properly.

## 📈 Performance Tips

1. **Cache device info** - Device specifications don't change frequently
2. **Use streams wisely** - Only subscribe to real-time data when needed
3. **Handle permissions** - Check and request permissions before accessing sensitive data
4. **Error handling** - Always wrap calls in try-catch blocks

## 🤝 Contributing

Contributions are welcome! Please read our [contributing guidelines](CONTRIBUTING.md) and submit pull requests to our [GitHub repository](https://github.com/cedeh/device_info_ce).

### Development Setup

```bash
git clone https://github.com/cedeh/device_info_ce.git
cd device_info_ce
flutter pub get
cd example
flutter run
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the excellent plugin architecture
- Contributors who help improve this package
- Community feedback and feature requests

## 📞 Support

- 📧 Email: support@deviceinfo.dev
- 🐛 Issues: [GitHub Issues](https://github.com/cedeh/device_info_ce/issues)
- 📖 Documentation: [Wiki](https://github.com/cedeh/device_info_ce/wiki)
- 💬 Discussions: [GitHub Discussions](https://github.com/cedeh/device_info_ce/discussions)

---

Made with ❤️ by the Device Info CE team