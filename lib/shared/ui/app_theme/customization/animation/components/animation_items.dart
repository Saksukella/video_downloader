import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../../../res/app_default.dart';
import '../../../../../services/models/icon_text_model.dart';
import '../../../../native/chips/radio_chips.dart';
import '../../../../native/size/margins.dart';
import '../../theme/widgets/textbuttons.dart';
import '../controllers/animation_controller.dart';
import '../dialogs/animation_curve.dart';
import '../models/animation_key_widget.dart';
import '../res/data.dart';
import 'animation_holder.dart';

class SAnimationItem extends StatefulWidget {
  const SAnimationItem({
    super.key,
    required this.animModel,
  });

  final SAnimModels animModel;

  @override
  State<SAnimationItem> createState() => _SAnimationItemState();
}

class _SAnimationItemState extends State<SAnimationItem> {
  @override
  Widget build(BuildContext context) {
    SCustomAnimationController customAnimController =
        Get.find(tag: widget.animModel.keys[0]);

    List<GeneralModel> radioModels = [
      GeneralModel(
          text: "Slowest",
          value: SResourses.animationDuration *
              2 *
              widget.animModel.animDurationScale),
      GeneralModel(
          text: "Slow",
          value: SResourses.animationDuration *
              1.5 *
              widget.animModel.animDurationScale),
      GeneralModel(
          text: "Normal",
          value: SResourses.animationDuration *
              1 *
              widget.animModel.animDurationScale),
      GeneralModel(
          text: "Fast",
          value: SResourses.animationDuration *
              0.8 *
              widget.animModel.animDurationScale),
      GeneralModel(
          text: "Fastest",
          value: SResourses.animationDuration *
              0.6 *
              widget.animModel.animDurationScale),
    ];

    return Obx(() {
      return ListView(
        padding: const EdgeInsets.all(10),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          SResetRandomSaveButtons(
            reset: () {
              customAnimController.reset();
            },
            save: () {
              customAnimController.saveValues();
            },
            saveAll: () {
              saveAllValues();
            },
          ),
          SAnimationHolder(
            model: widget.animModel,
          ),
          addVerticalMargin(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text.rich(
                    TextSpan(
                      text: "Animation Duration: ",
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text:
                              "${customAnimController.getDuration.toString()}ms",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: customAnimController.getDuration >= 400
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          addVerticalMargin(5),
          Visibility(
            visible: widget.animModel.curveEnabled,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "Curves : ",
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(
                            text: "${customAnimController.getCurveString}",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    showDialog_Animation_Curve(customAnimController);
                  },
                  child: const Text("CHANGE"),
                ),
              ],
            ),
          ),
          addVerticalMargin(15),
          RadioChips(
            initialIndex: radioModels.indexOf(radioModels.firstWhere(
                (element) =>
                    element.value == customAnimController.getDuration)),
            items: radioModels,
            onSelected: (i, model) {
              customAnimController.setDuration(model.value.toInt());
            },
          ),
          addVerticalMargin(22),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.animation),
              addHorizontalMargin(5),
              const Text(
                "Custom",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          FlipInY(
            child: SfSlider(
              min: 0.0,
              max: widget.animModel.maxDuration,
              stepSize: 10,
              showTicks: true,
              value: customAnimController.getDuration,
              showLabels: true,
              shouldAlwaysShowTooltip: false,
              enableTooltip: true,
              onChanged: (dynamic value) {
                setState(() {
                  customAnimController.setDuration(value.toInt());
                });
              },
            ),
          ),
        ],
      );
    });
  }

  void saveAllValues() {
    for (var element in anim_models) {
      SCustomAnimationController customAnimController =
          Get.find(tag: element.keys[0]);
      customAnimController.saveValues();
    }
  }
}
