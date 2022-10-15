import 'dart:developer';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/res/flex_list.dart';
import '../../../theme/themes.dart';
import '../../../theme/utils/theme_utils.dart';
import '../utils/color_utils.dart';
import '../utils/default_colors.dart';

class SCustomThemeController extends GetxController {
  late Rx<ThemeData> _themeData;
  Rx<int> _schemeIndex = themeUtils_getSchemeIndex().obs;
  SCustomThemeController() {
    _themeData = theme.copyWith().obs;
  }

  Color getTextColor() => _themeData.value.textTheme.bodyText1!.color!;

  Color getIconColor() => _themeData.value.iconTheme.color!;

  Color getCardColor() => _themeData.value.cardColor;

  Color getBackgroundColor() => _themeData.value.backgroundColor;

  Color getListTileColor() =>
      _themeData.value.listTileTheme.tileColor ?? Colors.transparent;

  Color getListTileIconColor() =>
      _themeData.value.listTileTheme.iconColor ??
      defaultThemeUtils_ListTileIconColor();

  ThemeData get getThemeData {
    if (themes.isDark) {
      return FlexColorScheme.dark(
        scheme: schemeList()[_schemeIndex.value].scheme,
      ).toTheme;
    } else {
      return FlexColorScheme.light(
        scheme: schemeList()[_schemeIndex.value].scheme,
      ).toTheme;
    }
  }

  int getSchemeIndex() => _schemeIndex.value;

  set setThemeData(ThemeData themeData) => _themeData.value = themeData;

  void setColorScheme(int i) {
    _schemeIndex.value = i;
    Themes themes = Get.find();
    late FlexColorScheme flexColorScheme;

    if (themes.isDark) {
      flexColorScheme = FlexColorScheme.dark(
        scheme: schemeList()[i].scheme,
      );
    } else {
      flexColorScheme = FlexColorScheme.light(
        scheme: schemeList()[i].scheme,
      );
    }
    _themeData.value = _themeData.value.copyWith(
      colorScheme: flexColorScheme.toScheme,
    );
  }

  set setTextColor(Color color) {
    _themeData.value = _themeData.value.copyWith(
        textTheme: _themeData.value.textTheme.apply(
      bodyColor: color,
    ));
  }

  set setIconColor(Color color) {
    _themeData.value = _themeData.value.copyWith(
      iconTheme: _themeData.value.iconTheme.copyWith(color: color),
    );
  }

  set setCardColor(Color color) {
    _themeData.value = _themeData.value.copyWith(
      cardColor: color,
    );
  }

  set setBackgroundColor(Color color) {
    _themeData.value = _themeData.value.copyWith(
      backgroundColor: color,
      scaffoldBackgroundColor: color,
      dialogBackgroundColor: color,
    );
  }

  set setListTileColor(Color color) {
    _themeData.value = _themeData.value.copyWith(
      listTileTheme: ListTileThemeData(
        tileColor: color,
      ),
    );
  }

  set setListTileIconColor(Color color) {
    _themeData.value = _themeData.value.copyWith(
      listTileTheme: ListTileThemeData(
        iconColor: color,
      ),
    );
  }

  void resetAllSubthemes() {
    Themes themes = Get.find();

    setTextColor = defaultThemeUtils_TextColor();
    setIconColor = defaultThemeUtils_IconColor();
    setCardColor = defaultThemeUtils_CardColor();
    setBackgroundColor = defaultThemeUtils_BackgroundColor();
    setListTileColor = defaultThemeUtils_ListTileColor();
    setListTileIconColor = defaultThemeUtils_ListTileIconColor();

    themeUtils_setTextColor(getTextColor());
    themeUtils_setIconColor(getIconColor());
    themeUtils_setCardColor(getCardColor());
    themeUtils_setBackgroundColor(getBackgroundColor());
    themeUtils_setListTileColor(getListTileColor());
    themeUtils_setListTileIconColor(getListTileIconColor());

    themes.setThemeData = _themeData.value;
  }

  void resetSchemeIndex() {
    _schemeIndex.value = 10;
    saveSchemeIndex();
  }

  void resetAll() {
    resetAllSubthemes();
    resetSchemeIndex();
  }

  void saveAll() {
    saveSchemeIndex();
    saveAllSubThemes();
  }

  void saveSchemeIndex() {
    Themes themes = Get.find();
    themeUtils_setSchemeIndex(_schemeIndex.value);
    themes.schemeIndex = _schemeIndex.value;
  }

  void saveAllSubThemes() {
    log("message");
    saveTextColor();
    saveIconColor();
    saveCardColor();
    saveBackgroundColor();
    saveListTileColor();
    saveListTileIconColor();
  }

  void saveTextColor() {
    Themes themes = Get.find();
    if (getTextColor() == getCardColor() ||
        getTextColor() == getBackgroundColor()) {
      setTextColor = defaultThemeUtils_TextColor();
    }

    themeUtils_setTextColor(getTextColor());
    themes.setTextColor = getTextColor();
  }

  void saveIconColor() {
    Themes themes = Get.find();
    if (getIconColor() == getCardColor() ||
        getIconColor() == getBackgroundColor()) {
      setIconColor = defaultThemeUtils_IconColor();
    }
    themeUtils_setIconColor(getIconColor());
    themes.setIconColor = getIconColor();
  }

  void saveCardColor() {
    Themes themes = Get.find();
    if (getCardColor() == getTextColor()) {
      setCardColor = defaultThemeUtils_CardColor();
    }
    themeUtils_setCardColor(getCardColor());
    themes.setCardColor = getCardColor();
  }

  void saveBackgroundColor() {
    Themes themes = Get.find();
    if (getBackgroundColor() == getTextColor() ||
        getBackgroundColor() == getIconColor()) {
      setBackgroundColor = defaultThemeUtils_BackgroundColor();
    }
    themeUtils_setBackgroundColor(getBackgroundColor());
    themes.setBackgroundColor = getBackgroundColor();
  }

  void saveListTileColor() {
    Themes themes = Get.find();
    if (getListTileColor() == getTextColor() ||
        getListTileColor() == getListTileIconColor()) {
      setListTileColor = defaultThemeUtils_ListTileColor();
    }
    themeUtils_setListTileColor(getListTileColor());
    themes.setListTileColor = getListTileColor();
  }

  void saveListTileIconColor() {
    Themes themes = Get.find();
    if (getListTileIconColor() == getListTileColor() ||
        getListTileIconColor() == getCardColor()) {
      setListTileIconColor = defaultThemeUtils_ListTileIconColor();
    }
    themeUtils_setListTileIconColor(getListTileIconColor());
    themes.setListTileIconColor = getListTileIconColor();
  }
}
