import 'package:flutter/material.dart';
import 'package:device_info_ce/device_info_ce.dart';
import '../theme/app_theme.dart';
import 'dashboard_card.dart';

class BatteryWidget extends StatelessWidget {
  final BatteryInfo? batteryInfo;

  const BatteryWidget({super.key, this.batteryInfo});

  @override
  Widget build(BuildContext context) {
    final level = batteryInfo?.level ?? 0.0;
    final isCharging = batteryInfo?.isCharging ?? false;

    return DashboardCard(
      title: 'Battery',
      icon: _getBatteryIcon(level, isCharging),
      gradient: _getBatteryGradient(level),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${(level * 100).toInt()}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (isCharging)
                const Icon(
                  Icons.bolt,
                  color: Colors.yellow,
                  size: 14,
                ),
            ],
          ),
          const SizedBox(height: 4),
          Container(
            height: 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Colors.white30,
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: level,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            batteryInfo?.state ?? 'Unknown',
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

  IconData _getBatteryIcon(double level, bool isCharging) {
    if (isCharging) return Icons.battery_charging_full;
    if (level > 0.8) return Icons.battery_full;
    if (level > 0.6) return Icons.battery_5_bar;
    if (level > 0.4) return Icons.battery_3_bar;
    if (level > 0.2) return Icons.battery_2_bar;
    return Icons.battery_1_bar;
  }

  Gradient _getBatteryGradient(double level) {
    if (level > 0.5) {
      return const LinearGradient(
        colors: [AppTheme.successColor, Color(0xFF55A3FF)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (level > 0.2) {
      return const LinearGradient(
        colors: [AppTheme.warningColor, Color(0xFFFF9F43)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else {
      return const LinearGradient(
        colors: [AppTheme.errorColor, Color(0xFFFF6B6B)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
  }
}