import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:video_downloader/services/ads/utils/ad_utils.dart';

class AdService {
  final int maxFailedLoadAttempts = 5;

  final AdRequest request = const AdRequest();

  BannerAdListener get getBannerAdListener => _bannerAdListener;
  final BannerAdListener _bannerAdListener = BannerAdListener(
    onAdOpened: (ad) {},
    onAdClicked: (ad) {},
  );

  Future<BannerAd> createBannerAd({AdSize adSize = AdSize.banner}) async {
    BannerAd bannerAd = BannerAd(
        size: adSize,
        request: const AdRequest(),
        adUnitId: adUtilsBannnerAdId(),
        listener: _bannerAdListener);
    await bannerAd.load();
    return bannerAd;
  }

  Future<void> showInterstitialAd({int loadAttempt = 0}) async {
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
                showRewaredInterstitialAd(loadAttempt: loadAttempt);
              }
            },
          );
          ad.show();
        },
        onAdFailedToLoad: (LoadAdError error) {
          if (loadAttempt < maxFailedLoadAttempts) {
            showRewaredInterstitialAd(loadAttempt: loadAttempt + 1);
          }
        },
      ),
    );
  }

  Future<void> showRewaredInterstitialAd({int loadAttempt = 0}) async {
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
                showRewaredInterstitialAd(loadAttempt: loadAttempt);
              }
            },
          );
          ad.show();
        },
        onAdFailedToLoad: (LoadAdError error) {
          if (loadAttempt < maxFailedLoadAttempts) {
            showRewaredInterstitialAd(loadAttempt: loadAttempt + 1);
          }
        },
      ),
    );
  }

  Future<void> showAppOpenAd({int loadAttempt = 0}) async {
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
