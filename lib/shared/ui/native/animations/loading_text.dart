import 'package:flutter/material.dart';

import '../../packages/animations_p/page_switch/vertical_switch.dart';
import 'loading_widget.dart';

class LoadingText extends StatelessWidget {
  const LoadingText(
      {super.key, required this.isLoading, required this.text, this.style});

  final bool isLoading;
  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return VerticalSwitchAnim(
        child: isLoading
            ? LoadingWidget(
                size: 18,
                strokeWidth: 3,
              )
            : Text(
                text,
                style: style,
              ));
  }
}
