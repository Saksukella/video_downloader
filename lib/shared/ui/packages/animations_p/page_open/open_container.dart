import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class OpenContanerAnim extends StatelessWidget {
  const OpenContanerAnim(
      {super.key,
      required this.closedWidget,
      required this.openWidget,
      this.onTap});

  final Widget closedWidget;
  final Widget openWidget;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return OpenContainer(closedBuilder: (context, action) {
      return closedWidget;
    }, openBuilder: (context, action) {
      return openWidget;
    });
  }
}
