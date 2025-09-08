# Device Info CE Example

This example demonstrates how to use the device_info_ce plugin to retrieve comprehensive device information.

## Features Demonstrated

- 📱 Complete device information retrieval
- 🔋 Real-time battery monitoring
- 📊 Performance analytics with live charts
- 🔒 Security analysis and recommendations
- 🌐 Network information and connectivity
- 🎨 Modern UI with glassmorphic design

## Getting Started

1. Ensure you have Flutter installed
2. Run `flutter pub get` to install dependencies
3. Run the app on your device or simulator

```bash
flutter run
```

## Screenshots

The example app includes:

- **Dashboard**: Overview of all device metrics
- **Monitoring**: Real-time performance charts
- **Security**: Device security analysis
- **Network**: Connectivity information
- **Device Details**: Complete specifications

## Usage Examples

### Basic Device Info
```dart
final deviceInfo = await DeviceInfoCe.deviceInfo();
print('Model: ${deviceInfo.model}');
```

### Battery Monitoring
```dart
final battery = await DeviceInfoCe.batteryInfo();
print('Battery: ${(battery.level! * 100).toInt()}%');
```

### Real-time Streams
```dart
DeviceInfoCe.batteryStream.listen((battery) {
  print('Battery: ${(battery.level! * 100).toInt()}%');
});
```

## Permissions

Make sure to add the required permissions to your `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.READ_PHONE_STATE" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
```