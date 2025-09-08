import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:share_plus/share_plus.dart';
import '../theme/app_theme.dart';
import '../utils/device_info_formatter.dart';

class DeviceDetailsScreen extends StatelessWidget {
  final Map<String, dynamic>? deviceInfo;

  const DeviceDetailsScreen({super.key, this.deviceInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.primaryColor.withOpacity(0.1),
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                title: FadeInUp(
                  child: const Text('Device Details'),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                  ),
                  child: Center(
                    child: FadeInDown(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.smartphone,
                            size: 64,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            deviceInfo?['model'] ?? 'Unknown Device',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () => _shareDeviceInfo(),
                ),
              ],
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  _buildInfoSections(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildInfoSections(BuildContext context) {
    if (deviceInfo == null) {
      return [
        const Center(
          child: Text('No device information available'),
        ),
      ];
    }

    final sections = DeviceInfoFormatter.categorizeDeviceInfo(deviceInfo!);
    final widgets = <Widget>[];

    int delay = 0;
    for (final section in sections.entries) {
      widgets.add(
        FadeInUp(
          delay: Duration(milliseconds: delay),
          child: _buildSection(context, section.key, section.value),
        ),
      );
      widgets.add(const SizedBox(height: 16));
      delay += 100;
    }

    return widgets;
  }

  Widget _buildSection(
      BuildContext context, String title, Map<String, dynamic> data) {
    return Card(
      child: ExpansionTile(
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        leading: _getSectionIcon(title),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: data.entries.map((entry) {
                return _buildInfoRow(context, entry.key, entry.value);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String key, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              DeviceInfoFormatter.formatKey(key),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          Expanded(
            flex: 3,
            child: SelectableText(
              DeviceInfoFormatter.formatValue(value),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: 'monospace',
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Icon _getSectionIcon(String title) {
    switch (title.toLowerCase()) {
      case 'device identity':
        return const Icon(Icons.fingerprint);
      case 'hardware':
        return const Icon(Icons.memory);
      case 'system':
        return const Icon(Icons.settings_system_daydream);
      case 'display':
        return const Icon(Icons.screen_lock_portrait);
      case 'memory & storage':
        return const Icon(Icons.storage);
      case 'battery':
        return const Icon(Icons.battery_full);
      case 'cpu':
        return const Icon(Icons.speed);
      case 'network':
        return const Icon(Icons.network_check);
      default:
        return const Icon(Icons.info);
    }
  }

  void _shareDeviceInfo() {
    if (deviceInfo == null) return;

    final info = DeviceInfoFormatter.formatForSharing(deviceInfo!);
    Share.share(info, subject: 'Device Information');
  }
}
