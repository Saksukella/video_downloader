import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';

import 'utils/asset/asset_utils.dart';

class SResourses {
  static String appIconAsset = assetPng("launcher_icon");

  static const int animationDuration = 400;

  static const String animationCurve = "EaseInOut";

  static const int schemeIndex = 2;

  static const int textsize = 17;

  static final bool darkmode =
      SchedulerBinding.instance.window.platformBrightness == Brightness.dark;

  static const String txtstyleText = "Norican";

  static TextStyle textStyle = GoogleFonts.amaranth();

  static const String userAvatarHero = "userAvatarHero";
  static String userDefaultPhoto = assetPng("user");
}
