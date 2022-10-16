import 'dart:developer';

import 'package:flutter/material.dart';

class ColumnTB extends StatelessWidget {
  const ColumnTB(
      {super.key,
      required this.t,
      required this.b,
      this.close = true,
      this.top = false,
      this.center = false,
      this.bottom = false,
      this.min = false,
      this.centerColumn = true,
      this.margin = 0,
      this.debug = false,
      this.crossAxisAlignment = CrossAxisAlignment.center});

  final Widget t;
  final Widget b;
  final bool close;
  final bool min;
  final bool top;
  final bool center;
  final bool centerColumn;
  final bool bottom;
  final bool debug;
  final double margin;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    log(_alignment().toString());
    return Align(
      alignment: centerColumn ? Alignment.center : Alignment.centerLeft,
      child: Container(
        color: debug ? Colors.red : null,
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          mainAxisSize: min ? MainAxisSize.min : MainAxisSize.max,
          mainAxisAlignment: _alignment(),
          children: [
            t,
            if (close) SizedBox(height: margin),
            b,
          ],
        ),
      ),
    );
  }

  MainAxisAlignment _alignment() {
    if (close) {
      if (top) return MainAxisAlignment.start;

      if (center) return MainAxisAlignment.center;

      if (bottom) return MainAxisAlignment.end;

      return MainAxisAlignment.center;
    }
    return MainAxisAlignment.spaceBetween;
  }
}
