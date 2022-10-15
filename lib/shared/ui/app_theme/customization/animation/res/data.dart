import 'package:flutter/material.dart';

import '../items/card_anim.dart';
import '../items/expansion_anim.dart';
import '../items/transition_anim.dart';
import '../models/animation_key_widget.dart';
import 'animation_keys.dart';

List<List<String>> anim_keys = [
  [
    SAnimationKeys.CARD_ANIM_DURATION,
    SAnimationKeys.CARD_ANIM_CURVE,
  ],
  [
    SAnimationKeys.EXPANSION_ANIM_DURATION,
    SAnimationKeys.EXPANSION_ANIM_CURVE,
  ],
  [
    SAnimationKeys.TRANSITION_ANIM_DURATION,
    SAnimationKeys.TRANSITION_ANIM_CURVE,
  ],
];
List<SAnimModels> anim_models = [
  SAnimModels(
    title: "Card",
    iconData: Icons.calendar_view_day,
    keys: anim_keys[0],
    frameHeight: 350,
    widget: SCardAnimation(),
  ),
  SAnimModels(
    title: "Expansion",
    iconData: Icons.expand_circle_down,
    curveEnabled: false,
    visibleControls: false,
    keys: anim_keys[1],
    widget: SExpansionAnimation(),
  ),
  SAnimModels(
    title: "Transition",
    iconData: Icons.last_page_outlined,
    frameHeight: 150,
    maxDuration: 1000,
    curveEnabled: false,
    visibleControls: false,
    keys: anim_keys[2],
    widget: STransitionAnimation(),
  ),
];
