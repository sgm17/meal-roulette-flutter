import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_roulette/configs/resources/resources.dart';
import 'package:meal_roulette/configs/resources/sizing.dart';
import 'package:meal_roulette/modules/matching/data/models/matching_models.dart';
import 'package:meal_roulette/modules/matching/presentation/widgets/contact_row.dart';

class ProfileDetailSection extends StatelessWidget {
  final MatchingModel match;
  const ProfileDetailSection({required this.match});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: 1,
      duration: const Duration(milliseconds: 400),
      child: Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(color: Colors.grey.shade300),
            SizedBox(height: 4.h),
            Text(
              "Contact Information",
              style: R.textStyles.font10R.copyWith(color: R.colors.textGrey),
            ),
            SizedBox(height: 8.h),

            ContactRow(
              icon: Icons.email_outlined,
              label: match.email,
              color: R.colors.veryLightGrey.withValues(alpha: 0.5),
              textColor: R.colors.textBlack, iconColor: R.colors.red, heading: 'Email', iconBackGroundColor: R.colors.red.withValues(alpha: 0.1),
            ),
            SizedBox(height: 8.h),
            ContactRow(
              icon: Icons.phone_outlined,
              label: match.phone,
              color: R.colors.veryLightGrey.withValues(alpha: 0.5),
              textColor: R.colors.textBlack, iconColor: R.colors.green, heading: 'Phone', iconBackGroundColor: R.colors.green.withValues(alpha: 0.1),
            ),
            SizedBox(height: 8.h),

            Container(
              decoration: BoxDecoration(
                color: R.colors.secondaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: BoxBorder.all(width: 0.5, color: R.colors.secondaryColor.withValues(alpha: 0.2)),
              ),
              padding: EdgeInsets.symmetric(vertical:  8.h, horizontal: 12.w),
              child: Row(
                children: [
                  Icon(Icons.calendar_today_outlined, size: 16.sp, color: R.colors.secondaryColor),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      "Lunch Date: ${match.lunchDate}",
                      style: R.textStyles.font12M.copyWith(color: R.colors.secondaryColor),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
