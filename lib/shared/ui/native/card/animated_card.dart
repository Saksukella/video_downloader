import 'package:flutter/material.dart';

import '../../app_theme/customization/user_widgets/user_animatedSize.dart';

class AnimatedCard extends StatelessWidget {
  AnimatedCard(
      {super.key, required this.child, this.padding, this.margin, this.shape});

  final Widget child;
  EdgeInsets? padding;
  EdgeInsets? margin;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    padding ??= const EdgeInsets.all(8);

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Card(
        shape: shape,
        child: Padding(
          padding: padding!,
          child: SUserAnimatedSize(
            child: child,
          ),
        ),
      ),
    );
  }
}
