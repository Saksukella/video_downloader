import 'package:flutter/cupertino.dart';

import '../../../../../../res/app_default.dart';
import '../../../../../../services/preferences/utils/pref_operations.dart';
import '../res/data.dart';
import '../res/keys.dart';

TextStyle textStyleUtils_textStyle(String? styleText) {
  String t = styleText ?? textStyleUtils_textStyleName();
  late TextStyle textStyle;
  appTextStyles.forEach((element) {
    if (element.name == t) {
      textStyle = element.textStyle;
    }
  });
  return textStyle;
}

String textStyleUtils_textStyleName() {
  return readPrefString(TextStyleKeys.TEXT_STYLE) ?? SResourses.txtstyleText;
}

void textStyleUtils_setTextStyle(String styleText) {
  writePrefString(TextStyleKeys.TEXT_STYLE, styleText);
}
