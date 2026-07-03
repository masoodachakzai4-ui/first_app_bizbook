import 'package:flutter/material.dart';
import '../../app/theme.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Sales', style: AppTextStyles.heading2),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Create sale',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Add invoice items, calculate totals, and reduce stock after completion.',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              children: const [
                _SaleItem(
                  title: 'Invoice #1001',
                  subtitle: 'Customer: Ali Khan • Total: PKR 4,500',
                  amount: 'PKR 4,500',
                ),
                _SaleItem(
                  title: 'Invoice #1002',
                  subtitle: 'Customer: Sara Khan • Total: PKR 2,100',
                  amount: 'PKR 2,100',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SaleItem extends StatelessWidget {
  const _SaleItem({
    required this.title,
    required this.subtitle,
    required this.amount,
  });

  final String title;
  final String subtitle;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Text(
          amount,
          style: const TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
