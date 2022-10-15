import 'package:flutter/material.dart';

import '../../user_widgets/user_expansion_panel_radio.dart';
import '../components/animation_items.dart';
import '../components/animation_quick_settings_item.dart';
import 'data.dart';

final List<ExpansionPanelRadio> animQuickSPanels = anim_models
    .map(
      (e) => userExpansionPanelItem(
        value: e,
        headerBuilder: (context, isExpanded) {
          return ListTile(
            title: Text(e.title),
          );
        },
        body: SAnimationQuickSettingsItem(model: e),
      ),
    )
    .toList();

final List<ExpansionPanelRadio> animPanels = anim_models
    .map((e) => userExpansionPanelItem(
          value: e,
          headerBuilder: (context, isExpanded) {
            return ListTile(
              title: Text(e.title),
              leading: Icon(
                e.iconData,
              ),
              minLeadingWidth: 0,
            );
          },
          body: SAnimationItem(
            animModel: e,
          ),
        ))
    .toList();
