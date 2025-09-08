/// Battery information for the device.
class BatteryInfo {
  /// Creates a [BatteryInfo] instance.
  const BatteryInfo({
    this.level,
    this.isCharging,
    this.state,
  });

  /// Creates a [BatteryInfo] from a map.
  factory BatteryInfo.fromMap(Map<String, dynamic> map) => BatteryInfo(
        level: (map['level'] as num?)?.toDouble(),
        isCharging: map['isCharging'] as bool?,
        state: map['state'] as String?,
      );

  /// Battery level as a percentage (0.0 to 1.0).
  final double? level;

  /// Whether the device is currently charging.
  final bool? isCharging;

  /// Current battery state.
  final String? state;

  /// Converts to a map.
  Map<String, dynamic> toMap() => {
        'level': level,
        'isCharging': isCharging,
        'state': state,
      };
}