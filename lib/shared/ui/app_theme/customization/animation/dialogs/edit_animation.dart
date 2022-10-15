import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../../native/size/margins.dart';
import '../../../../native/surface/dialog/cancel_confirm.dart';
import '../../../../native/surface/dialog/raw_dialog.dart';
import '../controllers/animation_controller.dart';
import '../models/animation_key_widget.dart';
import '../res/curve_string.dart';
import 'animation_curve.dart';

void showDialog_Edit_Animation_All(List<String> keys) {
  int duration = 500;
  String? curve;
  final buttonController = GroupButtonController();
  rawDialog(
    content: StatefulBuilder(
      builder: (context, setState) {
        return Column(
          children: [
            Text(
              "Edit Animations",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            getWidget_Column_CurvesEdit(buttonController,
                width: 250, height: 250, titleVisible: false),
            FlipInY(
              child: SfSlider(
                min: 0.0,
                max: 5000.0,
                stepSize: 10,
                showTicks: true,
                value: duration,
                showLabels: true,
                shouldAlwaysShowTooltip: false,
                enableTooltip: true,
                onChanged: (dynamic value) {
                  setState(() {
                    duration = value.toInt();
                  });
                },
              ),
            ),
            addVerticalMargin(15),
            CancelConfirmButtons(onSubmit: () {
              for (var i = 0; i < keys.length; i++) {
                String key = keys[i];
                SCustomAnimationController controller = Get.find(tag: key);
                String selectedCurve =
                    curveStrings[buttonController.selectedIndex ?? 4].curveName;
                controller.resetWith(curve: selectedCurve, duration: duration);
              }

              Get.back();
              return null;
            }),
          ],
        );
      },
    ),
  );
}

void showDialog_Edit_Animation(SAnimModels model) {
  String title = "Edit " + model.title;
  SCustomAnimationController _animController = Get.find(tag: model.keys[0]);
  int duration = _animController.getDuration;
  String? curve = _animController.getCurveString;
  final buttonController = GroupButtonController();
  buttonController.selectIndex(curveStrings.indexWhere(
      (element) => element.curveName == _animController.getCurveString));

  rawDialog(content: StatefulBuilder(builder: (context, setState) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        getWidget_Column_CurvesEdit(buttonController,
            width: 250, height: 250, titleVisible: false),
        FlipInY(
          child: SfSlider(
            min: 0.0,
            max: 5000.0,
            showTicks: true,
            stepSize: 10,
            value: duration,
            showLabels: true,
            shouldAlwaysShowTooltip: false,
            enableTooltip: true,
            onChanged: (dynamic value) {
              setState(() {
                duration = value.toInt();
              });
            },
          ),
        ),
        addVerticalMargin(15),
        CancelConfirmButtons(onSubmit: () {
          String selectedCurve =
              curveStrings[buttonController.selectedIndex!].curveName;
          _animController.resetWith(curve: selectedCurve, duration: duration);

          Get.back();
          return null;
        }),
      ],
    );
  }));
}
