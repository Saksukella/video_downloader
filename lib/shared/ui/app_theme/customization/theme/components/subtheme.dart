import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../native/size/margins.dart';
import '../controllers/subtheme_controller.dart';
import '../controllers/theme_controller.dart';
import '../items/all_components.dart';
import '../widgets/color_picker.dart';
import '../widgets/test_scaffold.dart';
import '../widgets/textbuttons.dart';

class SSubTheme extends StatelessWidget {
  SSubTheme({super.key});

  @override
  Widget build(BuildContext context) {
    SCustomThemeController _customThemeController = Get.find();
    SSubthemeController _subthemeController = Get.put(SSubthemeController());
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SResetRandomSaveButtons(
              saveAll: () {
                _customThemeController.saveAll();
              },
              save: () {
                _customThemeController.saveAllSubThemes();
              },
              reset: () {
                _customThemeController.resetAllSubthemes();
              },
              resetAll: () {
                _customThemeController.resetAll();
              },
            ),
            addVerticalMargin(10),
            Row(
              children: [
                STestScaffold(
                  widht: 200,
                ),
                addHorizontalMargin(10),
                Expanded(
                  child: SComponentsList(),
                )
              ],
            ),
            addVerticalMargin(25),
            SThemeColorPicker(
              initialColor: _subthemeController.getColorWithIndex(),
              onChanged: (color) =>
                  _subthemeController.setColorWithIndex(color),
            )
          ],
        ),
      );
    });
  }
}
