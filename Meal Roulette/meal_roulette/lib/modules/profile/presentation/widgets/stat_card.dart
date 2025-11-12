import 'package:flutter/material.dart';
import 'package:meal_roulette/configs/resources/resources.dart';
import 'package:meal_roulette/configs/resources/sizing.dart';

/// Small stat card used in the dashboard row. Uses AnimatedContainer & AnimatedOpacity
/// to provide subtle motion on rebuilds and when pressed.
class StatCard extends StatefulWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;

  const StatCard({super.key, required this.title, required this.value, required this.color, required this.icon});

  @override
  State<StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<StatCard> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Shadow layer only
          Positioned.fill(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 2.w),
               decoration: BoxDecoration(
                 color: R.colors.white ,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: R.colors.red.withValues(alpha: 0.1), blurRadius: 5, offset: Offset(-3, 3))],
              ),
            ),
          ),
          // Foreground layer (no blending with shadow)
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutCubic,
            margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 2.w),
            padding: EdgeInsets.all(4.h),
            decoration: BoxDecoration(
              color: widget.color == R.colors.textBlack ? R.colors.veryLightGrey : widget.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: widget.color == R.colors.textBlack ? R.colors.dividerBorderColor : widget.color.withValues(alpha: 0.2), width: 1),
            ),
            width: 120.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(widget.icon, size: 25.sp, color: widget.color),
                Text(widget.value, style: R.textStyles.font18B.copyWith(color: widget.color)),
                Text(widget.title, style: R.textStyles.font8R.copyWith(color: R.colors.textGrey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
