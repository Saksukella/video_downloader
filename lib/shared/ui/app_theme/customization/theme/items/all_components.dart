import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../native/row/iconed_text.dart';
import '../../../../native/size/margins.dart';
import '../../../theme/utils/theme_utils.dart';
import '../controllers/subtheme_controller.dart';
import '../res/data.dart';

class SComponentsList extends StatelessWidget {
  SComponentsList({super.key});

  @override
  Widget build(BuildContext context) {
    SSubthemeController _subthemeController = Get.find();

    return Obx(() {
      log("message");
      return SizedBox(
        height: 400,
        child: ListView(physics: ClampingScrollPhysics(), children: [
          for (int i = 0; i < subThemeInfoList().length; i++)
            FadeInDown(
              child: GestureDetector(
                onTap: () {
                  log("message" + i.toString());

                  _subthemeController.setSelectedIndex = i;
                },
                child: Badge(
                  badgeColor: subThemeInfoList()[i].itemColor,
                  position: BadgePosition.topEnd(top: -4, end: -4),
                  child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: i == _subthemeController.getSelectedIndex
                            ? theme.primaryColor
                            : null,
                        border: Border.all(
                          color: i != _subthemeController.getSelectedIndex
                              ? Colors.grey
                              : Colors.transparent,
                          width: 0.7,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: IconedText(
                              maxLines: 2,
                              color: i != _subthemeController.getSelectedIndex
                                  ? null
                                  : Colors.white,
                              title: subThemeInfoList()[i].itemName,
                              icons: subThemeInfoList()[i].iconData,
                            ),
                          ),
                          addHorizontalMargin(5),
                        ],
                      )),
                ),
              ),
            ),
        ]),
      );
    });
  }
}
