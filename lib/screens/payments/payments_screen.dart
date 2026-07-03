import 'package:flutter/material.dart';
import '../../app/theme.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Payments', style: AppTextStyles.heading2),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.payment, color: AppColors.primary),
              title: const Text('Customer and supplier payments'),
              subtitle: const Text(
                'Track received payments and pending balances.',
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              children: const [
                _PaymentItem(
                  title: 'Ali Khan',
                  subtitle: 'Received payment',
                  amount: 'PKR 2,000',
                ),
                _PaymentItem(
                  title: 'ABC Supplies',
                  subtitle: 'Payment pending',
                  amount: 'PKR 7,500',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentItem extends StatelessWidget {
  const _PaymentItem({
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
