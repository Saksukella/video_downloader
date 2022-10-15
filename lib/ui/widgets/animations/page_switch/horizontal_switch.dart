import 'package:animations/animations.dart';
import 'package:flutter/src/widgets/framework.dart';

class HorizontalSwitchAnim extends StatelessWidget {
  const HorizontalSwitchAnim(
      {super.key, required this.child, this.reverse = false});

  final Widget child;
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      reverse: reverse,
      transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
        return SharedAxisTransition(
          transitionType: SharedAxisTransitionType.horizontal,
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        );
      },
      child: child,
    );
  }
}
