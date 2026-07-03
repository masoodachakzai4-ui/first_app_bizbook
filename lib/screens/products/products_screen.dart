import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app/theme.dart';
import '../../models/product.dart';
import '../../providers/product_provider.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, _) {
        final products = provider.searchQuery.isEmpty
            ? provider.products
            : provider.searchResults;
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Products', style: AppTextStyles.heading2),
                  IconButton(
                    onPressed: () => _showProductDialog(context),
                    icon: const Icon(
                      Icons.add_circle,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Search products',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: provider.searchProducts,
              ),
              const SizedBox(height: 12),
              Expanded(
                child: products.isEmpty
                    ? const Center(
                        child: Text('No products yet. Add your first product.'),
                      )
                    : ListView.separated(
                        itemCount: products.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return Card(
                            child: ListTile(
                              title: Text(
                                product.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                '${product.category} • Qty: ${product.quantity} • PKR ${product.sellingPrice.toStringAsFixed(0)}',
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: AppColors.error,
                                ),
                                onPressed: () async {
                                  await provider.deleteProduct(product.id);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Product deleted'),
                                    ),
                                  );
                                },
                              ),
                              leading: CircleAvatar(
                                backgroundColor: product.isLowStock
                                    ? AppColors.warning.withValues(alpha: 0.2)
                                    : AppColors.primary.withValues(alpha: 0.1),
                                child: Icon(
                                  Icons.inventory_2,
                                  color: product.isLowStock
                                      ? AppColors.warning
                                      : AppColors.primary,
                                ),
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

  Future<void> _showProductDialog(BuildContext context) async {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    final priceController = TextEditingController();
    final costController = TextEditingController();
    final quantityController = TextEditingController();
    final categoryController = TextEditingController();
    final unitController = TextEditingController(text: 'pcs');
    final reorderController = TextEditingController(text: '5');
    final formKey = GlobalKey<FormState>();

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Add Product'),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Product name',
                    ),
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'Enter product name'
                        : null,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: categoryController,
                    decoration: const InputDecoration(labelText: 'Category'),
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'Enter category'
                        : null,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: unitController,
                    decoration: const InputDecoration(labelText: 'Unit'),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Selling price',
                    ),
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'Enter price'
                        : null,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: costController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Cost price'),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Stock quantity',
                    ),
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'Enter quantity'
                        : null,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: reorderController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Reorder level',
                    ),
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
                final provider = context.read<ProductProvider>();
                final product = Product(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: nameController.text.trim(),
                  description: descriptionController.text.trim(),
                  sellingPrice:
                      double.tryParse(priceController.text.trim()) ?? 0,
                  costPrice: double.tryParse(costController.text.trim()) ?? 0,
                  quantity: int.tryParse(quantityController.text.trim()) ?? 0,
                  category: categoryController.text.trim(),
                  unit: unitController.text.trim(),
                  reorderLevel:
                      int.tryParse(reorderController.text.trim()) ?? 0,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                );
                await provider.addProduct(product);
                if (context.mounted) Navigator.pop(dialogContext);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Product added')),
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
