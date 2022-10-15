import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class VerticalSwitchAnim extends StatelessWidget {
  const VerticalSwitchAnim(
      {super.key, required this.child, this.reverse = false});

  final Widget child;
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      reverse: reverse,
      transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
        return SharedAxisTransition(
          transitionType: SharedAxisTransitionType.vertical,
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          fillColor: Colors.transparent,
          child: child,
        );
      },
      child: child,
    );
  }
}
