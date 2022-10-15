import 'package:flutter/material.dart';

class SAnimModels {
  List<String> keys;
  Widget widget;

  String title;
  IconData iconData;
  bool curveEnabled;
  bool visibleControls;
  double maxDuration;
  double frameWidth;
  double frameHeight;
  double animDurationScale;

  SAnimModels(
      {required this.keys,
      required this.widget,
      required this.title,
      required this.iconData,
      this.curveEnabled = true,
      this.visibleControls = true,
      this.maxDuration = 5000,
      this.frameHeight = 250,
      this.frameWidth = 200,
      this.animDurationScale = 1});
}
