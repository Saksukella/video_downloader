import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'theme_controller.dart';

class SSubthemeController extends GetxController {
  var selectedIndex = 0.obs;

  int get getSelectedIndex => selectedIndex.value;

  set setSelectedIndex(int i) => selectedIndex.value = i;

  Color getColorWithIndex() {
    SCustomThemeController _customThemeController = Get.find();
    if (getSelectedIndex == 0) {
      return _customThemeController.getBackgroundColor();
    } else if (getSelectedIndex == 1) {
      return _customThemeController.getCardColor();
    } else if (getSelectedIndex == 2) {
      return _customThemeController.getTextColor();
    } else if (getSelectedIndex == 3) {
      return _customThemeController.getListTileIconColor();
    } else if (getSelectedIndex == 4) {
      return _customThemeController.getIconColor();
    } else if (getSelectedIndex == 5) {
      return _customThemeController.getListTileColor();
    } else {
      return Colors.black;
    }
  }

  void setColorWithIndex(Color color) {
    SCustomThemeController _customThemeController = Get.find();
    if (getSelectedIndex == 0) {
      _customThemeController.setBackgroundColor = color;
    } else if (getSelectedIndex == 1) {
      _customThemeController.setCardColor = color;
    } else if (getSelectedIndex == 2) {
      _customThemeController.setTextColor = color;
    } else if (getSelectedIndex == 3) {
      _customThemeController.setListTileIconColor = color;
    } else if (getSelectedIndex == 4) {
      _customThemeController.setIconColor = color;
    } else if (getSelectedIndex == 5) {
      _customThemeController.setListTileColor = color;
    }
  }
}
