

import 'package:meal_roulette/configs/resources/localization/app_localization.dart';

extension Localize on String {
  String L() {
    return LocalizationMap.getTranslatedValues(this);
  }
}
