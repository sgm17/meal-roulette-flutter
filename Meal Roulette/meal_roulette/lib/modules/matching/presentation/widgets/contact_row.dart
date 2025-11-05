import 'package:flutter/cupertino.dart';
import 'package:meal_roulette/configs/resources/resources.dart';
import 'package:meal_roulette/configs/resources/sizing.dart';

class ContactRow extends StatelessWidget {
  final IconData icon;
  final String heading;
  final String label;
  final Color color;
  final Color iconColor;
  final Color textColor;
  final Color iconBackGroundColor;

  const ContactRow({
    required this.icon,
    required this.label,
    required this.color,
    required this.textColor, required this.iconColor, required this.heading, required this.iconBackGroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
      BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Row(
        children: [
          ClipOval(child: Container(color: iconBackGroundColor, padding: EdgeInsets.all(7), child: Icon(size: 15, icon, color: iconColor))),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  heading,
                  style: R.textStyles.font9R.copyWith(color: R.colors.textGrey),
                ),
                Text(
                  label,
                  style: R.textStyles.font11M.copyWith(color: textColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}