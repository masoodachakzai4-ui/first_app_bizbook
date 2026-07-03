// ============================================================================
// File: widgets/empty_state.dart
// Purpose: Reusable widget to show when there is no data
// Description: When a list is empty, instead of showing blank screen,
//              show this empty state with icon, message, and optional button.
// ============================================================================

import 'package:flutter/material.dart';
import '../app/theme.dart';
import 'app_button.dart';

class EmptyState extends StatelessWidget {
  // Properties
  final IconData icon; // Icon to display
  final String title; // Title message
  final String subtitle; // Subtitle/description
  final String? buttonLabel; // Button text (optional)
  final VoidCallback? onButtonPressed; // Button action (optional)

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.buttonLabel,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                icon,
                size: 60,
                color: AppColors.primary.withValues(alpha: 0.5),
              ),
            ),
            const SizedBox(height: 24),
            // Title
            Text(
              title,
              style: AppTextStyles.heading2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            // Subtitle
            Text(
              subtitle,
              style: AppTextStyles.small,
              textAlign: TextAlign.center,
            ),
            // Button (if provided)
            if (buttonLabel != null && onButtonPressed != null) ...[
              const SizedBox(height: 32),
              SizedBox(
                width: 200,
                child: AppButton(
                  label: buttonLabel!,
                  onPressed: onButtonPressed!,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
