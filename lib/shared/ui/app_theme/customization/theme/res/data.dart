import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/theme_controller.dart';

class subThemeInfo {
  String itemName;
  IconData iconData;
  Color itemColor;

  subThemeInfo(this.itemName, this.iconData, this.itemColor);
}

List<subThemeInfo> subThemeInfoList() {
  SCustomThemeController themeController = Get.find();
  return [
    subThemeInfo(
        "Background", Icons.image, themeController.getBackgroundColor()),
    subThemeInfo(
        "Card", Icons.calendar_view_day, themeController.getCardColor()),
    subThemeInfo("Text", Icons.text_fields, themeController.getTextColor()),
    subThemeInfo("ListTile Icon", Icons.list_sharp,
        themeController.getListTileIconColor()),
    subThemeInfo("Icon", Icons.info, themeController.getIconColor()),
    subThemeInfo("ListTile", Icons.list_alt_outlined,
        themeController.getListTileColor()),
  ];
}
