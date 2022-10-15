import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';

import '../../../../native/size/margins.dart';
import '../../../../native/surface/dialog/cancel_confirm.dart';
import '../../../../native/surface/dialog/raw_dialog.dart';
import '../../../theme/utils/theme_utils.dart';
import '../controllers/animation_controller.dart';
import '../res/curve_string.dart';

showDialog_Animation_Curve(SCustomAnimationController controller) {
  final buttonController = GroupButtonController();
  rawDialog(
    content: Column(
      children: [
        getWidget_Column_CurvesEdit(buttonController),
        CancelConfirmButtons(onSubmit: () {
          String selectedCurve =
              curveStrings[buttonController.selectedIndex!].curveName;
          controller.setCurve = selectedCurve;

          Get.back();
          return null;
        })
      ],
    ),
  );
}

Widget getWidget_Column_CurvesEdit(GroupButtonController buttonController,
    {double height = 300, double width = 300, bool titleVisible = true}) {
  return Column(
    children: [
      Visibility(
        visible: titleVisible,
        child: Text(
          "Select Animation Curve",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      addVerticalMargin(15),
      Container(
        height: 100,
        child: Card(
          child: Center(
            child: Text("Graph"),
          ),
        ),
      ),
      SizedBox(
        height: height,
        width: 300,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 15),
          children: [
            GroupButton(
                isRadio: true,
                controller: buttonController,
                options: GroupButtonOptions(
                  borderRadius: BorderRadius.circular(100),
                  selectedTextStyle: TextStyle(fontSize: 13),
                  unselectedTextStyle: TextStyle(
                    fontSize: 13,
                    color: themes.isDark ? Colors.white : Colors.black,
                  ),
                  selectedColor: theme.colorScheme.secondary,
                  spacing: 10,
                  unselectedColor: themes.isDark
                      ? Colors.grey.shade700
                      : Colors.grey.shade300,
                ),
                onSelected: (string, index, isSelected) {},
                buttons: curveStrings.map((e) => e.curveName).toList()),
          ],
        ),
      ),
      addVerticalMargin(10),
    ],
  );
}
