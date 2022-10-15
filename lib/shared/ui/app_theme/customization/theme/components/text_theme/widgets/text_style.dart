import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../native/row/rowlr.dart';
import '../../../../../../native/size/margins.dart';
import '../../../../../../native/surface/bottomsheets/raw_sheet.dart';
import '../../../../../theme/subthemes/texts/res/data.dart';
import '../../../../../theme/subthemes/texts/utils/utils.dart';
import '../../../../../theme/utils/theme_utils.dart';

class SAppTextStyleChanger extends StatefulWidget {
  const SAppTextStyleChanger({super.key});

  @override
  State<SAppTextStyleChanger> createState() => _SAppTextStyleChangerState();
}

class _SAppTextStyleChangerState extends State<SAppTextStyleChanger> {
  Rx<String> style = textStyleUtils_textStyleName().obs;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Style"),
        addVerticalMargin(10),
        Obx(() {
          return RowLR(
              padding: 5,
              l: Text(style.value),
              r: TextButton(
                  onPressed: () async {
                    sheetwReturnR(
                            title: "Text Style",
                            heightp: 0.8,
                            aboveContent: Obx(() {
                              return Text(
                                "This is how ${style.value} looks!",
                                style: textStyleUtils_textStyle(style.value),
                              );
                            }),
                            content: Obx(() {
                              return CupertinoScrollbar(
                                child: Wrap(
                                  spacing: 5,
                                  children: appTextStyles
                                      .map((e) => ChoiceChip(
                                          label: Text(
                                            e.name,
                                            style: e.textStyle
                                                .copyWith(fontSize: 14),
                                          ),
                                          onSelected: (b) {
                                            if (!b) return;
                                            log("Selected ${e.name}");
                                            style.value = e.name;
                                          },
                                          selected: e.name == style.value))
                                      .toList(),
                                ),
                              );
                            }),
                            rxValue: style)
                        .then((value) {
                      if (value == null) return;
                      style.value = value;
                      textStyleUtils_setTextStyle(style.value);
                      themes.textStyle = textStyleUtils_textStyle(style.value);
                    });
                  },
                  child: Text("Change")));
        }),
      ],
    );
  }
}
