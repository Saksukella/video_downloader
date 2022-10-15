import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'res/flex_list.dart';
import 'subthemes/texts/text_style.dart';
import 'utils/theme_utils.dart';

class Themes extends GetxController {
  static late int _textSize;
  final _schemeIndex = themeUtilsSchemeIndex().obs;
  static late Rx<ThemeData> _themeData;
  static late bool _isDark;

  bool get isDark => _isDark;

  ThemeData get themeData => _themeData.value;

  TextTheme get textTheme => _themeData.value.textTheme;

  int get schemeIndex => _schemeIndex.value;

  int get textSize => _textSize;

  set textStyle(TextStyle style) {
    _themeData.value = initTheme();
  }

  set isDark(bool value) {
    _isDark = value;
    themeUtilsSetDark(value);

    _themeData.value = initTheme();
  }

  set schemeIndex(int value) {
    _schemeIndex.value = value;
    themeUtilsSetSchemeIndex(value);
    _themeData.value = initTheme();
  }

  set textSize(int value) {
    _textSize = value;
    themeUtilsSetTextSize(value);
    _themeData.value = _themeData.value.copyWith(
      textTheme: AppTextThemes(_textSize, isDark).textTheme,
    );
  }

  set setThemeData(ThemeData themeData) => _themeData.value =
      themeData.copyWith(textTheme: _themeData.value.textTheme);

  set setTextColor(Color color) {
    _themeData.value = _themeData.value.copyWith(
      textTheme: _themeData.value.textTheme.apply(
        bodyColor: color,
      ),
    );
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
      scaffoldBackgroundColor: color,
      backgroundColor: color,
      dialogBackgroundColor: color,
    );
  }

  set setListTileColor(Color color) {
    _themeData.value = _themeData.value.copyWith(
      listTileTheme: _themeData.value.listTileTheme.copyWith(tileColor: color),
    );
  }

  set setListTileIconColor(Color color) {
    _themeData.value = _themeData.value.copyWith(
      listTileTheme: _themeData.value.listTileTheme.copyWith(iconColor: color),
    );
  }

  @override
  void onInit() {
    super.onInit();
    _textSize = themeUtilsGetTextSize();
    _isDark = themeUtilsIsDark();
    _themeData = initTheme().obs;
  }

  ThemeData initTheme() {
    ThemeData t;
    AppTextThemes appTextThemes = AppTextThemes(
      _textSize,
      isDark,
    );
    _isDark = themeUtilsIsDark();
    if (_isDark) {
      t = FlexThemeData.dark(
        scheme: schemeList()[schemeIndex].scheme,
        textTheme: appTextThemes.textTheme,
      );
    } else {
      t = FlexThemeData.light(
        scheme: schemeList()[schemeIndex].scheme,
        textTheme: appTextThemes.textTheme,
      );
    }
    t = t.copyWith(
      cardTheme: t.cardTheme.copyWith(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          fillColor: Colors.transparent),
      buttonTheme: t.buttonTheme.copyWith(
        buttonColor: t.colorScheme.primary,
        textTheme: ButtonTextTheme.normal,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: t.textTheme.titleMedium,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          textStyle: t.textTheme.titleMedium,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(t.textTheme.titleMedium),
        ),
      ),
    );

    return t;
  }
}
