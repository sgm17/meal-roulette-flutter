import 'package:flutter/material.dart';
import 'package:meal_roulette/configs/resources/resources.dart';
import 'package:meal_roulette/configs/resources/sizing.dart';

/// Small bullet-style features row used for amenities list.
class FeatureRow extends StatelessWidget {
  final String text;

  const FeatureRow(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.circle, size: 8.sp, color: R.colors.red,),
        SizedBox(width: 8.w),
        Text(text, style: R.textStyles.font11R.copyWith(
          color: R.colors.textBlack,
        ),),
        SizedBox(width: 30.w),
      ],
    );
  }
}
