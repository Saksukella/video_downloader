import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../../../native/size/margins.dart';
import '../../../../theme/utils/text_utils.dart';
import '../../../../theme/utils/theme_utils.dart';
import 'widgets/text_style.dart';

class SThemeText extends StatefulWidget {
  const SThemeText({super.key});

  @override
  State<SThemeText> createState() => _SThemeTextState();
}

class _SThemeTextState extends State<SThemeText> {
  double _textSize = theme.textTheme.titleMedium!.fontSize!;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          addVerticalMargin(15),
          const Text(
            "Size",
          ),
          addVerticalMargin(10),
          SfSlider(
              showTicks: true,
              interval: 1,
              min: 10.0,
              max: 30.0,
              stepSize: 1,
              enableTooltip: true,
              thumbIcon: Center(
                child: Text(
                  _textSize.toStringAsFixed(0),
                  style:
                      labelSmall().copyWith(color: Colors.white, fontSize: 12),
                ),
              ),
              value: _textSize,
              onChanged: (value) {
                log("v: $value");
                if (value < 5) {
                  return;
                }

                themes.textSize = value.toInt();
                setState(() {
                  _textSize = value;
                });
              }),
          addVerticalMargin(10),
          const Divider(
            indent: 10,
            endIndent: 10,
            thickness: 0.7,
          ),
          addVerticalMargin(10),
          const SAppTextStyleChanger()
        ],
      ),
    );
  }
}
