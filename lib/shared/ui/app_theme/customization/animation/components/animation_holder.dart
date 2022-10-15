import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/animation_buttons.dart';
import '../controllers/animation_controller.dart';
import '../models/animation_key_widget.dart';

class SAnimationHolder extends StatefulWidget {
  SAnimationHolder({
    Key? key,
    required this.model,
  }) : super(key: key);

  final SAnimModels model;

  @override
  State<SAnimationHolder> createState() => _SAnimationHolderState();
}

class _SAnimationHolderState extends State<SAnimationHolder>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  late SCustomAnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        Get.find<SCustomAnimationController>(tag: widget.model.keys[0]);
    controller = new AnimationController(
      duration: new Duration(milliseconds: _animationController.getDuration),
      vsync: this,
    );

    final CurvedAnimation curve = new CurvedAnimation(
        parent: controller,
        curve: _animationController.getCurve ?? Curves.ease);

    animation = new Tween(begin: 0.2, end: 1.0).animate(curve)
      ..addListener(() => setState(() {}));

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.setAnimController(controller);
    _animationController.rxAnimationValue.value = animation.value;
    curveInit();
    return Container(
      height: widget.model.frameHeight,
      width: widget.model.frameWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.grey.withOpacity(0.8),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          widget.model.widget,
          Visibility(
            visible: widget.model.visibleControls,
            child: Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child:
                    SAnimationControlButtons(controller: _animationController)),
          ),
        ],
      ),
    );
  }

  void curveInit() {
    final CurvedAnimation curve = new CurvedAnimation(
        parent: controller,
        curve: _animationController.getCurve ?? Curves.ease);
    animation = new Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() => setState(() {}));
  }
}
