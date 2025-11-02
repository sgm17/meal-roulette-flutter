import 'package:flutter/material.dart';
import 'package:meal_roulette/configs/resources/resources.dart';
import 'package:meal_roulette/configs/resources/sizing.dart';
import 'package:meal_roulette/routes/app_routes.dart';

class CustomButton extends StatelessWidget {
  final int widthPartitions;
  final int index;
  final bool isSelected;
  final String text;
  final Color bgUnselectedButtonColor;
  final Color bgSelectedBorderColor;
  final Color bgUnselectedBorderColor;
  final Function() onPressed;

  const CustomButton({super.key, required this.widthPartitions, required this.index, required this.isSelected, required this.bgUnselectedButtonColor, required this.bgSelectedBorderColor, required this.bgUnselectedBorderColor, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        width: ((MediaQuery.sizeOf(getContext()).width) / widthPartitions) - 20,
        duration: Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isSelected ? R.colors.bgSelectedTab : bgUnselectedButtonColor,
          borderRadius: BorderRadius.circular(30.0),
          border: isSelected ? Border.all(color: bgSelectedBorderColor, width: 1) : Border.all(color: bgUnselectedBorderColor),
        ),
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
        margin: EdgeInsets.fromLTRB(0, 0, 5.w, 0),
        child: Text(
          text,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
          textAlign: TextAlign.center,
          style: isSelected ? R.textStyles.font12B.copyWith(color: R.colors.bgButtons) : R.textStyles.font12M.copyWith(color: R.colors.black_50),
        ),
      ),
    );
  }
}
