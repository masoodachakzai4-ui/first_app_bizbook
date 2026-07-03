import 'package:flutter/material.dart';
import '../../app/routes.dart';
import '../../app/theme.dart';
import '../../widgets/summary_card.dart';
import '../products/products_screen.dart';
import '../reports/reports_screen.dart';
import '../sales/sales_screen.dart';
import '../settings/settings_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;
  late final List<Widget> pages;
  final List<String> pageTitles = const [
    'Dashboard',
    'Sales',
    'Products',
    'Reports',
    'Settings',
  ];

  final List<IconData> pageIcons = const [
    Icons.dashboard,
    Icons.receipt_long,
    Icons.inventory_2,
    Icons.bar_chart,
    Icons.settings,
  ];

  final List<Map<String, dynamic>> cards = [
    {
      'title': 'Sales',
      'value': '\$12,500',
      'icon': Icons.attach_money,
      'color': Colors.green,
      'route': Routes.sales,
    },
    {
      'title': 'Purchases',
      'value': '\$8,200',
      'icon': Icons.shopping_cart,
      'color': Colors.orange,
      'route': Routes.purchases,
    },
    {
      'title': 'Products',
      'value': '45',
      'icon': Icons.inventory_2,
      'color': Colors.blue,
      'route': Routes.products,
    },
    {
      'title': 'Customers',
      'value': '128',
      'icon': Icons.people,
      'color': Colors.purple,
      'route': Routes.customers,
    },
    {
      'title': 'Stock',
      'value': '245',
      'icon': Icons.warehouse,
      'color': Colors.teal,
      'route': Routes.products,
    },
    {
      'title': 'Payments',
      'value': '\$3,400',
      'icon': Icons.payments,
      'color': Colors.indigo,
      'route': Routes.payments,
    },
    {
      'title': 'Reports',
      'value': '24',
      'icon': Icons.bar_chart,
      'color': Colors.red,
      'route': Routes.reports,
    },
    {
      'title': 'Settings',
      'value': 'App',
      'icon': Icons.settings,
      'color': Colors.grey,
      'route': Routes.settings,
    },
  ];
  void navigateTo(String route) {
    if (route == Routes.dashboard) return;
    Navigator.pushNamed(context, route);
  }

  void changePage(int index) {
    setState(() => currentIndex = index);
  }

  @override
  void initState() {
    super.initState();
    pages = const [
      DashboardHomeTab(),
      SalesScreen(),
      ProductsScreen(),
      ReportsScreen(),
      SettingsScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitles[currentIndex]),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No new notifications')),
              );
            },
          ),
          const SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: CircleAvatar(
              backgroundColor: AppColors.surfaceVariant,
              child: const Icon(Icons.person, color: AppColors.primary),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text("Masood"),
              accountEmail: const Text("admin@bizbook.com"),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: AppColors.primary),
              ),
              decoration: const BoxDecoration(color: AppColors.primary),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text("Dashboard"),
              selected: currentIndex == 0,
              onTap: () {
                Navigator.pop(context);
                changePage(0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.inventory_2),
              title: const Text("Products"),
              selected: currentIndex == 2,
              onTap: () {
                Navigator.pop(context);
                changePage(2);
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text("Customers"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, Routes.customers);
              },
            ),
            ListTile(
              leading: const Icon(Icons.receipt_long),
              title: const Text("Sales"),
              selected: currentIndex == 1,
              onTap: () {
                Navigator.pop(context);
                changePage(1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text("Reports"),
              selected: currentIndex == 3,
              onTap: () {
                Navigator.pop(context);
                changePage(3);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              selected: currentIndex == 4,
              onTap: () {
                Navigator.pop(context);
                changePage(4);
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(index: currentIndex, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textLight,
        type: BottomNavigationBarType.fixed,
        onTap: changePage,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Sales',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class DashboardHomeTab extends StatelessWidget {
  const DashboardHomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Welcome back,', style: AppTextStyles.small),
                    SizedBox(height: 4),
                    Text('BizBook Manager', style: AppTextStyles.heading1),
                    SizedBox(height: 8),
                    Text(
                      'Your business dashboard is ready to manage sales, inventory, and reports.',
                      style: AppTextStyles.body,
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(12),
                child: const Icon(
                  Icons.business_center,
                  color: AppColors.primary,
                  size: 28,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            onChanged: (_) {},
            decoration: InputDecoration(
              hintText: 'Search products, customers, invoices...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: AppColors.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 24),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: MediaQuery.of(context).size.width > 800 ? 4 : 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.2,
            children: const [
              SummaryCard(
                icon: Icons.attach_money,
                title: 'Today Sales',
                value: ' 7,500',
                subtitle: '+18% from yesterday',
                iconColor: AppColors.primary,
              ),
              SummaryCard(
                icon: Icons.shopping_cart,
                title: 'Orders',
                value: '128',
                subtitle: 'Active invoices',
                iconColor: AppColors.secondary,
              ),
              SummaryCard(
                icon: Icons.inventory_2,
                title: 'Products',
                value: '45',
                subtitle: 'Low stock 6 items',
                iconColor: AppColors.accent,
              ),
              SummaryCard(
                icon: Icons.people,
                title: 'Customers',
                value: '128',
                subtitle: 'Returning clients',
                iconColor: AppColors.primary,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text('Quick Actions', style: AppTextStyles.heading2),
          const SizedBox(height: 12),
          Wrap(
            runSpacing: 12,
            spacing: 12,
            children: [
              _ActionChip(
                label: 'Add Product',
                icon: Icons.inventory_2,
                color: AppColors.secondary,
                onTap: () => Navigator.pushNamed(context, Routes.products),
              ),
              _ActionChip(
                label: 'New Sale',
                icon: Icons.receipt_long,
                color: AppColors.primary,
                onTap: () => Navigator.pushNamed(context, Routes.sales),
              ),
              _ActionChip(
                label: 'View Reports',
                icon: Icons.bar_chart,
                color: AppColors.accent,
                onTap: () => Navigator.pushNamed(context, Routes.reports),
              ),
              _ActionChip(
                label: 'Manage Customers',
                icon: Icons.people,
                color: AppColors.primary,
                onTap: () => Navigator.pushNamed(context, Routes.customers),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text('Recent Activity', style: AppTextStyles.heading2),
          const SizedBox(height: 12),
          Column(
            children: const [
              _ActivityTile(
                icon: Icons.shopping_cart,
                title: 'Sale completed',
                subtitle: 'Invoice #INV-1024',
                amount: '+\$450',
                color: AppColors.success,
              ),
              SizedBox(height: 12),
              _ActivityTile(
                icon: Icons.inventory_2,
                title: 'Stock updated',
                subtitle: 'Added 20 new items',
                amount: '',
                color: AppColors.secondary,
              ),
              SizedBox(height: 12),
              _ActivityTile(
                icon: Icons.people,
                title: 'New customer added',
                subtitle: 'Ahmad Khan',
                amount: '',
                color: AppColors.primary,
              ),
              SizedBox(height: 12),
              _ActivityTile(
                icon: Icons.payments,
                title: 'Payment received',
                subtitle: 'From Ali Traders',
                amount: '+\$1,200',
                color: AppColors.accent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  const _ActionChip({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(label),
      labelStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: color,
      avatar: Icon(icon, color: Colors.white, size: 18),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      onPressed: onTap,
    );
  }
}

class _ActivityTile extends StatelessWidget {
  const _ActivityTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String amount;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.15),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: amount.isEmpty
            ? null
            : Text(
                amount,
                style: TextStyle(color: color, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
