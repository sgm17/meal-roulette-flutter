import 'package:flutter/material.dart';
import 'package:meal_roulette/configs/resources/resources.dart';
import 'package:meal_roulette/configs/resources/sizing.dart';

class CustomTabItem extends StatelessWidget {
  final int index;
  final bool isSelected;
  final String text;
  final Color bgUnselectedButtonColor;
  final Function() onPressed;

  const CustomTabItem({super.key, required this.onPressed, required this.index, required this.isSelected, required this.text, required this.bgUnselectedButtonColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isSelected ? R.colors.bgSelectedTab : bgUnselectedButtonColor,
          borderRadius: BorderRadius.circular(30.0),
          border: isSelected ? Border.all(color: R.colors.bgButtons, width: 1) : Border.all(color: Colors.transparent),
        ),
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
          textAlign: TextAlign.center,
          style: isSelected ? R.textStyles.font12B.copyWith(color: R.colors.bgButtons) : R.textStyles.font12M.copyWith(color: R.colors.black_50),
        ),
      ),
    );
  }
}
