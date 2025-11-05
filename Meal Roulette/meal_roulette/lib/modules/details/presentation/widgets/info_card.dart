import 'package:flutter/material.dart';
import 'package:meal_roulette/configs/resources/resources.dart';
import 'package:meal_roulette/configs/resources/sizing.dart';

/// Reusable info card with a title, subtitle and optional trailing widget.
/// Uses AnimatedContainer to subtly animate when rebuilt (theme changes / selection).
class InfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String peakHours;
  final IconData icon;
  final Widget? trailing;

  const InfoCard({
    super.key,
    required this.title,
    required this.peakHours,
    required this.subtitle,
    required this.icon,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeInOut,
      padding: EdgeInsets.all(12.h),
      decoration: BoxDecoration(
        color: R.colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: R.colors.textGrey.withValues(alpha: 0.2)),
      ),
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: R.colors.textBlack, size: 16.sp,),
                  SizedBox(width: 8.w),
                  Text(title, style: R.textStyles.font12B),
                ],
              ),
              SizedBox(height: 16.h),
              Text(subtitle, style: R.textStyles.font10R),
              SizedBox(height: 4.h),
              Text(peakHours, style: R.textStyles.font9R.copyWith(color: R.colors.textGrey)),
              SizedBox(height: 4.h),
              if (trailing != null) trailing!,
            ],
          ),


    );
  }
}
