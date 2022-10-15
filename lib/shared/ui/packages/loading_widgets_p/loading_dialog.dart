import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../app_theme/theme/utils/theme_utils.dart';

void loadingDialog() {
  showGeneralDialog(
    context: Get.context!,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (context, a, b) => Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: SizedBox(
            height: 50,
            width: 50,
            child: LoadingAnimationWidget.staggeredDotsWave(
                color: theme.colorScheme.primary, size: 30),
          ),
        ),
      ),
    ),
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
      } else {
        tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
      }

      return SlideTransition(
        position: tween.animate(
          CurvedAnimation(parent: anim, curve: const ElasticOutCurve(1.0)),
        ),
        child: child,
      );
    },
  );
}
