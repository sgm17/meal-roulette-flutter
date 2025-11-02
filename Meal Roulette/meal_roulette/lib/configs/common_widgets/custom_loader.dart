import 'package:flutter/material.dart';
import 'package:meal_roulette/configs/resources/resources.dart';
import 'package:meal_roulette/configs/resources/sizing.dart';
import 'package:meal_roulette/configs/utils/localization_extension.dart';

class LoaderWidget extends StatelessWidget {
  final String message;
  final bool isLoading;

  const LoaderWidget({super.key, this.message = "Loading...", required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 5.h,
            ),
            if (isLoading)
              SizedBox(
                  height: 25.h,
                  width: 25.w,
                  child: CircularProgressIndicator(
                    color: R.colors.hintColor,
                    strokeWidth: 5,
                  )),
            SizedBox(
              height: 5.h,
            ),
            Text(
              isLoading ? R.strings.pleaseWait.L() : message,
              style: R.textStyles.font14R,
            ),
          ],
        ),
      ),
    );
  }
}
