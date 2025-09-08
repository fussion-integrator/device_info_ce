import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:device_info_ce/device_info_ce.dart';
import '../theme/app_theme.dart';

class SecurityScreen extends StatelessWidget {
  final SecurityInfo? securityInfo;

  const SecurityScreen({super.key, this.securityInfo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInDown(
            child: Text(
              'Security Analysis',
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
                  child: _buildSecurityScore(context),
                ),
                const SizedBox(height: 16),
                FadeInUp(
                  delay: const Duration(milliseconds: 200),
                  child: _buildSecurityChecks(context),
                ),
                const SizedBox(height: 16),
                FadeInUp(
                  delay: const Duration(milliseconds: 300),
                  child: _buildBiometrics(context),
                ),
                const SizedBox(height: 16),
                FadeInUp(
                  delay: const Duration(milliseconds: 400),
                  child: _buildRecommendations(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityScore(BuildContext context) {
    final score = _calculateSecurityScore();
    final color = _getScoreColor(score);

    return Card(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Text(
              'Security Score',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: CircularProgressIndicator(
                    value: score / 100,
                    strokeWidth: 8,
                    backgroundColor: color.withOpacity(0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      '${score.toInt()}',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    Text(
                      _getScoreLabel(score),
                      style: TextStyle(
                        fontSize: 14,
                        color: color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityChecks(BuildContext context) {
    final checks = [
      SecurityCheck(
        'Device Encryption',
        securityInfo?.isEncrypted ?? false,
        'Device storage is encrypted',
      ),
      SecurityCheck(
        'Screen Lock',
        securityInfo?.lockScreenType != null,
        'Screen lock is enabled',
      ),
      SecurityCheck(
        'Developer Mode',
        !(securityInfo?.isDeveloperModeEnabled ?? false),
        'Developer options disabled',
      ),
      SecurityCheck(
        'Root/Jailbreak',
        !(securityInfo?.isRooted ?? false) && !(securityInfo?.isJailbroken ?? false),
        'Device not modified',
      ),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Security Checks',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...checks.map((check) => _buildCheckItem(check)),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckItem(SecurityCheck check) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            check.passed ? Icons.check_circle : Icons.cancel,
            color: check.passed ? AppTheme.successColor : AppTheme.errorColor,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  check.title,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  check.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBiometrics(BuildContext context) {
    final biometrics = securityInfo?.biometricTypes ?? [];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Biometric Authentication',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            if (biometrics.isEmpty)
              const Text('No biometric authentication available')
            else
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: biometrics.map((biometric) {
                  return Chip(
                    label: Text(biometric),
                    backgroundColor: AppTheme.accentColor.withOpacity(0.2),
                    labelStyle: const TextStyle(color: AppTheme.accentColor),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendations(BuildContext context) {
    final recommendations = _getSecurityRecommendations();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Security Recommendations',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...recommendations.map((rec) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.lightbulb_outline,
                    color: AppTheme.warningColor,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(child: Text(rec)),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  double _calculateSecurityScore() {
    double score = 0;
    
    if (securityInfo?.isEncrypted == true) score += 25;
    if (securityInfo?.lockScreenType != null) score += 20;
    if (!(securityInfo?.isDeveloperModeEnabled ?? false)) score += 15;
    if (!(securityInfo?.isRooted ?? false) && !(securityInfo?.isJailbroken ?? false)) score += 25;
    if ((securityInfo?.biometricTypes?.isNotEmpty ?? false)) score += 15;
    
    return score;
  }

  Color _getScoreColor(double score) {
    if (score >= 80) return AppTheme.successColor;
    if (score >= 60) return AppTheme.warningColor;
    return AppTheme.errorColor;
  }

  String _getScoreLabel(double score) {
    if (score >= 80) return 'Excellent';
    if (score >= 60) return 'Good';
    if (score >= 40) return 'Fair';
    return 'Poor';
  }

  List<String> _getSecurityRecommendations() {
    final recommendations = <String>[];
    
    if (!(securityInfo?.isEncrypted ?? false)) {
      recommendations.add('Enable device encryption for better data protection');
    }
    
    if (securityInfo?.lockScreenType == null) {
      recommendations.add('Set up a screen lock (PIN, pattern, or biometric)');
    }
    
    if (securityInfo?.isDeveloperModeEnabled == true) {
      recommendations.add('Disable developer options when not needed');
    }
    
    if (securityInfo?.biometricTypes?.isEmpty ?? true) {
      recommendations.add('Enable biometric authentication for enhanced security');
    }
    
    if (recommendations.isEmpty) {
      recommendations.add('Your device security looks good! Keep it updated.');
    }
    
    return recommendations;
  }
}

class SecurityCheck {
  final String title;
  final bool passed;
  final String description;

  SecurityCheck(this.title, this.passed, this.description);
}