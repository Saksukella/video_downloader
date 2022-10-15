import 'dart:io';

import 'package:flutter/foundation.dart';

import '../res/ad_unit_ids.dart';

String adUtilsBannnerAdId() {
  if (kDebugMode) {
    return AdUnitKeys.bannerTest;
  }
  if (Platform.isAndroid) {
    return AdUnitKeys.bannerAndroid;
  } else if (Platform.isIOS) {
    return AdUnitKeys.bannerIOS;
  } else {
    throw UnsupportedError('Unsupported platform');
  }
}

String adUtilsInterstitialAdId() {
  if (kDebugMode) {
    return AdUnitKeys.interstitialTest;
  }
  if (Platform.isAndroid) {
    return AdUnitKeys.interstitialAndroid;
  } else if (Platform.isIOS) {
    return AdUnitKeys.interstitialIOS;
  } else {
    throw UnsupportedError('Unsupported platform');
  }
}

String adUtilsAppOpenAdId() {
  if (kDebugMode) {
    return AdUnitKeys.appOpenTest;
  }
  if (Platform.isAndroid) {
    return AdUnitKeys.appOpenAndroid;
  } else if (Platform.isIOS) {
    return AdUnitKeys.appOpenIOS;
  } else {
    throw UnsupportedError('Unsupported platform');
  }
}
