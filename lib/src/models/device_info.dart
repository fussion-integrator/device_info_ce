abstract class BaseDeviceInfo {
  const BaseDeviceInfo();

  Map<String, dynamic> toMap();
}

class DeviceInfo {
  final String? deviceId;
  final String? model;
  final String? manufacturer;
  final String? brand;
  final String? product;
  final String? device;
  final String? board;
  final String? hardware;
  final String? display;
  final String? fingerprint;
  final String? host;
  final String? user;
  final String? tags;
  final String? type;
  final String? id;
  final int? sdkInt;
  final String? release;
  final String? codename;
  final String? incremental;
  final String? securityPatch;
  final List<String>? supportedAbis;
  final List<String>? supported32BitAbis;
  final List<String>? supported64BitAbis;
  final Map<String, dynamic>? systemFeatures;
  final bool? isPhysicalDevice;
  final String? serialNumber;
  final String? androidId;

  const DeviceInfo({
    this.deviceId,
    this.model,
    this.manufacturer,
    this.brand,
    this.product,
    this.device,
    this.board,
    this.hardware,
    this.display,
    this.fingerprint,
    this.host,
    this.user,
    this.tags,
    this.type,
    this.id,
    this.sdkInt,
    this.release,
    this.codename,
    this.incremental,
    this.securityPatch,
    this.supportedAbis,
    this.supported32BitAbis,
    this.supported64BitAbis,
    this.systemFeatures,
    this.isPhysicalDevice,
    this.serialNumber,
    this.androidId,
  });

  factory DeviceInfo.fromMap(Map<String, dynamic> map) {
    return DeviceInfo(
      deviceId: map['deviceId'],
      model: map['model'],
      manufacturer: map['manufacturer'],
      brand: map['brand'],
      product: map['product'],
      device: map['device'],
      board: map['board'],
      hardware: map['hardware'],
      display: map['display'],
      fingerprint: map['fingerprint'],
      host: map['host'],
      user: map['user'],
      tags: map['tags'],
      type: map['type'],
      id: map['id'],
      sdkInt: map['sdkInt'],
      release: map['release'],
      codename: map['codename'],
      incremental: map['incremental'],
      securityPatch: map['securityPatch'],
      supportedAbis: map['supportedAbis']?.cast<String>(),
      supported32BitAbis: map['supported32BitAbis']?.cast<String>(),
      supported64BitAbis: map['supported64BitAbis']?.cast<String>(),
      systemFeatures: map['systemFeatures']?.cast<String, dynamic>(),
      isPhysicalDevice: map['isPhysicalDevice'],
      serialNumber: map['serialNumber'],
      androidId: map['androidId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'deviceId': deviceId,
      'model': model,
      'manufacturer': manufacturer,
      'brand': brand,
      'product': product,
      'device': device,
      'board': board,
      'hardware': hardware,
      'display': display,
      'fingerprint': fingerprint,
      'host': host,
      'user': user,
      'tags': tags,
      'type': type,
      'id': id,
      'sdkInt': sdkInt,
      'release': release,
      'codename': codename,
      'incremental': incremental,
      'securityPatch': securityPatch,
      'supportedAbis': supportedAbis,
      'supported32BitAbis': supported32BitAbis,
      'supported64BitAbis': supported64BitAbis,
      'systemFeatures': systemFeatures,
      'isPhysicalDevice': isPhysicalDevice,
      'serialNumber': serialNumber,
      'androidId': androidId,
    };
  }
}
