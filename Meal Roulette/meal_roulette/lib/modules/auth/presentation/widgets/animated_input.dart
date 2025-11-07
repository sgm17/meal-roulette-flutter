import 'package:flutter/material.dart';
import 'package:meal_roulette/configs/resources/resources.dart';
import 'package:meal_roulette/configs/resources/sizing.dart';

/// A compact pill-like TextFormField wrapped with AnimatedContainer.
/// Designed to exactly match the pill inputs in the design (reduced vertical padding).
class AnimatedInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;

  const AnimatedInput({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: R.colors.white, // default background
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: R.textStyles.font11M.copyWith(color: R.colors.textBlack),
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: R.textStyles.font11M.copyWith(color: R.colors.textBlack),
          hintText: hint,
          hintStyle: R.textStyles.font11M.copyWith(color: R.colors.textGrey),
          filled: true,
          fillColor: R.colors.white,
          isDense: true,
          isCollapsed: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h), // compact vertical padding
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: R.colors.textGrey.withValues(alpha: 0.2), width: 1)),
          enabledBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: R.colors.textGrey.withValues(alpha: 0.2), width: 1)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: R.colors.textGrey.withValues(alpha: 0.2), width: 1)),
          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: R.colors.textGrey.withValues(alpha: 0.2), width: 1)),
        ),
      ),
    );
  }
}
