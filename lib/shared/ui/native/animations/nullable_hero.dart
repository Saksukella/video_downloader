import 'package:flutter/material.dart';

class NullHero extends StatelessWidget {
  const NullHero({
    super.key,
    required this.child,
    this.tag,
  });

  final String? tag;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return tag == null ? child : Hero(tag: tag!, child: child);
  }
}
