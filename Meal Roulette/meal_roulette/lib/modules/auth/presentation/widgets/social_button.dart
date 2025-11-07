import 'package:flutter/material.dart';
import 'package:meal_roulette/configs/resources/resources.dart';

/// Minimal social CTA using an outlined pill. Hover/press friendly and accessible.
class SocialButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  const SocialButton({super.key, required this.label, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18, color: cs.onSurface),
      label: Text(label, style: TextStyle(color: cs.onSurface)),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: R.colors.textGrey.withValues(alpha: 0.5)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      ),
    );
  }
}
