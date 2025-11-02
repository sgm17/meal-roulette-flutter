import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meal_roulette/configs/resources/resources.dart';
import 'package:meal_roulette/configs/resources/sizing.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key, required this.title, required this.onPressed});
  final String? title;
  final Function() onPressed;

  @override
  Size get preferredSize => Size.fromHeight(70.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: R.colors.white,
      centerTitle: true,
      leading: Padding(
        padding: EdgeInsets.only(left: 20.w),
        child: GestureDetector(
          onTap: onPressed,
          child: SvgPicture.asset(
            R.assets.appBarLogo,
            width: 35,
            height: 35,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
      title: Text(
        title ?? '--',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: true,
        style: R.textStyles.font22M.copyWith(color: R.colors.black, fontWeight: FontWeight.w700),
      ),
    );
  }
}
