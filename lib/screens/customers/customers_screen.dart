import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app/theme.dart';
import '../../models/customer.dart';
import '../../providers/customer_provider.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerProvider>(
      builder: (context, provider, _) {
        final customers = provider.searchQuery.isEmpty
            ? provider.customers
            : provider.searchResults;
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Customers', style: AppTextStyles.heading2),
                  IconButton(
                    onPressed: () => _showCustomerDialog(context),
                    icon: const Icon(
                      Icons.person_add_alt_1,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Search customers',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: provider.searchCustomers,
              ),
              const SizedBox(height: 12),
              Expanded(
                child: customers.isEmpty
                    ? const Center(
                        child: Text(
                          'No customers yet. Add your first customer.',
                        ),
                      )
                    : ListView.separated(
                        itemCount: customers.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final customer = customers[index];
                          return Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text(customer.name[0]),
                              ),
                              title: Text(
                                customer.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                '${customer.phone} • ${customer.city}',
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: AppColors.error,
                                ),
                                onPressed: () async {
                                  await provider.deleteCustomer(customer.id);
                                  if (!context.mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Customer deleted'),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showCustomerDialog(BuildContext context) async {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final emailController = TextEditingController();
    final addressController = TextEditingController();
    final cityController = TextEditingController();
    final balanceController = TextEditingController(text: '0');
    final notesController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Add Customer'),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'Enter customer name'
                        : null,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(labelText: 'Phone'),
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'Enter phone number'
                        : null,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: addressController,
                    decoration: const InputDecoration(labelText: 'Address'),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: cityController,
                    decoration: const InputDecoration(labelText: 'City'),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: balanceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Opening balance',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: notesController,
                    decoration: const InputDecoration(labelText: 'Notes'),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (!formKey.currentState!.validate()) return;
                final provider = context.read<CustomerProvider>();
                final customer = Customer(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: nameController.text.trim(),
                  phone: phoneController.text.trim(),
                  email: emailController.text.trim(),
                  address: addressController.text.trim(),
                  city: cityController.text.trim(),
                  customerType: 'individual',
                  openingBalance:
                      double.tryParse(balanceController.text.trim()) ?? 0,
                  status: 'active',
                  notes: notesController.text.trim(),
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                );
                await provider.addCustomer(customer);
                if (context.mounted) Navigator.pop(dialogContext);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Customer added')),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
