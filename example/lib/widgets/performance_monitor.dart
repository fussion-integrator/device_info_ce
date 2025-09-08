import 'package:flutter/material.dart';
import 'package:device_info_ce/device_info_ce.dart';
import '../theme/app_theme.dart';
import 'dashboard_card.dart';

class PerformanceMonitor extends StatelessWidget {
  final PerformanceInfo? performanceInfo;

  const PerformanceMonitor({super.key, this.performanceInfo});

  @override
  Widget build(BuildContext context) {
    final cpuUsage = performanceInfo?.cpuUsage ?? 0.0;
    final memoryUsage = performanceInfo?.memoryUsage ?? 0.0;

    return DashboardCard(
      title: 'Performance',
      icon: Icons.speed,
      gradient: AppTheme.accentGradient,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildUsageRow('CPU', cpuUsage, Icons.memory),
          const SizedBox(height: 4),
          _buildUsageRow('RAM', memoryUsage, Icons.storage),
          const SizedBox(height: 4),
          Text(
            '${performanceInfo?.thermalState ?? 'Normal'}',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 10,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildUsageRow(String label, double usage, IconData icon) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white70, size: 12),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            '$label: ${(usage * 100).toInt()}%',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}