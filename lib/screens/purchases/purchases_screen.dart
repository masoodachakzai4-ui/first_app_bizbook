import 'package:flutter/material.dart';
import '../../app/theme.dart';

class PurchasesScreen extends StatelessWidget {
  const PurchasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Purchases', style: AppTextStyles.heading2),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.shopping_bag, color: AppColors.primary),
              title: const Text('Supplier purchase entry'),
              subtitle: const Text(
                'Track invoices from suppliers and update stock.',
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              children: const [
                _PurchaseItem(
                  title: 'Purchase #2001',
                  subtitle: 'Supplier: ABC Supplies • Qty: 20',
                  amount: 'PKR 35,000',
                ),
                _PurchaseItem(
                  title: 'Purchase #2002',
                  subtitle: 'Supplier: Tech World • Qty: 8',
                  amount: 'PKR 18,800',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PurchaseItem extends StatelessWidget {
  const _PurchaseItem({
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
