import 'package:flutter/material.dart';
import 'package:meal_roulette/configs/resources/resources.dart';

class CustomAvatar extends StatelessWidget {
  final double? radius;
  final Color? borderColor, backgroundColor;
  final bool isBorder;
  final Widget? child;
  const CustomAvatar({super.key, this.radius, this.borderColor, this.isBorder = true, this.child, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (radius ?? 23) * 2,
      width: (radius ?? 23) * 2,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        shape: BoxShape.circle,
        border: isBorder
            ? Border.all(
                width: 1,
                color: borderColor ?? R.colors.lightGreyColor,
              )
            : null,
      ),
      child: child,
    );
  }
}
