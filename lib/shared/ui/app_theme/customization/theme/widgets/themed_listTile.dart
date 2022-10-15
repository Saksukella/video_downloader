import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/string.dart';
import '../controllers/theme_controller.dart';

class SThemedListTile extends StatelessWidget {
  const SThemedListTile({super.key});

  @override
  Widget build(BuildContext context) {
    SCustomThemeController _customThemeController = Get.find();
    return ListTile(
      title: Text(
        CustomizationStrings.testString,
        style: TextStyle(color: _customThemeController.getTextColor()),
      ),
      tileColor: _customThemeController.getListTileColor(),
      leading: Icon(
        Icons.info,
        color: _customThemeController.getListTileIconColor(),
      ),
    );
  }
}
