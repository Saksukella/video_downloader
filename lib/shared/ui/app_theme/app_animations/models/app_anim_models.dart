import 'package:flutter/material.dart';

import '../../../../res/app_default.dart';
import '../../../../services/preferences/utils/pref_operations.dart';
import '../../customization/animation/Utils/values.dart';

class AppAnimModels {
  late int animDuration;
  late Curve animCurve;
  List<String> keys;

  AppAnimModels({
    required this.keys,
  }) {
    animDuration = readPrefInt(keys[0]) ?? SResourses.animationDuration;
    animCurve = getCurveFromString(readPrefString(keys[1]));
  }
}
