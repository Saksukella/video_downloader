import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../services/preferences/utils/pref_operations.dart';
import '../../../native/card/animated_card.dart';
import '../../../native/columns/titled_widget.dart';
import '../../../native/size/margins.dart';
import '../../theme/utils/theme_utils.dart';
import '../theme/widgets/textbuttons.dart';
import '../user_widgets/user_expansion_panel_radio.dart';
import '../widgets/setting_disabled.dart';
import 'Utils/key_utils.dart';
import 'controllers/animation_controller.dart';
import 'dialogs/edit_animation.dart';
import 'res/animation_keys.dart';
import 'res/data.dart';
import 'res/panel_list.dart';

class SCustomAnimations extends StatefulWidget {
  const SCustomAnimations({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  State<SCustomAnimations> createState() => _SCustomAnimationsState();
}

class _SCustomAnimationsState extends State<SCustomAnimations> {
  @override
  Widget build(BuildContext context) {
    bool isAnimEnabled = readPrefBool(SAnimationKeys.animation_enabled) ?? true;

    for (var i = 0; i < anim_models.length; i++) {
      SCustomAnimationController animController = Get.put(
          SCustomAnimationController(keys: anim_models[i].keys),
          tag: anim_models[i].keys[0]);
    }
    final colorizeColors = [
      theme.primaryColor,
      theme.colorScheme.secondary,
      theme.colorScheme.tertiary,
    ];

    return TitledWidget(
        title: "Animations",
        child: AnimatedCard(
          child: Column(
            children: [
              addVerticalMargin(5),
              SwitchListTile(
                  value: isAnimEnabled,
                  title: const Text(
                    "Enable Animations",
                  ),
                  onChanged: (value) {
                    isAnimEnabled = !isAnimEnabled;
                    writePrefBool(SAnimationKeys.animation_enabled, value);
                    setState(() {});
                    Get.back();
                  }),
              const Divider(),
              isAnimEnabled
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        addVerticalMargin(10),
                        const Text(
                          "Settings",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        addVerticalMargin(10),
                        SUserExpansionPanelRadio(
                            scrollOffset: 300,
                            listViewController: widget.scrollController,
                            panelList: [
                              userExpansionPanelItem(
                                  value: 0,
                                  headerBuilder: (context, isExpanded) {
                                    return const ListTile(
                                      title: Text("Animation Settings"),
                                      leading: Icon(Icons.settings_outlined),
                                      minLeadingWidth: 0,
                                    );
                                  },
                                  body: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10,
                                        left: 10,
                                        right: 10,
                                        top: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SResetRandomSaveButtons(
                                          resetAll: () {
                                            for (var element
                                                in getAnimationUtils_ControllerKeys()) {
                                              Get.find<SCustomAnimationController>(
                                                      tag: element)
                                                  .reset();
                                            }
                                          },
                                          editAll: () {
                                            showDialog_Edit_Animation_All(
                                                getAnimationUtils_ControllerKeys());
                                          },
                                        ),
                                        SUserExpansionPanelRadio(
                                            scrollOffset: 350,
                                            listViewController:
                                                widget.scrollController,
                                            panelList: animQuickSPanels),
                                      ],
                                    ),
                                  ))
                            ]),
                      ],
                    )
                  : SSettingDisabled(
                      isEnable: isAnimEnabled,
                      title: "Animations are disabled"),
              isAnimEnabled
                  ? Column(
                      children: [
                        addVerticalMargin(20),
                        Row(
                          children: [
                            AnimatedTextKit(
                              animatedTexts: [
                                ColorizeAnimatedText(
                                  'Live Animations',
                                  textStyle: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  colors: colorizeColors,
                                  speed: const Duration(milliseconds: 700),
                                ),
                              ],
                              isRepeatingAnimation: true,
                              repeatForever: true,
                              onTap: () {
                                print("Tap Event");
                              },
                            ),
                          ],
                        ),
                        addVerticalMargin(10),
                        SUserExpansionPanelRadio(
                            scrollOffset: 550,
                            listViewController: widget.scrollController,
                            panelList: animPanels)
                      ],
                    )
                  : Container(),
              addVerticalMargin(5)
            ],
          ),
        ));
  }
}
