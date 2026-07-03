import 'package:flutter/material.dart';
import '../../app/routes.dart';
import '../../app/theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Settings', style: AppTextStyles.heading2),
          const SizedBox(height: 12),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.business),
                  title: const Text('Business Profile'),
                  subtitle: const Text('BizBook Retail Store'),
                  onTap: () =>
                      Navigator.pushNamed(context, Routes.businessProfile),
                ),
                ListTile(
                  leading: const Icon(Icons.palette),
                  title: const Text('Theme'),
                  subtitle: const Text('Light mode'),
                  onTap: () =>
                      Navigator.pushNamed(context, Routes.themeSettings),
                ),
                ListTile(
                  leading: const Icon(Icons.security),
                  title: const Text('Security'),
                  subtitle: const Text('PIN and backup options'),
                  onTap: () =>
                      Navigator.pushNamed(context, Routes.securitySettings),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
