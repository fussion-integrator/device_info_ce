class SecurityInfo {
  final bool? isDeviceSecure;
  final bool? isJailbroken;
  final bool? isRooted;
  final List<String>? biometricTypes;
  final String? lockScreenType;
  final bool? isEncrypted;
  final bool? isDeveloperModeEnabled;
  final bool? isDebuggingEnabled;
  final bool? isMockLocationEnabled;
  final List<String>? installedSecurityApps;
  final String? securityPatchLevel;
  final bool? isPlayProtectEnabled;

  const SecurityInfo({
    this.isDeviceSecure,
    this.isJailbroken,
    this.isRooted,
    this.biometricTypes,
    this.lockScreenType,
    this.isEncrypted,
    this.isDeveloperModeEnabled,
    this.isDebuggingEnabled,
    this.isMockLocationEnabled,
    this.installedSecurityApps,
    this.securityPatchLevel,
    this.isPlayProtectEnabled,
  });

  factory SecurityInfo.fromMap(Map<String, dynamic> map) {
    return SecurityInfo(
      isDeviceSecure: map['isDeviceSecure'],
      isJailbroken: map['isJailbroken'],
      isRooted: map['isRooted'],
      biometricTypes: map['biometricTypes']?.cast<String>(),
      lockScreenType: map['lockScreenType'],
      isEncrypted: map['isEncrypted'],
      isDeveloperModeEnabled: map['isDeveloperModeEnabled'],
      isDebuggingEnabled: map['isDebuggingEnabled'],
      isMockLocationEnabled: map['isMockLocationEnabled'],
      installedSecurityApps: map['installedSecurityApps']?.cast<String>(),
      securityPatchLevel: map['securityPatchLevel'],
      isPlayProtectEnabled: map['isPlayProtectEnabled'],
    );
  }

  /// Converts the SecurityInfo object to a Map.
  Map<String, dynamic> toMap() => {
        'isDeviceSecure': isDeviceSecure,
        'isJailbroken': isJailbroken,
        'isRooted': isRooted,
        'biometricTypes': biometricTypes,
        'lockScreenType': lockScreenType,
        'isEncrypted': isEncrypted,
        'isDeveloperModeEnabled': isDeveloperModeEnabled,
        'isDebuggingEnabled': isDebuggingEnabled,
        'isMockLocationEnabled': isMockLocationEnabled,
        'installedSecurityApps': installedSecurityApps,
        'securityPatchLevel': securityPatchLevel,
        'isPlayProtectEnabled': isPlayProtectEnabled,
      };
}