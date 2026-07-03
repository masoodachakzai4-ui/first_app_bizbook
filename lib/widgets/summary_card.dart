// ============================================================================
// File: widgets/summary_card.dart
// Purpose: Reusable card widget to display summary information
// Description: Used in dashboard to show key metrics like total sales,
//              pending dues, etc. This card displays an icon, title, and value.
// ============================================================================

import 'package:flutter/material.dart';
import '../app/theme.dart';

class SummaryCard extends StatelessWidget {
  // Properties
  final IconData icon; // Icon to display
  final String title; // Title of the card
  final String value; // Main value to display
  final String subtitle; // Additional info (optional)
  final Color? backgroundColor; // Card background color
  final Color? iconColor; // Icon color
  final VoidCallback? onTap; // Function when card is tapped

  const SummaryCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.subtitle = '',
    this.backgroundColor,
    this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: backgroundColor ?? Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon and title row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title
                  Expanded(
                    child: Text(
                      title,
                      style: AppTextStyles.small,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // Icon
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: (iconColor ?? AppColors.primary).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      icon,
                      color: iconColor ?? AppColors.primary,
                      size: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Value
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              // Subtitle (optional)
              if (subtitle.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: AppTextStyles.small,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
