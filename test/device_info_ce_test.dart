import 'package:flutter_test/flutter_test.dart';
import 'package:device_info_ce/device_info_ce.dart';
import 'package:device_info_ce/src/device_info_ce_platform.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDeviceInfoCePlatform
    with MockPlatformInterfaceMixin
    implements DeviceInfoCePlatform {
  
  @override
  Future<AndroidDeviceInfo> androidInfo() async {
    return AndroidDeviceInfo.fromMap({
      'version': {
        'release': '13',
        'sdkInt': 33,
      },
      'manufacturer': 'TestManufacturer',
      'model': 'TestModel',
      'brand': 'TestBrand',
      'isPhysicalDevice': true,
      'androidId': 'test_android_id',
    });
  }

  @override
  Future<IosDeviceInfo> iosInfo() async {
    return IosDeviceInfo.fromMap({
      'name': 'Test iPhone',
      'systemName': 'iOS',
      'systemVersion': '17.0',
      'model': 'iPhone',
      'identifierForVendor': 'test-vendor-id',
      'isPhysicalDevice': false,
    });
  }

  @override
  Future<BatteryInfo> batteryInfo() async {
    return BatteryInfo.fromMap({
      'level': 0.85,
      'state': 'discharging',
      'health': 0.95,
      'temperature': 25.0,
      'isCharging': false,
    });
  }

  @override
  Future<NetworkInfo> networkInfo() async {
    return NetworkInfo.fromMap({
      'connectionType': 'WiFi',
      'carrierName': 'Test Carrier',
      'signalStrength': -50,
      'isVpnActive': false,
    });
  }

  @override
  Future<SecurityInfo> securityInfo() async {
    return SecurityInfo.fromMap({
      'isDeviceSecure': true,
      'isRooted': false,
      'biometricTypes': ['fingerprint'],
      'isEncrypted': true,
    });
  }

  @override
  Future<PerformanceInfo> performanceInfo() async {
    return PerformanceInfo.fromMap({
      'cpuUsage': 0.25,
      'memoryUsage': 0.60,
      'temperature': 35.0,
      'thermalState': 'Normal',
    });
  }

  @override
  Stream<BatteryInfo> get batteryStream {
    return Stream.value(BatteryInfo.fromMap({
      'level': 0.85,
      'state': 'discharging',
      'isCharging': false,
    }));
  }

  @override
  Stream<PerformanceInfo> get performanceStream {
    return Stream.value(PerformanceInfo.fromMap({
      'cpuUsage': 0.25,
      'memoryUsage': 0.60,
      'thermalState': 'Normal',
    }));
  }
}

void main() {
  final DeviceInfoCePlatform initialPlatform = DeviceInfoCePlatform.instance;

  group('DeviceInfoCe', () {
    setUp(() {
      DeviceInfoCePlatform.instance = MockDeviceInfoCePlatform();
    });

    tearDown(() {
      DeviceInfoCePlatform.instance = initialPlatform;
    });

    test('androidInfo returns correct data', () async {
      final platform = DeviceInfoCePlatform.instance as MockDeviceInfoCePlatform;
      final info = await platform.androidInfo();
      expect(info.manufacturer, 'TestManufacturer');
      expect(info.model, 'TestModel');
    });

    test('iosInfo returns correct data', () async {
      final platform = DeviceInfoCePlatform.instance as MockDeviceInfoCePlatform;
      final info = await platform.iosInfo();
      expect(info.name, 'Test iPhone');
      expect(info.systemName, 'iOS');
    });

    test('batteryInfo returns correct data', () async {
      final info = await DeviceInfoCe.batteryInfo();
      expect(info.level, 0.85);
      expect(info.isCharging, false);
    });

    test('networkInfo returns correct data', () async {
      final info = await DeviceInfoCe.networkInfo();
      expect(info.connectionType, 'WiFi');
      expect(info.isVpnActive, false);
    });

    test('securityInfo returns correct data', () async {
      final info = await DeviceInfoCe.securityInfo();
      expect(info.isDeviceSecure, true);
      expect(info.isRooted, false);
    });

    test('performanceInfo returns correct data', () async {
      final info = await DeviceInfoCe.performanceInfo();
      expect(info.cpuUsage, 0.25);
      expect(info.memoryUsage, 0.60);
    });
  });
}