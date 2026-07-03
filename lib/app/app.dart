import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/customer_provider.dart';
import '../providers/product_provider.dart';
import '../screens/auth/auth_screen.dart';
import '../screens/customers/customers_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/payments/payments_screen.dart';
import '../screens/products/products_screen.dart';
import '../screens/purchases/purchases_screen.dart';
import '../screens/reports/reports_screen.dart';
import '../screens/sales/sales_screen.dart';
import '../screens/settings/settings_detail_screens.dart';
import '../screens/settings/settings_screen.dart';
import 'routes.dart';
import 'theme.dart';

class BizBookApp extends StatefulWidget {
  const BizBookApp({super.key});

  @override
  State<BizBookApp> createState() => _BizBookAppState();
}

class _BizBookAppState extends State<BizBookApp> {
  late final ProductProvider productProvider;
  late final CustomerProvider customerProvider;

  @override
  void initState() {
    super.initState();
    productProvider = ProductProvider();
    customerProvider = CustomerProvider();
    productProvider.loadProducts();
    customerProvider.loadCustomers();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: productProvider),
        ChangeNotifierProvider.value(value: customerProvider),
      ],
      child: MaterialApp(
        title: 'BizBook',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.splash,
        routes: {
          Routes.splash: (context) => const SplashScreen(),
          Routes.welcome: (context) => const WelcomeScreen(),
          Routes.login: (context) => const LoginScreen(),
          Routes.dashboard: (context) => const DashboardScreen(),
          Routes.products: (context) => const ProductsScreen(),
          Routes.customers: (context) => const CustomersScreen(),
          Routes.sales: (context) => const SalesScreen(),
          Routes.purchases: (context) => const PurchasesScreen(),
          Routes.payments: (context) => const PaymentsScreen(),
          Routes.reports: (context) => const ReportsScreen(),
          Routes.settings: (context) => const SettingsScreen(),
          Routes.businessProfile: (context) => const BusinessProfileScreen(),
          Routes.themeSettings: (context) => const ThemeSettingsScreen(),
          Routes.securitySettings: (context) => const SecuritySettingsScreen(),
        },
      ),
    );
  }
}
