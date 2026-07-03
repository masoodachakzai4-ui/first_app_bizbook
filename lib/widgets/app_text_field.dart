// ============================================================================
// File: widgets/app_text_field.dart
// Purpose: Reusable custom text input field for the entire app
// Description: Instead of creating text fields repeatedly, we create one
//              custom text field widget. This ensures all text inputs in
//              the app look and behave consistently.
// ============================================================================

import 'package:flutter/material.dart';
import '../app/theme.dart';

class AppTextField extends StatefulWidget {
  // Properties
  final String label; // Label/hint text
  final TextEditingController controller; // To access the value typed
  final String? Function(String?)? validator; // Function to validate input
  final TextInputType keyboardType; // Type of keyboard (email, number, etc.)
  final bool obscureText; // Hide text (for passwords)
  final int maxLines; // Maximum lines (1 for single line, null for multiple)
  final IconData? prefixIcon; // Icon to show inside the field
  final Widget? suffixIcon; // Icon to show at the end (like show/hide password)

  const AppTextField({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  // Variable to track if field has focus
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          _isFocused = hasFocus;
        });
      },
      child: TextFormField(
        // Connect to controller
        controller: widget.controller,

        // Set keyboard type
        keyboardType: widget.keyboardType,

        // Hide text if needed (for password fields)
        obscureText: widget.obscureText,

        // Maximum lines
        maxLines: widget.obscureText ? 1 : widget.maxLines,
        minLines: 1,

        // Validation function
        validator: widget.validator,

        // Field decoration (styling)
        decoration: InputDecoration(
          // Show label
          labelText: widget.label,

          // Prefix icon
          prefixIcon: widget.prefixIcon != null
              ? Icon(widget.prefixIcon)
              : null,

          // Suffix icon
          suffixIcon: widget.suffixIcon,

          // Helper text
          helperText: '',
        ),

        // Text style
        style: AppTextStyles.body,
      ),
    );
  }
}
