import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_animations/models/app_anim_models.dart';
import '../../app_animations/utils/anim_utils.dart';
import '../../theme/utils/theme_utils.dart';
import '../animation/res/animation_keys.dart';

class SUserExpansionPanelRadio extends StatelessWidget {
  const SUserExpansionPanelRadio(
      {super.key,
      required this.panelList,
      this.callback,
      this.listViewController,
      this.scrollOffset = 200});
  final List<ExpansionPanelRadio> panelList;
  final Function(int panelIndex, bool isExpanded)? callback;
  final ScrollController? listViewController;
  final double scrollOffset;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      AppAnimModels animModels =
          anims.withKey(SAnimationKeys.EXPANSION_ANIM_DURATION);
      log('UserExpansionPanelRadio:');
      return ExpansionPanelList.radio(
        elevation: 0,
        animationDuration: Duration(milliseconds: animModels.animDuration),
        expandedHeaderPadding: EdgeInsets.zero,
        children: panelList,
        expansionCallback: (index, isExpanded) async {
          callback?.call(index, isExpanded);
          if (listViewController != null) {
            if (!isExpanded) {
              await Future.delayed(const Duration(milliseconds: 120));
              listViewController!.animateTo(
                listViewController!.initialScrollOffset + scrollOffset,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            }
          }
        },
      );
    });
  }
}

ExpansionPanelRadio userExpansionPanelItem({
  required value,
  required Widget Function(BuildContext context, bool isExpaned) headerBuilder,
  required body,
  double padding = 4,
  Color? color,
}) {
  return ExpansionPanelRadio(
    value: value,
    backgroundColor: color ?? Colors.transparent,
    headerBuilder: headerBuilder,
    body: Padding(
      padding: EdgeInsets.all(padding),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            border: Border.all(
              color: Colors.grey.withOpacity(themes.isDark ? 0.25 : 0.35),
              width: 0.7,
            )),
        padding: const EdgeInsets.all(3),
        child: body,
      ),
    ),
    canTapOnHeader: true,
  );
}
