import 'dart:io';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:device_info_ce/device_info_ce.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/performance_monitor.dart';
import '../widgets/battery_widget.dart';
import '../widgets/security_status.dart';
import '../theme/app_theme.dart';
import 'device_details_screen.dart';
import 'monitoring_screen.dart';
import 'security_screen.dart';
import 'network_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  Map<String, dynamic>? _deviceInfo;
  BatteryInfo? _batteryInfo;
  PerformanceInfo? _performanceInfo;
  SecurityInfo? _securityInfo;
  NetworkInfo? _networkInfo;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDeviceInfo();
  }

  Future<void> _loadDeviceInfo() async {
    try {
      final deviceInfo = await DeviceInfoCe.deviceInfo();
      final batteryInfo = await DeviceInfoCe.batteryInfo();
      final performanceInfo = await DeviceInfoCe.performanceInfo();
      final securityInfo = await DeviceInfoCe.securityInfo();
      final networkInfo = await DeviceInfoCe.networkInfo();

      setState(() {
        _deviceInfo = deviceInfo?.toMap();
        _batteryInfo = batteryInfo;
        _performanceInfo = performanceInfo;
        _securityInfo = securityInfo;
        _networkInfo = networkInfo;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: _buildBody(),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    switch (_selectedIndex) {
      case 0:
        return _buildDashboard();
      case 1:
        return MonitoringScreen(
          batteryInfo: _batteryInfo,
          performanceInfo: _performanceInfo,
        );
      case 2:
        return SecurityScreen(securityInfo: _securityInfo);
      case 3:
        return NetworkScreen(networkInfo: _networkInfo);
      default:
        return _buildDashboard();
    }
  }

  Widget _buildDashboard() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 120,
          floating: true,
          pinned: true,
          backgroundColor: Colors.transparent,
          flexibleSpace: FlexibleSpaceBar(
            title: FadeInDown(
              child: Text(
                'Device Dashboard',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            background: Container(
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.9,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            delegate: SliverChildListDelegate([
              FadeInUp(
                delay: const Duration(milliseconds: 100),
                child: DashboardCard(
                  title: 'Device Info',
                  icon: Icons.smartphone,
                  gradient: AppTheme.primaryGradient,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeviceDetailsScreen(
                        deviceInfo: _deviceInfo,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _deviceInfo?['model'] ?? 'Unknown',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        Platform.operatingSystem.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FadeInUp(
                delay: const Duration(milliseconds: 200),
                child: BatteryWidget(batteryInfo: _batteryInfo),
              ),
              FadeInUp(
                delay: const Duration(milliseconds: 300),
                child: PerformanceMonitor(performanceInfo: _performanceInfo),
              ),
              FadeInUp(
                delay: const Duration(milliseconds: 400),
                child: SecurityStatus(securityInfo: _securityInfo),
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor_heart),
            label: 'Monitor',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.security),
            label: 'Security',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.network_check),
            label: 'Network',
          ),
        ],
      ),
    );
  }
}