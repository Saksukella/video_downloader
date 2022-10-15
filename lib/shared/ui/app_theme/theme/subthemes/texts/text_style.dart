import 'package:flutter/material.dart';

import '../../../../../res/app_default.dart';

class AppTextThemes {
  late final TextTheme textTheme;
  late final double _small;
  late final double _medium;
  late final double _large;
  late final TextStyle _txtStyle;

  AppTextThemes(
    int size,
    bool isDark,
  ) {
    /* _txtStyle = textStyleUtils_textStyle(null).copyWith(
      color: isDark ? Colors.white : Colors.black,
    ); */
    _txtStyle = SResourses.textStyle;
    _small = size - 2;
    _medium = size.toDouble();
    _large = size + 4;

    textTheme = TextTheme(
      labelSmall: labelSmall(),
      bodySmall: bodySmall(),
      titleSmall: titleSmall(),
      headlineSmall: headlineSmall(),
      displaySmall: displaySmall(),
      labelMedium: labelMedium(),
      bodyMedium: bodyMedium(),
      titleMedium: titleMedium(),
      headlineMedium: headlineMedium(),
      displayMedium: displayMedium(),
      labelLarge: labelLarge(),
      bodyLarge: bodyLarge(),
      titleLarge: titleLarge(),
      headlineLarge: headlineLarge(),
      displayLarge: displayLarge(),
    );
  }

  TextStyle labelSmall() {
    return _txtStyle.copyWith(
      fontSize: _small - 3,
    );
  }

  TextStyle bodySmall() {
    return _txtStyle.copyWith(
      fontSize: _small - 2,
    );
  }

  TextStyle titleSmall() {
    return _txtStyle.copyWith(
      fontSize: _small,
    );
  }

  TextStyle headlineSmall() {
    return _txtStyle.copyWith(
      fontSize: _small + 6,
    );
  }

  TextStyle displaySmall() {
    return _txtStyle.copyWith(
      fontSize: _small + 16,
    );
  }

  TextStyle labelMedium() {
    return _txtStyle.copyWith(
      fontSize: _medium - 3,
    );
  }

  TextStyle bodyMedium() {
    return _txtStyle.copyWith(
      fontSize: _medium - 2,
    );
  }

  TextStyle titleMedium() {
    return _txtStyle.copyWith(
      fontSize: _medium,
    );
  }

  TextStyle headlineMedium() {
    return _txtStyle.copyWith(
      fontSize: _medium + 6,
    );
  }

  TextStyle displayMedium() {
    return _txtStyle.copyWith(
      fontSize: _medium + 16,
    );
  }

  TextStyle labelLarge() {
    return _txtStyle.copyWith(
      fontSize: _large - 3,
    );
  }

  TextStyle bodyLarge() {
    return _txtStyle.copyWith(
      fontSize: _large - 2,
    );
  }

  TextStyle titleLarge() {
    return _txtStyle.copyWith(
      fontSize: _large,
    );
  }

  TextStyle headlineLarge() {
    return _txtStyle.copyWith(
      fontSize: _large + 6,
    );
  }

  TextStyle displayLarge() {
    return _txtStyle.copyWith(
      fontSize: _large + 16,
    );
  }
}
