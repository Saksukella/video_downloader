import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../app_admob.dart';

class BannerAdWidget extends StatelessWidget {
  const BannerAdWidget({super.key, this.adSize = AdSize.banner});

  final AdSize adSize;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AdService.createBannerAd(adSize: adSize),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          BannerAd ad = snapshot.data!;
          return Container(
              height: ad.size.height.toDouble(),
              width: ad.size.width.toDouble(),
              child: AdWidget(ad: snapshot.data!));
        }
        return Container();
      },
    );
  }
}
