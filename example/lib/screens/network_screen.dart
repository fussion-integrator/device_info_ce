import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:device_info_ce/device_info_ce.dart';
import '../theme/app_theme.dart';

class NetworkScreen extends StatelessWidget {
  final NetworkInfo? networkInfo;

  const NetworkScreen({super.key, this.networkInfo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInDown(
            child: Text(
              'Network Information',
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
                  child: _buildConnectionStatus(context),
                ),
                const SizedBox(height: 16),
                FadeInUp(
                  delay: const Duration(milliseconds: 200),
                  child: _buildNetworkDetails(context),
                ),
                const SizedBox(height: 16),
                FadeInUp(
                  delay: const Duration(milliseconds: 300),
                  child: _buildSpeedTest(context),
                ),
                const SizedBox(height: 16),
                FadeInUp(
                  delay: const Duration(milliseconds: 400),
                  child: _buildSecurityInfo(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConnectionStatus(BuildContext context) {
    final connectionType = networkInfo?.connectionType ?? 'Unknown';
    final isConnected = connectionType != 'None';

    return Card(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: isConnected 
                ? [AppTheme.successColor.withOpacity(0.1), AppTheme.successColor.withOpacity(0.05)]
                : [AppTheme.errorColor.withOpacity(0.1), AppTheme.errorColor.withOpacity(0.05)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Icon(
              _getConnectionIcon(connectionType),
              size: 48,
              color: isConnected ? AppTheme.successColor : AppTheme.errorColor,
            ),
            const SizedBox(height: 16),
            Text(
              connectionType,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: isConnected ? AppTheme.successColor : AppTheme.errorColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isConnected ? 'Connected' : 'Disconnected',
              style: TextStyle(
                color: (isConnected ? AppTheme.successColor : AppTheme.errorColor).withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNetworkDetails(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Network Details',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildDetailRow('Carrier', networkInfo?.carrierName ?? 'Unknown'),
            _buildDetailRow('Network Operator', networkInfo?.networkOperator ?? 'Unknown'),
            _buildDetailRow('IP Address', networkInfo?.ipAddress ?? 'Unknown'),
            if (networkInfo?.wifiSSID != null)
              _buildDetailRow('WiFi Network', networkInfo!.wifiSSID!),
            _buildDetailRow('Signal Strength', '${networkInfo?.signalStrength ?? 0} dBm'),
            _buildDetailRow('Roaming', networkInfo?.isRoaming == true ? 'Yes' : 'No'),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(fontFamily: 'monospace'),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpeedTest(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Connection Speed',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildSpeedCard(
                    'Download',
                    networkInfo?.downloadSpeed ?? 0,
                    Icons.download,
                    AppTheme.accentColor,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildSpeedCard(
                    'Upload',
                    networkInfo?.uploadSpeed ?? 0,
                    Icons.upload,
                    AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildPingCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildSpeedCard(String label, double speed, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            '${speed.toStringAsFixed(1)} Mbps',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: color.withOpacity(0.8),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPingCard() {
    final ping = networkInfo?.ping ?? 0;
    final color = _getPingColor(ping);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.speed, color: color, size: 24),
          const SizedBox(width: 8),
          Text(
            'Ping: ${ping}ms',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityInfo(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Security & Privacy',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildSecurityItem(
              'VPN Active',
              networkInfo?.isVpnActive ?? false,
              'VPN connection detected',
            ),
            _buildSecurityItem(
              'Secure Connection',
              networkInfo?.connectionType == 'WiFi',
              'Using encrypted connection',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityItem(String title, bool isSecure, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            isSecure ? Icons.shield : Icons.warning,
            color: isSecure ? AppTheme.successColor : AppTheme.warningColor,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Text(
            isSecure ? 'Secure' : 'Warning',
            style: TextStyle(
              color: isSecure ? AppTheme.successColor : AppTheme.warningColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getConnectionIcon(String connectionType) {
    switch (connectionType.toLowerCase()) {
      case 'wifi':
        return Icons.wifi;
      case 'mobile':
      case 'cellular':
        return Icons.signal_cellular_4_bar;
      case 'ethernet':
        return Icons.cable;
      default:
        return Icons.signal_wifi_off;
    }
  }

  Color _getPingColor(int ping) {
    if (ping < 50) return AppTheme.successColor;
    if (ping < 100) return AppTheme.warningColor;
    return AppTheme.errorColor;
  }
}