import 'package:flutter/material.dart';

import '../../../../../res/app_default.dart';
import '../../../../../services/preferences/utils/pref_operations.dart';
import '../res/animation_keys.dart';
import '../res/curve_string.dart';

bool getAnimationUtils_isAnimationEnabled() {
  return readPrefBool(SAnimationKeys.animation_enabled) ?? true;
}

Curve getCurveFromString(String? curveName) {
  curveName ??= SResourses.animationCurve;
  return curveStrings
      .where((element) => element.curveName == curveName)
      .first
      .curve;
}

String getStringFromCurve(Curve curve) {
  return curveStrings
      .where((element) => element.curve == curve)
      .first
      .curveName;
}
