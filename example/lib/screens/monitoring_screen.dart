import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:animate_do/animate_do.dart';
import 'package:device_info_ce/device_info_ce.dart';
import '../theme/app_theme.dart';

class MonitoringScreen extends StatefulWidget {
  final BatteryInfo? batteryInfo;
  final PerformanceInfo? performanceInfo;

  const MonitoringScreen({
    super.key,
    this.batteryInfo,
    this.performanceInfo,
  });

  @override
  State<MonitoringScreen> createState() => _MonitoringScreenState();
}

class _MonitoringScreenState extends State<MonitoringScreen> {
  final List<FlSpot> _batteryData = [];
  final List<FlSpot> _cpuData = [];
  final List<FlSpot> _memoryData = [];
  int _dataPoints = 0;

  // Current values for display
  double _currentBattery = 85.0;
  double _currentCpu = 25.0;
  double _currentMemory = 60.0;
  double _currentTemp = 35.0;

  // Random generators for realistic data
  final _random = Random();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initializeData();
    _startRealTimeMonitoring();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _initializeData() {
    // Initialize with current values
    _currentBattery = (widget.batteryInfo?.level ?? 0.85) * 100;
    _currentCpu = (widget.performanceInfo?.cpuUsage ?? 0.25) * 100;
    _currentMemory = (widget.performanceInfo?.memoryUsage ?? 0.6) * 100;
    _currentTemp = widget.performanceInfo?.temperature ?? 35.0;
  }

  void _startRealTimeMonitoring() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (mounted) {
        _updateData();
      }
    });
  }

  void _updateData() {
    setState(() {
      _dataPoints++;

      // Generate realistic fluctuations
      _currentBattery = _generateRealisticValue(_currentBattery, 100, 0, 0.1);
      _currentCpu = _generateRealisticValue(_currentCpu, 100, 5, 5.0);
      _currentMemory = _generateRealisticValue(_currentMemory, 95, 30, 2.0);
      _currentTemp = _generateRealisticValue(_currentTemp, 45, 25, 1.0);

      // Add to chart data
      _batteryData.add(FlSpot(_dataPoints.toDouble(), _currentBattery));
      _cpuData.add(FlSpot(_dataPoints.toDouble(), _currentCpu));
      _memoryData.add(FlSpot(_dataPoints.toDouble(), _currentMemory));

      // Keep only last 30 data points for better visualization
      if (_batteryData.length > 30) {
        _batteryData.removeAt(0);
        _cpuData.removeAt(0);
        _memoryData.removeAt(0);

        // Adjust x-axis values
        for (int i = 0; i < _batteryData.length; i++) {
          _batteryData[i] = FlSpot(i.toDouble(), _batteryData[i].y);
          _cpuData[i] = FlSpot(i.toDouble(), _cpuData[i].y);
          _memoryData[i] = FlSpot(i.toDouble(), _memoryData[i].y);
        }
      }
    });
  }

  double _generateRealisticValue(
      double current, double max, double min, double volatility) {
    // Generate realistic fluctuations with some randomness
    double change = (_random.nextDouble() - 0.5) * volatility;
    double newValue = current + change;

    // Keep within bounds
    newValue = newValue.clamp(min, max);

    // Add some trending behavior
    if (_random.nextDouble() < 0.1) {
      // Occasional larger changes
      change = (_random.nextDouble() - 0.5) * volatility * 3;
      newValue = (current + change).clamp(min, max);
    }

    return newValue;
  }

  Color _getTempColor(double temp) {
    if (temp > 40) return AppTheme.errorColor;
    if (temp > 35) return AppTheme.warningColor;
    return AppTheme.successColor;
  }

  Color _getCpuColor(double cpu) {
    if (cpu > 80) return AppTheme.errorColor;
    if (cpu > 50) return AppTheme.warningColor;
    return AppTheme.primaryColor;
  }

  Color _getMemoryColor(double memory) {
    if (memory > 85) return AppTheme.errorColor;
    if (memory > 70) return AppTheme.warningColor;
    return AppTheme.accentColor;
  }

  Color _getBatteryColor(double battery) {
    if (battery < 20) return AppTheme.errorColor;
    if (battery < 50) return AppTheme.warningColor;
    return AppTheme.successColor;
  }

  String _getCurrentValue(String title) {
    switch (title) {
      case 'Battery Level':
        return '${_currentBattery.toInt()}%';
      case 'CPU Usage':
        return '${_currentCpu.toInt()}%';
      case 'Memory Usage':
        return '${_currentMemory.toInt()}%';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInDown(
            child: Text(
              'Real-time Monitoring',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView(
              children: [
                FadeInUp(
                  delay: const Duration(milliseconds: 100),
                  child: _buildChartCard(
                    'Battery Level',
                    _batteryData,
                    AppTheme.successColor,
                    '%',
                  ),
                ),
                const SizedBox(height: 16),
                FadeInUp(
                  delay: const Duration(milliseconds: 200),
                  child: _buildChartCard(
                    'CPU Usage',
                    _cpuData,
                    AppTheme.primaryColor,
                    '%',
                  ),
                ),
                const SizedBox(height: 16),
                FadeInUp(
                  delay: const Duration(milliseconds: 300),
                  child: _buildChartCard(
                    'Memory Usage',
                    _memoryData,
                    AppTheme.accentColor,
                    '%',
                  ),
                ),
                const SizedBox(height: 16),
                FadeInUp(
                  delay: const Duration(milliseconds: 400),
                  child: _buildStatsGrid(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartCard(
      String title, List<FlSpot> data, Color color, String unit) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 180,
              child: data.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : Stack(
                      children: [
                        LineChart(
                          LineChartData(
                            minY: 0,
                            maxY: 100,
                            gridData: FlGridData(
                              show: true,
                              drawVerticalLine: false,
                              horizontalInterval: 25,
                              getDrawingHorizontalLine: (value) {
                                return FlLine(
                                  color: Colors.grey.withOpacity(0.2),
                                  strokeWidth: 1,
                                );
                              },
                            ),
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                  interval: 25,
                                  getTitlesWidget: (value, meta) {
                                    return Text(
                                      '${value.toInt()}$unit',
                                      style: const TextStyle(fontSize: 10),
                                    );
                                  },
                                ),
                              ),
                              bottomTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                            ),
                            borderData: FlBorderData(
                              show: true,
                              border: Border(
                                left: BorderSide(
                                    color: Colors.grey.withOpacity(0.3)),
                                bottom: BorderSide(
                                    color: Colors.grey.withOpacity(0.3)),
                              ),
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                spots: data,
                                isCurved: true,
                                color: color,
                                barWidth: 3,
                                dotData: const FlDotData(show: false),
                                belowBarData: BarAreaData(
                                  show: true,
                                  color: color.withOpacity(0.2),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: color.withOpacity(0.3)),
                            ),
                            child: Text(
                              _getCurrentValue(title),
                              style: TextStyle(
                                color: color,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Current Stats',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1.8,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _buildStatItem(
                  'Temperature',
                  '${_currentTemp.toInt()}°C',
                  Icons.thermostat,
                  _getTempColor(_currentTemp),
                ),
                _buildStatItem(
                  'CPU Usage',
                  '${_currentCpu.toInt()}%',
                  Icons.memory,
                  _getCpuColor(_currentCpu),
                ),
                _buildStatItem(
                  'Memory Usage',
                  '${_currentMemory.toInt()}%',
                  Icons.storage,
                  _getMemoryColor(_currentMemory),
                ),
                _buildStatItem(
                  'Battery Level',
                  '${_currentBattery.toInt()}%',
                  Icons.battery_full,
                  _getBatteryColor(_currentBattery),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
      String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            label,
            style: TextStyle(
              color: color.withOpacity(0.8),
              fontSize: 10,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
