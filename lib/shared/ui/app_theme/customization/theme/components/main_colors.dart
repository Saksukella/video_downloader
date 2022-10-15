import 'package:auto_size_text/auto_size_text.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../native/size/margins.dart';
import '../../../theme/res/flex_list.dart';
import '../../../theme/themes.dart';
import '../controllers/theme_controller.dart';
import '../widgets/test_scaffold.dart';
import '../widgets/textbuttons.dart';

class SThemeMainColors extends StatelessWidget {
  SThemeMainColors({super.key});
  int selectedScheme = 0;
  @override
  Widget build(BuildContext context) {
    bool isSelected(int i) {
      return selectedScheme == i;
    }

    Themes themes = Get.find();
    SCustomThemeController _customThemeController = Get.find();

    return Obx(() {
      selectedScheme = _customThemeController.getSchemeIndex();
      return Column(
        children: [
          SResetRandomSaveButtons(
            saveAll: () {
              _customThemeController.saveAll();
            },
            reset: () {
              _customThemeController.resetSchemeIndex();
            },
            save: () {
              _customThemeController.saveSchemeIndex();
            },
            resetAll: () {
              _customThemeController.resetAll();
            },
          ),
          addVerticalMargin(10),
          Theme(
            data: _customThemeController.getThemeData,
            child: Column(
              children: [
                STestScaffold(),
                addVerticalMargin(25),
                Container(
                  height: 300,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: GridView(
                      physics: BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          mainAxisExtent: 40),
                      children: [
                        for (int i = 0; i < schemeList().length; i++)
                          GestureDetector(
                            onTap: () {
                              _customThemeController.setColorScheme(i);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSelected(i)
                                    ? _customThemeController
                                        .getThemeData.primaryColor
                                    : null,
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                              padding: EdgeInsets.only(
                                  left: 2, top: 7, bottom: 7, right: 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    width: 25,
                                    height: 25,
                                    child: isSelected(i)
                                        ? Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 22,
                                          )
                                        : null,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: themes.isDark
                                          ? FlexColorScheme.dark(
                                                  scheme: schemeList()
                                                      .elementAt(i)
                                                      .scheme)
                                              .primary
                                          : FlexColorScheme.light(
                                                  scheme: schemeList()
                                                      .elementAt(i)
                                                      .scheme)
                                              .primary,
                                    ),
                                  ),
                                  addHorizontalMargin(10),
                                  Expanded(
                                      child: AutoSizeText(
                                    schemeList().elementAt(i).name,
                                    minFontSize: 13,
                                    maxFontSize: 15,
                                    style: TextStyle(
                                        color: isSelected(i)
                                            ? Colors.white
                                            : null),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  )),
                                ],
                              ),
                            ),
                          )
                      ]),
                ),
                addVerticalMargin(10),
              ],
            ),
          ),
        ],
      );
    });
  }
}
