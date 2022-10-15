import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import '../../../theme/utils/theme_utils.dart';

Color defaultThemeUtils_TextColor() {
  if (themes.isDark) {
    return Colors.white;
  } else {
    return Colors.black;
  }
}

Color defaultThemeUtils_IconColor() {
  if (themes.isDark) {
    return Colors.white;
  } else {
    return Colors.black;
  }
}

Color defaultThemeUtils_CardColor() {
  if (themes.isDark) {
    return Colors.grey.shade900;
  } else {
    return Colors.grey.shade100;
  }
}

Color defaultThemeUtils_BackgroundColor() {
  if (themes.isDark) {
    return FlexColorScheme.dark().toTheme.backgroundColor;
  } else {
    return FlexColorScheme.light().toTheme.backgroundColor;
  }
}

Color defaultThemeUtils_ExpansionColor() {
  if (themes.isDark) {
    return defaultThemeUtils_CardColor();
  } else {
    return defaultThemeUtils_CardColor();
  }
}

Color defaultThemeUtils_ListTileColor() {
  if (themes.isDark) {
    return Colors.transparent;
  } else {
    return Colors.transparent;
  }
}

Color defaultThemeUtils_ListTileIconColor() {
  if (themes.isDark) {
    return Colors.white60;
  } else {
    return Colors.black54;
  }
}
