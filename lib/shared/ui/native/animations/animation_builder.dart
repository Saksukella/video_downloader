import 'dart:developer';

import 'package:flutter/cupertino.dart';

class InOutAnim extends StatefulWidget {
  const InOutAnim(
      {super.key,
      this.open = false,
      this.fCurve = Curves.decelerate,
      this.rCurve = Curves.fastOutSlowIn,
      this.fromDirection = AxisDirection.left,
      this.from = 1.5,
      this.duration = 400,
      required this.child});

  final Widget child;
  final AxisDirection fromDirection;
  final double from;
  final Curve fCurve;
  final Curve rCurve;
  final bool open;
  final int duration;

  @override
  State<InOutAnim> createState() => _InOutAnimState();
}

class _InOutAnimState extends State<InOutAnim> with TickerProviderStateMixin {
  late final AnimationController controller;
  Animation<Offset>? slideAnimation;
  bool isAnimating = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.duration));
    _initAnim();
    controller.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        isAnimating = true;
      } else if (status == AnimationStatus.reverse) {
        isAnimating = true;
      } else if (AnimationStatus.dismissed == status) {
        isAnimating = false;
      }
      setState(() {});
      log('status: $status');
    });
  }

  void _initAnim() {
    late Tween<Offset> tween;

    if (widget.fromDirection == AxisDirection.up) {
      tween = Tween<Offset>(begin: Offset(0, widget.from), end: Offset(0, 0));
    } else if (widget.fromDirection == AxisDirection.down) {
      tween = Tween<Offset>(begin: Offset(0, -widget.from), end: Offset(0, 0));
    } else if (widget.fromDirection == AxisDirection.right) {
      tween = Tween<Offset>(begin: Offset(widget.from, 0), end: Offset(0, 0));
    } else if (widget.fromDirection == AxisDirection.left) {
      tween = Tween<Offset>(begin: Offset(-widget.from, 0), end: Offset(0, 0));
    }

    if (widget.open) {
      slideAnimation = tween.animate(CurvedAnimation(
        parent: controller,
        curve: widget.rCurve,
      ));
    } else {
      slideAnimation = tween.animate(CurvedAnimation(
        parent: controller,
        curve: widget.fCurve,
      ));
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.open) {
      _initAnim();
      controller.reverse();
    } else {
      _initAnim();
      controller.forward();
    }
    return SlideTransition(
      position: slideAnimation!,
      child: Visibility(visible: isAnimating, child: widget.child),
    );
  }
}
