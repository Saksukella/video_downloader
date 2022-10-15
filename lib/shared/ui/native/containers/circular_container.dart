//create a circular container

// Language: dart

import 'package:flutter/material.dart';

class CircularContainer extends StatelessWidget {
  const CircularContainer({
    super.key,
    this.padding = 6,
    this.margin = 0,
    this.bg,
    this.onTap,
    required this.child,
  });

  final double padding;
  final double margin;
  final Color? bg;
  final Widget child;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(margin),
        padding: EdgeInsets.all(padding),
        child: child,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: bg,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
