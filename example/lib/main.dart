import 'dart:io';
import 'package:flutter/material.dart';
import 'package:device_info_ce/device_info_ce.dart';
import 'screens/dashboard_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const DeviceInfoApp());
}

class DeviceInfoApp extends StatelessWidget {
  const DeviceInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Device Info CE',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const DashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
