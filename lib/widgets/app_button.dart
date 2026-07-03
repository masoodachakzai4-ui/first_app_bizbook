// ============================================================================
// File: widgets/app_button.dart
// Purpose: Reusable custom button widget for the entire app
// Description: Instead of creating buttons repeatedly, we create one custom
//              button widget that follows the app's design. This button
//              can be used everywhere with different labels and actions.
// ============================================================================

import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  // Properties of the button
  final String label; // Text to show on button
  final VoidCallback onPressed; // Function to call when button is pressed
  final bool isLoading; // Show loading spinner
  final double width; // Button width
  final double height; // Button height

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.width = double.infinity, // Full width by default
    this.height = 50, // Default height
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            // Show spinner while loading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              )
            // Show text normally
            : Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
