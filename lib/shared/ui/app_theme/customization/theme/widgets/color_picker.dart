import 'package:animate_do/animate_do.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/subtheme_controller.dart';
import '../res/data.dart';

class SThemeColorPicker extends StatelessWidget {
  const SThemeColorPicker({
    Key? key,
    required this.initialColor,
    required this.onChanged,
  });

  final Color initialColor;
  final Function(Color color) onChanged;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      SSubthemeController _subthemeController = Get.find();
      return SlideInUp(
        child: ColorPicker(
          padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          // Use the screenPickerColor as start color.
          color: initialColor,
          // Update the screenPickerColor using the callback.
          onColorChanged: (Color color) {
            onChanged(color);
          },

          elevation: 3,
          enableTonalPalette: true,
          showMaterialName: true,
          title: Text(
              subThemeInfoList()[_subthemeController.getSelectedIndex].itemName,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          subheading: Text(
            'Select color shade',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      );
    });
  }
}
