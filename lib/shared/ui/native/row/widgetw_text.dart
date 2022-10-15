import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../res/utils/string_utils.dart';
import '../../app_theme/theme/utils/text_utils.dart';

class WidgetwText extends StatelessWidget {
  WidgetwText({
    super.key,
    required this.title,
    required this.widget,
    this.style,
    this.margin = 10,
    this.iconClick,
    this.bold = false,
    this.heroText,
    this.start = true,
    this.center = false,
    this.color,
    this.maxLines = 1,
  });

  final double margin;
  final bool start;
  final String title;
  final String? heroText;
  final Widget widget;
  final Color? color;

  TextStyle? style;
  final int maxLines;

  final Function()? iconClick;
  final bool bold;
  final bool center;

  @override
  Widget build(BuildContext context) {
    style ??= bodyMedium();
    return Row(
      mainAxisAlignment:
          center ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        start
            ? GestureDetector(
                onTap: iconClick,
                child: SizedBox(
                  height: style!.fontSize! * 1.2,
                  width: style!.fontSize! * 1.2,
                  child: widget,
                ),
              )
            : Container(),
        start
            ? SizedBox(
                width: margin,
              )
            : Container(),
        Flexible(
          child: Hero(
            tag: heroText ?? generateRandomString(15),
            child: AutoSizeText(
              title,
              maxLines: maxLines,
              maxFontSize: style!.fontSize!,
              minFontSize: style!.fontSize! - 4,
              style: style!.copyWith(
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                  color: color),
            ),
          ),
        ),
        !start
            ? SizedBox(
                width: margin,
              )
            : Container(),
        !start
            ? GestureDetector(
                onTap: iconClick,
                child: SizedBox(
                  height: style!.fontSize! * 1.2,
                  width: style!.fontSize! * 1.2,
                  child: widget,
                ),
              )
            : Container(),
      ],
    );
  }
}
