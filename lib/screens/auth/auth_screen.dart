// ============================================================================
// File: screens/auth/auth_screen.dart
// Purpose: Authentication screens including splash, welcome, and login
// Description: This file contains three screens:
//              1. SplashScreen - Initial loading screen
//              2. WelcomeScreen - Welcome with app intro
//              3. LoginScreen - Login form
// ============================================================================

import 'package:flutter/material.dart';
import '../../app/routes.dart';
import '../../app/theme.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, Routes.welcome);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.business_center, size: 90, color: Colors.white),
            SizedBox(height: 20),
            Text(
              'BizBook',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Business made simple',
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 24),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Icon(
                        Icons.storefront,
                        size: 80,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Welcome to BizBook',
                      style: AppTextStyles.heading1,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Manage products, customers, sales, and reports from one clean dashboard.',
                      style: AppTextStyles.small,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    _FeatureItem(
                      icon: Icons.inventory_2,
                      title: 'Inventory control',
                      description: 'Track stock and reorder points',
                    ),
                    const SizedBox(height: 12),
                    _FeatureItem(
                      icon: Icons.person_outline,
                      title: 'Customer relationships',
                      description:
                          'Keep customer info and balances in one place',
                    ),
                    const SizedBox(height: 12),
                    _FeatureItem(
                      icon: Icons.receipt_long,
                      title: 'Fast invoicing',
                      description: 'Create sales and review reports quickly',
                    ),
                  ],
                ),
              ),
              AppButton(
                label: 'Get Started',
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, Routes.login),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController(text: 'admin@bizbook.com');
  final passwordController = TextEditingController(text: '1234');
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool showPassword = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> handleLogin() async {
    if (!formKey.currentState!.validate()) return;
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() => isLoading = false);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Login successful!')));
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.dashboard,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.lock_outline,
                    size: 60,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 24),
                const Text('Login to BizBook', style: AppTextStyles.heading2),
                const SizedBox(height: 8),
                const Text(
                  'Use your business credentials to continue.',
                  style: AppTextStyles.small,
                ),
                const SizedBox(height: 24),
                AppTextField(
                  label: 'Email or Phone',
                  controller: emailController,
                  prefixIcon: Icons.email,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email or phone';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AppTextField(
                  label: 'Password',
                  controller: passwordController,
                  prefixIcon: Icons.lock,
                  obscureText: !showPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () =>
                        setState(() => showPassword = !showPassword),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 4) {
                      return 'Password must be at least 4 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                AppButton(
                  label: 'Login',
                  isLoading: isLoading,
                  onPressed: handleLogin,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.primary),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.body),
              const SizedBox(height: 4),
              Text(description, style: AppTextStyles.small),
            ],
          ),
        ),
      ],
    );
  }
}

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: const [MaterialPage(child: SplashScreen())],
      onPopPage: (route, result) => false,
    );
  }
}
