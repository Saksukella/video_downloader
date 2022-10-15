import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../native/size/margins.dart';
import '../../theme/widgets/textbuttons.dart';
import '../controllers/animation_controller.dart';
import '../dialogs/edit_animation.dart';
import '../models/animation_key_widget.dart';

class SAnimationQuickSettingsItem extends StatelessWidget {
  const SAnimationQuickSettingsItem({super.key, required this.model});
  final SAnimModels model;

  @override
  Widget build(BuildContext context) {
    SCustomAnimationController _animController = Get.find(tag: model.keys[0]);
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addVerticalMargin(10),
            SResetRandomSaveButtons(
              reset: () {
                _animController.reset();
              },
              edit: () {
                showDialog_Edit_Animation(model);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "Animation Duration: ",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: "${_animController.getDuration}ms",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: _animController.getDuration >= 500
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  addVerticalMargin(4),
                  Text.rich(TextSpan(
                    text: "Curve: ",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                    children: [
                      TextSpan(
                        text: "${_animController.getCurveString}",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ))
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
