import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/animation_controller.dart';
import '../res/animation_keys.dart';

class STransitionAnimation extends StatelessWidget {
  const STransitionAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    SCustomAnimationController _animationController =
        Get.find<SCustomAnimationController>(
            tag: SAnimationKeys.TRANSITION_ANIM_DURATION);
    return ElevatedButton(
        onPressed: () {
          Get.to(() => _TransitionAnimPage(),
              duration:
                  Duration(milliseconds: _animationController.getDuration));
        },
        child: Text("See Transition"));
  }
}

class _TransitionAnimPage extends StatelessWidget {
  const _TransitionAnimPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transition Animation"),
      ),
      body: Center(
        child: Container(
          child: Text("Transition Animation"),
        ),
      ),
    );
  }
}
