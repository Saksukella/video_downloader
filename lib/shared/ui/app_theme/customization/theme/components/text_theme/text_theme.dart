import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_downloader/shared/ui/app_theme/theme/utils/text_utils.dart';
import 'package:video_downloader/shared/ui/native/row/rowlr.dart';

import '../../../../../native/size/margins.dart';
import '../../../../theme/utils/theme_utils.dart';

class SThemeText extends StatefulWidget {
  const SThemeText({super.key});

  @override
  State<SThemeText> createState() => _SThemeTextState();
}

class _SThemeTextState extends State<SThemeText> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final double textSize = theme.textTheme.titleMedium!.fontSize!;
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            addVerticalMargin(15),
            RowLR(
              l: Text(
                "Text Size $textSize",
                style: titleMedium().copyWith(fontSize: textSize),
              ),
              r: RowLR(
                close: true,
                l: IconButton(
                  onPressed: () {
                    if (textSize < 11) return;

                    themes.textSize = textSize.toInt() - 1;
                  },
                  icon: const Icon(Icons.text_decrease),
                ),
                r: IconButton(
                  onPressed: () {
                    if (textSize < 30) {
                      themes.textSize = textSize.toInt() + 1;
                    }
                  },
                  icon: const Icon(Icons.text_increase),
                ),
              ),
            ),

            /*  const Divider(
                indent: 10,
                endIndent: 10,
                thickness: 0.7,
              ),
              addVerticalMargin(10),
              const SAppTextStyleChanger() */
          ],
        ),
      );
    });
  }
}
