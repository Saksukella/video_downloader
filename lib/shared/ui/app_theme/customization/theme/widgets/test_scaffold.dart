import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../native/size/margins.dart';
import '../../../theme/utils/text_utils.dart';
import '../../../theme/utils/theme_utils.dart';
import '../controllers/theme_controller.dart';

class STestScaffold extends StatefulWidget {
  const STestScaffold({super.key, this.widht = 215});

  final double widht;
  @override
  State<STestScaffold> createState() => _STestScaffoldState();
}

class _STestScaffoldState extends State<STestScaffold> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    SCustomThemeController customThemeController = Get.find();

    return Obx(() {
      return SlideInLeft(
        child: Theme(
          data: customThemeController.getThemeData,
          child: Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                  width: widget.widht,
                  height: widget.widht * 2,
                  decoration: const BoxDecoration(),
                  child: Stack(
                    children: [
                      Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.only(left: 12, right: 5),
                            color: themes.isDark
                                ? customThemeController
                                    .getThemeData.appBarTheme.surfaceTintColor
                                : customThemeController
                                    .getThemeData.primaryColor,
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Test Title",
                                  style: bodyMedium()
                                      .copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          )),
                      Positioned(
                          top: 40,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            color: customThemeController.getBackgroundColor(),
                            child: ListView(
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              children: [
                                addVerticalMargin(5),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: SizedBox(
                                    width: 90,
                                    height: 30,
                                    child: FittedBox(
                                      child: Row(
                                        children: [
                                          TextButton(
                                            onPressed: () {},
                                            child: Text("Cool",
                                                style: bodySmall().copyWith(
                                                    color: customThemeController
                                                        .getTextColor())),
                                          ),
                                          addHorizontalMargin(2),
                                          ElevatedButton(
                                            onPressed: () {},
                                            child: Text("Cooler",
                                                style: bodySmall().copyWith(
                                                    color: customThemeController
                                                        .getTextColor())),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                addVerticalMargin(5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Settings",
                                      style: bodyMedium().copyWith(
                                          color: customThemeController
                                              .getTextColor()),
                                    ),
                                    SizedBox(
                                      width: 70,
                                      child: FittedBox(
                                        child: Row(
                                          children: [
                                            addHorizontalMargin(10),
                                            IconButton(
                                                padding: EdgeInsets.zero,
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.edit,
                                                  color: customThemeController
                                                      .getIconColor(),
                                                )),
                                            IconButton(
                                                padding: EdgeInsets.zero,
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: customThemeController
                                                      .getIconColor(),
                                                )),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Card(
                                    color: customThemeController.getCardColor(),
                                    child: Column(
                                      children: const [
                                        _TestSwitchTile(),
                                        _TestSwitchTile(),
                                      ],
                                    )),
                                addVerticalMargin(5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Tasks",
                                      style: bodyMedium().copyWith(
                                          color: customThemeController
                                              .getTextColor()),
                                    ),
                                    SizedBox(
                                      width: 70,
                                      child: FittedBox(
                                        child: Row(
                                          children: [
                                            addHorizontalMargin(10),
                                            IconButton(
                                                padding: EdgeInsets.zero,
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.edit,
                                                  color: customThemeController
                                                      .getIconColor(),
                                                )),
                                            IconButton(
                                                padding: EdgeInsets.zero,
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: customThemeController
                                                      .getIconColor(),
                                                )),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Card(
                                    color: customThemeController.getCardColor(),
                                    child: Column(
                                      children: const [
                                        _TestCheckboxTile(),
                                        _TestCheckboxTile(),
                                      ],
                                    )),
                              ],
                            ),
                          )),
                      Positioned(
                          bottom: 52,
                          right: 15,
                          child: SizedBox(
                            width: 33.0,
                            height: 33.0,
                            child: RawMaterialButton(
                              shape: const CircleBorder(),
                              elevation: 0.0,
                              fillColor: customThemeController
                                  .getThemeData.colorScheme.secondary,
                              child: Icon(
                                Icons.add,
                                color:
                                    themes.isDark ? Colors.black : Colors.white,
                                size: 20,
                              ),
                              onPressed: () {},
                            ),
                          )),
                      Positioned(
                          bottom: 0,
                          left: 5,
                          right: 5,
                          height: 45,
                          child:
                              Container() /* GNav(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 9, vertical: 6),
                          tabs: const [
                            GButton(
                              icon: Icons.home,
                              text: 'Home',
                            ),
                            GButton(
                              icon: Icons.checklist,
                              text: 'Page1',
                            ),
                            GButton(
                              icon: FontAwesomeIcons.diagramProject,
                              text: 'Page2',
                            ),
                          ],
                          selectedIndex: selectedIndex,
                          onTabChange: (index) {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                        ), */
                          ),
                    ],
                  )),
            ),
          ),
        ),
      );
    });
  }
}

class _TestCheckboxTile extends StatefulWidget {
  const _TestCheckboxTile();

  @override
  State<_TestCheckboxTile> createState() => __TestCheckboxTileState();
}

class __TestCheckboxTileState extends State<_TestCheckboxTile> {
  final _isChecked = true.obs;
  @override
  Widget build(BuildContext context) {
    SCustomThemeController customThemeController = Get.find();
    return ListTile(
      tileColor: customThemeController.getListTileColor(),
      dense: true,
      visualDensity: const VisualDensity(horizontal: -3, vertical: -3),
      title: Obx(() {
        return Text(
          "Test Checkbox",
          style: labelSmall().copyWith(
            color: customThemeController.getTextColor(),
          ),
        );
      }),
      leading: Icon(
        Icons.bookmark,
        size: 15,
        color: customThemeController.getListTileIconColor(),
      ),
      minLeadingWidth: 0,
      trailing: Transform.scale(
        scale: 0.7,
        child: Checkbox(
          value: _isChecked.value,
          onChanged: (value) {
            setState(() {
              _isChecked.value = value!;
            });
          },
        ),
      ),
    );
  }
}

class _TestSwitchTile extends StatefulWidget {
  const _TestSwitchTile();

  @override
  State<_TestSwitchTile> createState() => __TestSwitchTileState();
}

class __TestSwitchTileState extends State<_TestSwitchTile> {
  bool _isChecked = true;
  @override
  Widget build(BuildContext context) {
    SCustomThemeController customThemeController = Get.find();
    return ListTile(
      dense: true,
      tileColor: customThemeController.getListTileColor(),
      onTap: () {
        setState(() {
          _isChecked = !_isChecked;
        });
      },
      visualDensity: const VisualDensity(horizontal: -3, vertical: -3),
      title: Text(
        "Switch Test",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: labelSmall().copyWith(
          color: customThemeController.getTextColor(),
        ),
      ),
      leading: Icon(
        Icons.info_outline,
        size: 15,
        color: customThemeController.getListTileIconColor(),
      ),
      minLeadingWidth: 0,
      trailing: Transform.scale(
        scale: 0.7,
        child: Switch(
          value: _isChecked,
          onChanged: (value) {
            setState(() {
              _isChecked = value;
            });
          },
        ),
      ),
    );
  }
}
