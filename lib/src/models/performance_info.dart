/// Contains device performance metrics and monitoring data.
///
/// Provides real-time performance information including CPU usage,
/// memory consumption, and thermal state.
class PerformanceInfo {
  /// Current CPU usage as a percentage (0.0 to 1.0).
  final double? cpuUsage;
  /// Current memory usage as a percentage (0.0 to 1.0).
  final double? memoryUsage;
  final int? totalMemory;
  final int? availableMemory;
  final double? gpuUsage;
  final double? temperature;
  final String? thermalState;
  final int? batteryTemperature;
  final List<double>? cpuFrequencies;
  final int? runningProcesses;
  final double? diskUsage;
  final double? networkUsage;

  /// Creates an instance of [PerformanceInfo].
  const PerformanceInfo({
    this.cpuUsage,
    this.memoryUsage,
    this.totalMemory,
    this.availableMemory,
    this.gpuUsage,
    this.temperature,
    this.thermalState,
    this.batteryTemperature,
    this.cpuFrequencies,
    this.runningProcesses,
    this.diskUsage,
    this.networkUsage,
  });

  /// Creates a [PerformanceInfo] instance from a map.
  factory PerformanceInfo.fromMap(Map<String, dynamic> map) {
    return PerformanceInfo(
      cpuUsage: map['cpuUsage']?.toDouble(),
      memoryUsage: map['memoryUsage']?.toDouble(),
      totalMemory: map['totalMemory'],
      availableMemory: map['availableMemory'],
      gpuUsage: map['gpuUsage']?.toDouble(),
      temperature: map['temperature']?.toDouble(),
      thermalState: map['thermalState'],
      batteryTemperature: map['batteryTemperature'],
      cpuFrequencies: map['cpuFrequencies']?.cast<double>(),
      runningProcesses: map['runningProcesses'],
      diskUsage: map['diskUsage']?.toDouble(),
      networkUsage: map['networkUsage']?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cpuUsage': cpuUsage,
      'memoryUsage': memoryUsage,
      'totalMemory': totalMemory,
      'availableMemory': availableMemory,
      'gpuUsage': gpuUsage,
      'temperature': temperature,
      'thermalState': thermalState,
      'batteryTemperature': batteryTemperature,
      'cpuFrequencies': cpuFrequencies,
      'runningProcesses': runningProcesses,
      'diskUsage': diskUsage,
      'networkUsage': networkUsage,
    };
  }
}
