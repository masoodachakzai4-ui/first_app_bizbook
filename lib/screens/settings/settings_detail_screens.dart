import 'package:flutter/material.dart';
import '../../app/theme.dart';

class BusinessProfileScreen extends StatelessWidget {
  const BusinessProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Business Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Business Profile', style: AppTextStyles.heading2),
            const SizedBox(height: 8),
            const Text(
              'Manage your store name, address, and business information.',
              style: AppTextStyles.small,
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.storefront),
                title: const Text('BizBook Retail Store'),
                subtitle: const Text('Main branch'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ThemeSettingsScreen extends StatelessWidget {
  const ThemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Theme')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Theme', style: AppTextStyles.heading2),
            const SizedBox(height: 8),
            const Text(
              'Your app theme is currently set to light mode.',
              style: AppTextStyles.small,
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.palette),
                title: const Text('Light mode'),
                subtitle: const Text('Current theme'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecuritySettingsScreen extends StatelessWidget {
  const SecuritySettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Security')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Security', style: AppTextStyles.heading2),
            const SizedBox(height: 8),
            const Text(
              'Manage PIN, backup, and account security options.',
              style: AppTextStyles.small,
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.lock_outline),
                title: const Text('PIN protection'),
                subtitle: const Text('Enabled for quick access'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
