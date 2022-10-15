import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../native/card/animated_card.dart';
import '../../../native/columns/titled_widget.dart';
import '../../../native/size/margins.dart';
import '../../theme/utils/theme_utils.dart';
import '../user_widgets/user_expansion_panel_radio.dart';
import 'components/main_colors.dart';
import 'components/subtheme.dart';
import 'components/text_theme/text_theme.dart';
import 'controllers/theme_controller.dart';

class SCustomThemes extends StatelessWidget {
  const SCustomThemes({super.key, required this.scrollController});
  final ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    SCustomThemeController themeController = Get.put(SCustomThemeController());
    final GlobalKey key = GlobalKey();
    return Obx(() {
      return TitledWidget(
          title: "Themes",
          child: AnimatedCard(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalMargin(5),
              SwitchListTile(
                title: const Text("Dark Mode"),
                value: theme.brightness == Brightness.dark,
                onChanged: (value) {
                  themes.isDark = value;
                },
              ),
              const Divider(),
              SUserExpansionPanelRadio(
                key: key,
                panelList: [
                  userExpansionPanelItem(
                    value: 0,
                    headerBuilder: (context, isExpanded) {
                      return const ListTile(
                        title: Text("Theme"),
                        minLeadingWidth: 0,
                        leading: Icon(Icons.format_color_fill_outlined),
                      );
                    },
                    body: SThemeMainColors(),
                  ),
                  userExpansionPanelItem(
                    value: 1,
                    headerBuilder: (context, isExpanded) {
                      return const ListTile(
                        title: Text("SubTheme"),
                        minLeadingWidth: 0,
                        leading: Icon(Icons.subdirectory_arrow_right),
                      );
                    },
                    body: SSubTheme(),
                  ),
                  userExpansionPanelItem(
                    value: 2,
                    headerBuilder: (context, isExpanded) {
                      return const ListTile(
                        title: Text("Text"),
                        minLeadingWidth: 0,
                        leading: Icon(Icons.text_fields_sharp),
                      );
                    },
                    body: SThemeText(),
                  ),
                ],
                scrollOffset: 250,
                listViewController: scrollController,
              ),
              addVerticalMargin(5),
            ],
          )));
    });
  }
}
