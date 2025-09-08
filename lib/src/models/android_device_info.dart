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
      androidId: map['androidId'],
      bootloader: map['bootloader'],
      brand: map['brand'],
      device: map['device'],
      display: map['display'],
      fingerprint: map['fingerprint'],
      hardware: map['hardware'],
      host: map['host'],
      id: map['id'],
      manufacturer: map['manufacturer'],
      model: map['model'],
      product: map['product'],
      supported32BitAbis: map['supported32BitAbis']?.cast<String>(),
      supported64BitAbis: map['supported64BitAbis']?.cast<String>(),
      supportedAbis: map['supportedAbis']?.cast<String>(),
      tags: map['tags'],
      type: map['type'],
      user: map['user'],
      codename: map['codename'],
      incremental: map['incremental'],
      release: map['release'],
      sdkInt: map['sdkInt'],
      securityPatch: map['securityPatch'],
      previewSdkInt: map['previewSdkInt'],
      board: map['board'],
      radioVersion: map['radioVersion'],
      serialNumber: map['serialNumber'],
      isPhysicalDevice: map['isPhysicalDevice'],
      systemFeatures: map['systemFeatures']?.cast<String, dynamic>(),
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