import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../app_theme/theme/utils/text_utils.dart';

class IconedText extends StatelessWidget {
  IconedText({
    super.key,
    required this.title,
    required this.icons,
    this.style,
    this.min = true,
    this.margin = 8,
    this.iconClick,
    this.bold = false,
    this.start = true,
    this.center = false,
    this.color,
    this.maxLines = 1,
  });

  final double margin;
  final bool start;
  final String title;
  final IconData icons;
  final Color? color;

  TextStyle? style;
  final int maxLines;

  final Function()? iconClick;
  final bool bold;
  final bool center;
  final bool min;

  @override
  Widget build(BuildContext context) {
    style ??= bodyMedium();
    double iconScale = style!.fontSize! * 1.1;
    return Row(
      mainAxisSize: min ? MainAxisSize.min : MainAxisSize.max,
      mainAxisAlignment:
          center ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        start
            ? GestureDetector(
                onTap: iconClick,
                child: Icon(
                  icons,
                  color: color,
                  size: iconScale,
                ),
              )
            : Container(),
        start
            ? SizedBox(
                width: margin,
              )
            : Container(),
        Flexible(
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
        !start
            ? SizedBox(
                width: margin,
              )
            : Container(),
        !start
            ? GestureDetector(
                onTap: iconClick,
                child: Icon(
                  icons,
                  color: color,
                  size: iconScale,
                ),
              )
            : Container(),
      ],
    );
  }
}
