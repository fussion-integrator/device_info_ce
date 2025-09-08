import 'device_info.dart';

class AndroidDeviceInfo extends BaseDeviceInfo {
  final String? androidId;
  final String? bootloader;
  final String? brand;
  final String? device;
  final String? display;
  final String? fingerprint;
  final String? hardware;
  final String? host;
  final String? id;
  final String? manufacturer;
  final String? model;
  final String? product;
  final List<String>? supported32BitAbis;
  final List<String>? supported64BitAbis;
  final List<String>? supportedAbis;
  final String? tags;
  final String? type;
  final String? user;
  final String? codename;
  final String? incremental;
  final String? release;
  final int? sdkInt;
  final String? securityPatch;
  final int? previewSdkInt;
  final String? board;
  final String? radioVersion;
  final String? serialNumber;
  final bool? isPhysicalDevice;
  final Map<String, dynamic>? systemFeatures;

  const AndroidDeviceInfo({
    this.androidId,
    this.bootloader,
    this.brand,
    this.device,
    this.display,
    this.fingerprint,
    this.hardware,
    this.host,
    this.id,
    this.manufacturer,
    this.model,
    this.product,
    this.supported32BitAbis,
    this.supported64BitAbis,
    this.supportedAbis,
    this.tags,
    this.type,
    this.user,
    this.codename,
    this.incremental,
    this.release,
    this.sdkInt,
    this.securityPatch,
    this.previewSdkInt,
    this.board,
    this.radioVersion,
    this.serialNumber,
    this.isPhysicalDevice,
    this.systemFeatures,
  });

  factory AndroidDeviceInfo.fromMap(Map<String, dynamic> map) {
    return AndroidDeviceInfo(
      androidId: map['androidId']?.toString(),
      bootloader: map['bootloader']?.toString(),
      brand: map['brand']?.toString(),
      device: map['device']?.toString(),
      display: map['display']?.toString(),
      fingerprint: map['fingerprint']?.toString(),
      hardware: map['hardware']?.toString(),
      host: map['host']?.toString(),
      id: map['id']?.toString(),
      manufacturer: map['manufacturer']?.toString(),
      model: map['model']?.toString(),
      product: map['product']?.toString(),
      supported32BitAbis: map['supported32BitAbis'] != null ? List<String>.from(map['supported32BitAbis']) : null,
      supported64BitAbis: map['supported64BitAbis'] != null ? List<String>.from(map['supported64BitAbis']) : null,
      supportedAbis: map['supportedAbis'] != null ? List<String>.from(map['supportedAbis']) : null,
      tags: map['tags']?.toString(),
      type: map['type']?.toString(),
      user: map['user']?.toString(),
      codename: map['codename']?.toString(),
      incremental: map['incremental']?.toString(),
      release: map['release']?.toString(),
      sdkInt: map['sdkInt'] is int ? map['sdkInt'] : int.tryParse(map['sdkInt']?.toString() ?? ''),
      securityPatch: map['securityPatch']?.toString(),
      previewSdkInt: map['previewSdkInt'] is int ? map['previewSdkInt'] : int.tryParse(map['previewSdkInt']?.toString() ?? ''),
      board: map['board']?.toString(),
      radioVersion: map['radioVersion']?.toString(),
      serialNumber: map['serialNumber']?.toString(),
      isPhysicalDevice: map['isPhysicalDevice'] is bool ? map['isPhysicalDevice'] : map['isPhysicalDevice']?.toString()?.toLowerCase() == 'true',
      systemFeatures: map['systemFeatures'] != null ? Map<String, dynamic>.from(map['systemFeatures']) : null,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'androidId': androidId,
      'bootloader': bootloader,
      'brand': brand,
      'device': device,
      'display': display,
      'fingerprint': fingerprint,
      'hardware': hardware,
      'host': host,
      'id': id,
      'manufacturer': manufacturer,
      'model': model,
      'product': product,
      'supported32BitAbis': supported32BitAbis,
      'supported64BitAbis': supported64BitAbis,
      'supportedAbis': supportedAbis,
      'tags': tags,
      'type': type,
      'user': user,
      'codename': codename,
      'incremental': incremental,
      'release': release,
      'sdkInt': sdkInt,
      'securityPatch': securityPatch,
      'previewSdkInt': previewSdkInt,
      'board': board,
      'radioVersion': radioVersion,
      'serialNumber': serialNumber,
      'isPhysicalDevice': isPhysicalDevice,
      'systemFeatures': systemFeatures,
    };
  }
}