import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:video_downloader/ui/pages/home/components/browse_page/browse_page.dart';
import 'package:video_downloader/ui/pages/home/controllers/bottombar_controller.dart';
import 'package:video_downloader/ui/surface/snackbars/flushbar.dart';
import 'package:video_downloader/ui/widgets/animations/page_switch/horizontal_switch.dart';
import 'package:video_downloader/ui/widgets/drawer/app_drawer.dart';

import '../../../services/ads/app_admob.dart';
import '../../widgets/helpers/margins.dart';
import 'components/search_page/search_inner_page.dart';
import 'components/video_page/video_inner_page.dart';
import 'controllers/video_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    BottomBarController bottomBarController = Get.put(BottomBarController());
    VideoMController videoMController = Get.put(VideoMController());

    return Scaffold(
      drawer: const AppDrawer(),
      bottomNavigationBar: Obx(() {
        int currentIndex = bottomBarController.currentIndex;
        return BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            bottomBarController.currentIndex = index;
            if (index == 0) {
              Get.to(() => const BrowsePage());
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.language_sharp),
              label: 'Browse',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.download),
              label: 'Videos',
            )
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: const Icon(Icons.remove_red_eye),
          onPressed: () {
            showFlushbarProgress();
          }),
      body: SafeArea(
        child: Column(
          children: [
            FutureBuilder(
                future: AdService().createBannerAd(adSize: AdSize.fullBanner),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    BannerAd bannerAd = snapshot.data!;
                    return Container(
                      height: bannerAd.size.height.toDouble(),
                      width: bannerAd.size.width.toDouble(),
                      color: Colors.transparent,
                      child: AdWidget(ad: bannerAd),
                    );
                  } else {
                    return Container();
                  }
                }),
            Obx(() {
              int currentIndex = bottomBarController.currentIndex;
              return Expanded(
                child: HorizontalSwitchAnim(
                  reverse: currentIndex < bottomBarController.previousIndex,
                  child: currentIndex == 1
                      ? const SearchInnerPage()
                      : const VideoInnerPage(),
                ),
              );
            }),
            FutureBuilder(
              future: AdService().createBannerAd(adSize: AdSize.fullBanner),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  BannerAd bannerAd = snapshot.data!;
                  return Container(
                    height: bannerAd.size.height.toDouble(),
                    width: bannerAd.size.width.toDouble(),
                    color: Colors.transparent,
                    child: AdWidget(ad: bannerAd),
                  );
                } else {
                  return Container();
                }
              },
            ),
            verticalMargin(10.sp),
          ],
        ),
      ),
    );
  }
}
