import 'package:flutter/material.dart';
import 'package:device_info_ce/device_info_ce.dart';
import '../theme/app_theme.dart';
import 'dashboard_card.dart';

class SecurityStatus extends StatelessWidget {
  final SecurityInfo? securityInfo;

  const SecurityStatus({super.key, this.securityInfo});

  @override
  Widget build(BuildContext context) {
    final isSecure = securityInfo?.isDeviceSecure ?? false;
    final isRooted = securityInfo?.isRooted ?? false;
    final isJailbroken = securityInfo?.isJailbroken ?? false;

    return DashboardCard(
      title: 'Security',
      icon: _getSecurityIcon(),
      gradient: _getSecurityGradient(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _getSecurityStatusIcon(),
                color: Colors.white,
                size: 14,
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  _getSecurityStatus(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          if (isRooted || isJailbroken)
            const Text(
              'Device Modified',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 10,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          Text(
            '${securityInfo?.biometricTypes?.length ?? 0} biometric(s)',
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

  IconData _getSecurityIcon() {
    final isSecure = securityInfo?.isDeviceSecure ?? false;
    return isSecure ? Icons.security : Icons.security_outlined;
  }

  IconData _getSecurityStatusIcon() {
    final isSecure = securityInfo?.isDeviceSecure ?? false;
    return isSecure ? Icons.check_circle : Icons.warning;
  }

  String _getSecurityStatus() {
    final isSecure = securityInfo?.isDeviceSecure ?? false;
    return isSecure ? 'Secure' : 'At Risk';
  }

  Gradient _getSecurityGradient() {
    final isSecure = securityInfo?.isDeviceSecure ?? false;
    if (isSecure) {
      return const LinearGradient(
        colors: [AppTheme.successColor, Color(0xFF55A3FF)],
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