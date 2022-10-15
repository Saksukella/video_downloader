import 'package:flutter/material.dart';

import '../../customization/theme/utils/color_utils.dart';

ThemeData userSpesificColors(ThemeData themeData) {
  return themeData.copyWith(
    drawerTheme: DrawerThemeData(
      backgroundColor: themeUtils_getBackgroundColor(),
    ),
    textTheme: themeData.textTheme.apply(bodyColor: themeUtils_getTextColor()),
    cardColor: themeUtils_getCardColor(),
    listTileTheme: themeData.listTileTheme.copyWith(
        iconColor: themeUtils_getListTileIconColor(),
        tileColor: themeUtils_getListTileColor(),
        textColor: themeUtils_getTextColor()),
    iconTheme: themeData.iconTheme.copyWith(
      color: themeUtils_getIconColor(),
    ),
    dialogBackgroundColor: themeUtils_getBackgroundColor(),
    backgroundColor: themeUtils_getBackgroundColor(),
    scaffoldBackgroundColor: themeUtils_getBackgroundColor(),
  );
}
