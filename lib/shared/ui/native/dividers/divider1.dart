import 'package:flutter/material.dart';

class Divider1 extends StatelessWidget {
  const Divider1({super.key, this.endIndent, this.indent, this.color});

  final double? endIndent;
  final double? indent;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 1,
      endIndent: endIndent,
      indent: indent,
      color: color,
    );
  }
}

class Divider08 extends StatelessWidget {
  const Divider08({super.key, this.endIndent, this.indent, this.color});

  final double? endIndent;
  final double? indent;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 0.8,
      endIndent: endIndent,
      indent: indent,
      color: color,
    );
  }
}
