import 'package:flutter/material.dart';
import 'package:meal_roulette/routes/app_routes.dart';

BuildContext appContext() => rootNavigatorKey.currentState!.context;

class CustomSizes {
  var viewPortWidth = 428;
  var viewPortHeight = 926;

  /// The ratio of actual width to UI design
  double get scaleWidth => MediaQuery.of(rootNavigatorKey.currentContext!).size.width / viewPortWidth;

  ///  /// The ratio of actual height to UI design
  double get scaleHeight => screenHeight / viewPortHeight;

  double get scaleText => scaleWidth;
  double get screenWidth => MediaQuery.of(rootNavigatorKey.currentContext!).size.width;

  ///The vertical extent of this size. dp
  double get screenHeight => MediaQuery.of(rootNavigatorKey.currentContext!).size.height;

  /// Adapted to the device width of the UI Design.
  /// Height can also be adapted according to this to ensure no deformation ,
  /// if you want a square
  double setWidth(num width) => width * scaleWidth;

  /// Highly adaptable to the device according to UI Design
  /// It is recommended to use this method to achieve a high degree of adaptation
  /// when it is found that one screen in the UI design
  /// does not match the current style effect, or if there is a difference in shape.
  double setHeight(num height) => height * scaleHeight;

  ///Font size adaptation method
  ///- [fontSize] The size of the font on the UI design, in dp.
  double setSp(num fontSize) => fontSize * scaleText;
}

extension SizeExtension on num {
  ///Multiple of screen width
  double get sw => CustomSizes().screenWidth * this;

  ///Multiple of screen height
  double get sh => CustomSizes().screenHeight * this;

  ///[CustomSizes.setWidth]
  double get w => CustomSizes().setWidth(this);

  ///[ScreenUtil.setHeight]
  double get h => CustomSizes().setHeight(this);

  ///[ScreenUtil.setSp]
  double get sp => CustomSizes().setSp(this);
}
