import 'package:flutter/material.dart';

import '../size/margins.dart';

class RowLR extends StatelessWidget {
  const RowLR({
    super.key,
    required this.l,
    required this.r,
    this.padding = 0,
    this.min = false,
    this.close = false,
    this.center = false,
  });

  final Widget l;
  final Widget r;
  final double padding;
  final bool min;
  final bool close;
  final bool center;

  @override
  Widget build(BuildContext context) {
    return min
        ? Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment:
                center ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              Flexible(child: l),
              addHorizontalMargin(padding),
              Flexible(child: r),
            ],
          )
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Row(
              mainAxisAlignment: close
                  ? center
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start
                  : MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: l),
                addHorizontalMargin(padding),
                Flexible(child: r),
              ],
            ),
          );
  }
}
