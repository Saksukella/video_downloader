import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../app_theme/theme/utils/text_utils.dart';
import '../dividers/divider1.dart';
import '../size/margins.dart';

class TitledWidget extends StatelessWidget {
  const TitledWidget(
      {super.key,
      this.marginVertical = 10,
      this.marginHorizontal = 0,
      this.paddingVertical = 0,
      this.paddingHorizontal = 0,
      this.isCenter = false,
      required this.title,
      required this.child});

  final double marginVertical;
  final double marginHorizontal;
  final double paddingVertical;
  final double paddingHorizontal;
  final String title;
  final bool isCenter;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: marginVertical, horizontal: marginHorizontal),
      child: Column(
        children: <Widget>[
          Align(
            alignment: isCenter ? Alignment.center : Alignment.centerLeft,
            child: ElasticInLeft(
              child: Text(
                title,
                style: titleLarge(),
              ),
            ),
          ),
          FlipInY(
            child: Divider1(
              indent: isCenter ? 15 : 0,
              endIndent: isCenter ? 15 : 20,
            ),
          ),
          addVerticalMargin(10),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: paddingVertical, horizontal: paddingHorizontal),
            child: child,
          ),
        ],
      ),
    );
  }
}
