/// Contains network connectivity information.
///
/// Provides details about the device's network connection including
/// connection type, carrier information, and signal strength.
class NetworkInfo {
  /// Type of network connection (WiFi, Cellular, etc.).
  final String? connectionType;
  /// Name of the mobile carrier.
  final String? carrierName;
  final String? networkOperator;
  final int? signalStrength;
  final String? wifiSSID;
  final int? wifiSignalStrength;
  final String? ipAddress;
  final String? macAddress;
  final bool? isVpnActive;
  final bool? isRoaming;
  final List<String>? availableNetworks;
  final double? downloadSpeed;
  final double? uploadSpeed;
  final int? ping;

  /// Creates an instance of [NetworkInfo].
  const NetworkInfo({
    this.connectionType,
    this.carrierName,
    this.networkOperator,
    this.signalStrength,
    this.wifiSSID,
    this.wifiSignalStrength,
    this.ipAddress,
    this.macAddress,
    this.isVpnActive,
    this.isRoaming,
    this.availableNetworks,
    this.downloadSpeed,
    this.uploadSpeed,
    this.ping,
  });

  /// Creates a [NetworkInfo] instance from a map.
  factory NetworkInfo.fromMap(Map<String, dynamic> map) {
    return NetworkInfo(
      connectionType: map['connectionType'],
      carrierName: map['carrierName'],
      networkOperator: map['networkOperator'],
      signalStrength: map['signalStrength'],
      wifiSSID: map['wifiSSID'],
      wifiSignalStrength: map['wifiSignalStrength'],
      ipAddress: map['ipAddress'],
      macAddress: map['macAddress'],
      isVpnActive: map['isVpnActive'],
      isRoaming: map['isRoaming'],
      availableNetworks: map['availableNetworks']?.cast<String>(),
      downloadSpeed: map['downloadSpeed']?.toDouble(),
      uploadSpeed: map['uploadSpeed']?.toDouble(),
      ping: map['ping'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'connectionType': connectionType,
      'carrierName': carrierName,
      'networkOperator': networkOperator,
      'signalStrength': signalStrength,
      'wifiSSID': wifiSSID,
      'wifiSignalStrength': wifiSignalStrength,
      'ipAddress': ipAddress,
      'macAddress': macAddress,
      'isVpnActive': isVpnActive,
      'isRoaming': isRoaming,
      'availableNetworks': availableNetworks,
      'downloadSpeed': downloadSpeed,
      'uploadSpeed': uploadSpeed,
      'ping': ping,
    };
  }
}
