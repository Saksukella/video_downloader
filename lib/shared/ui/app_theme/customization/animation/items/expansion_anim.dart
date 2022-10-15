import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/animation_controller.dart';
import '../res/animation_keys.dart';

class SExpansionAnimation extends StatelessWidget {
  SExpansionAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> containers = [
      "Expansion Tile1",
      "Expansion Tile2",
      "Expansion Tile3",
      "Expansion Tile4",
    ];
    return Obx(() {
      SCustomAnimationController _animationController =
          Get.find<SCustomAnimationController>(
              tag: SAnimationKeys.EXPANSION_ANIM_DURATION);
      int val = _animationController.rxAnimationValue.value.toInt();
      return ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: [
          ExpansionPanelList.radio(
            elevation: 0,
            animationDuration:
                Duration(milliseconds: _animationController.getDuration),
            expandedHeaderPadding: EdgeInsets.zero,
            children: containers.map((e) {
              return ExpansionPanelRadio(
                body: Container(
                  child: Text(e),
                  height: 80,
                ),
                value: e,
                canTapOnHeader: true,
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    title: Text(e),
                  );
                },
              );
            }).toList(),
          ),
        ],
      );
    });
  }
}
