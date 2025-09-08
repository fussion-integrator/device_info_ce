import 'device_info.dart';

class IosDeviceInfo extends BaseDeviceInfo {
  final String? name;
  final String? systemName;
  final String? systemVersion;
  final String? model;
  final String? localizedModel;
  final String? identifierForVendor;
  final bool? isPhysicalDevice;
  final String? utsname;
  final String? machine;
  final String? nodename;
  final String? release;
  final String? sysname;
  final String? version;

  const IosDeviceInfo({
    this.name,
    this.systemName,
    this.systemVersion,
    this.model,
    this.localizedModel,
    this.identifierForVendor,
    this.isPhysicalDevice,
    this.utsname,
    this.machine,
    this.nodename,
    this.release,
    this.sysname,
    this.version,
  });

  factory IosDeviceInfo.fromMap(Map<String, dynamic> map) {
    return IosDeviceInfo(
      name: map['name'],
      systemName: map['systemName'],
      systemVersion: map['systemVersion'],
      model: map['model'],
      localizedModel: map['localizedModel'],
      identifierForVendor: map['identifierForVendor'],
      isPhysicalDevice: map['isPhysicalDevice'],
      utsname: map['utsname'],
      machine: map['machine'],
      nodename: map['nodename'],
      release: map['release'],
      sysname: map['sysname'],
      version: map['version'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'systemName': systemName,
      'systemVersion': systemVersion,
      'model': model,
      'localizedModel': localizedModel,
      'identifierForVendor': identifierForVendor,
      'isPhysicalDevice': isPhysicalDevice,
      'utsname': utsname,
      'machine': machine,
      'nodename': nodename,
      'release': release,
      'sysname': sysname,
      'version': version,
    };
  }
}