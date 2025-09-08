class BatteryInfo {
  final double? level;
  final String? state;
  final double? health;
  final double? temperature;
  final int? voltage;
  final String? technology;
  final int? cycleCount;
  final bool? isCharging;
  final bool? isPowerSaveMode;
  final double? chargingSpeed;

  const BatteryInfo({
    this.level,
    this.state,
    this.health,
    this.temperature,
    this.voltage,
    this.technology,
    this.cycleCount,
    this.isCharging,
    this.isPowerSaveMode,
    this.chargingSpeed,
  });

  factory BatteryInfo.fromMap(Map<String, dynamic> map) {
    return BatteryInfo(
      level: map['level']?.toDouble(),
      state: map['state'],
      health: map['health']?.toDouble(),
      temperature: map['temperature']?.toDouble(),
      voltage: map['voltage'],
      technology: map['technology'],
      cycleCount: map['cycleCount'],
      isCharging: map['isCharging'],
      isPowerSaveMode: map['isPowerSaveMode'],
      chargingSpeed: map['chargingSpeed']?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'level': level,
      'state': state,
      'health': health,
      'temperature': temperature,
      'voltage': voltage,
      'technology': technology,
      'cycleCount': cycleCount,
      'isCharging': isCharging,
      'isPowerSaveMode': isPowerSaveMode,
      'chargingSpeed': chargingSpeed,
    };
  }
}
