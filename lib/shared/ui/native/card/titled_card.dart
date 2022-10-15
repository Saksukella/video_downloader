import 'package:flutter/material.dart';

import '../../app_theme/customization/user_widgets/user_animatedSize.dart';
import '../size/margins.dart';

class TitledCard extends StatelessWidget {
  TitledCard({
    super.key,
    required this.title,
    required this.cardContent,
    this.titleSecondary,
    this.verticalMargin = 10,
    this.horizontalMargin = 10,
    this.titleInCard = false,
    this.color,
    this.strokeColor,
  });

  final Widget title;
  final Widget? titleSecondary;
  final Widget cardContent;

  final Color? color;
  final double verticalMargin;
  final double horizontalMargin;

  final Color? strokeColor;
  final bool titleInCard;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
            visible: !titleInCard,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: title),
                    titleSecondary ?? Container(),
                  ],
                ),
                addVerticalMargin(10)
              ],
            )),
        Card(
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: strokeColor != null ? strokeColor! : Colors.transparent,
              width: strokeColor != null ? 0.5 : 0,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: horizontalMargin, vertical: verticalMargin),
            child: SUserAnimatedSize(
                child: Column(
              children: [
                Visibility(
                  visible: titleInCard,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: title),
                          titleSecondary ?? Container(),
                        ],
                      ),
                      Divider(
                        endIndent: 25,
                      ),
                    ],
                  ),
                ),
                cardContent,
              ],
            )),
          ),
        ),
      ],
    );
  }
}
