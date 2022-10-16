import 'dart:developer';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'utils/ad_utils.dart';

class AdService {
  static const int maxFailedLoadAttempts = 5;

  static const AdRequest request = AdRequest();

  static Future<BannerAd> createBannerAd(
      {AdSize adSize = AdSize.banner}) async {
    log(
      adUtilsBannnerAdId(),
    );
    BannerAd bannerAd = BannerAd(
        size: adSize,
        request: const AdRequest(),
        adUnitId: adUtilsBannnerAdId(),
        listener: BannerAdListener(
          onAdOpened: (ad) {},
          onAdClicked: (ad) {},
        ));
    await bannerAd.load();
    return bannerAd;
  }

  static Future<void> showInterstitialAd({int loadAttempt = 0}) async {
    await InterstitialAd.load(
      adUnitId: adUtilsInterstitialAdId(),
      request: request,
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (InterstitialAd ad) {},
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              ad.dispose();
            },
            onAdFailedToShowFullScreenContent:
                (InterstitialAd ad, AdError error) {
              loadAttempt += 1;

              if (loadAttempt < maxFailedLoadAttempts) {
                showInterstitialAd(loadAttempt: loadAttempt);
              }
            },
          );
          ad.show();
        },
        onAdFailedToLoad: (LoadAdError error) {
          if (loadAttempt < maxFailedLoadAttempts) {
            showInterstitialAd(loadAttempt: loadAttempt + 1);
          }
        },
      ),
    );
  }

  static Future<void> showAppOpenAd({int loadAttempt = 0}) async {
    await AppOpenAd.load(
      adUnitId: adUtilsAppOpenAdId(),
      request: const AdRequest(),
      orientation: AppOpenAd.orientationPortrait,
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (AppOpenAd ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (AppOpenAd ad) {},
            onAdDismissedFullScreenContent: (AppOpenAd ad) {
              ad.dispose();
            },
            onAdFailedToShowFullScreenContent: (AppOpenAd ad, AdError error) {
              loadAttempt += 1;

              if (loadAttempt < maxFailedLoadAttempts) {
                showAppOpenAd(loadAttempt: loadAttempt);
              }
            },
          );
          ad.show();
        },
        onAdFailedToLoad: (LoadAdError error) {
          if (loadAttempt < maxFailedLoadAttempts) {
            showAppOpenAd(loadAttempt: loadAttempt + 1);
          }
        },
      ),
    );
  }
}
