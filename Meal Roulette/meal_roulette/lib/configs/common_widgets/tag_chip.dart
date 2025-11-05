import 'package:flutter/material.dart';
import 'package:meal_roulette/configs/resources/resources.dart';
import 'package:meal_roulette/configs/resources/sizing.dart';

/// Small pill-style chip implemented with Container to allow exact control.
/// Includes tap animation (scale + shadow) using GestureDetector and AnimatedScale.
class TagChip extends StatefulWidget {
  final String label;
  final Color color;
  final Color textColor;

  const TagChip({
    super.key,
    required this.label,
    required this.color,
    required this.textColor,
  });

  @override
  State<TagChip> createState() => _TagChipState();
}

class _TagChipState extends State<TagChip> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        widget.label,
        style: R.textStyles.font11M.copyWith(
          color: widget.textColor,
          height: 1.2, // tighter line height for a compact tag look
        ),
      ),
    );
  }
}
