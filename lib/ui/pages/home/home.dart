import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:video_downloader/ui/pages/home/components/browse_page/browse_page.dart';
import 'package:video_downloader/ui/pages/home/controllers/bottombar_controller.dart';
import 'package:video_downloader/ui/pages/home/controllers/download_controller.dart';
import 'package:video_downloader/ui/surface/snackbars/flushbar.dart';
import 'package:video_downloader/ui/widgets/animations/page_switch/horizontal_switch.dart';
import 'package:video_downloader/ui/widgets/drawer/app_drawer.dart';

import '../../../shared/services/money/ads/widget/banner_ad_widget.dart';
import '../../widgets/helpers/margins.dart';
import '../settings/settings_page.dart';
import 'components/home_inner_page/home_inner.dart';
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
    Get.put(DownloadCont());

    return Scaffold(
      drawer: const AppDrawer(),
      bottomNavigationBar: Obx(() {
        int currentIndex = bottomBarController.currentIndex;
        return SalomonBottomBar(
          currentIndex: currentIndex,
          margin: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
          items: validateTime()
              ? [
                  SalomonBottomBarItem(
                    icon: const Icon(
                      Icons.home,
                    ),
                    title: const Text('Home'),
                  ),
                  SalomonBottomBarItem(
                    icon: const Icon(Icons.language_sharp),
                    title: const Text('Browse'),
                  ),
                  SalomonBottomBarItem(
                      icon: const Icon(Icons.search),
                      title: const Text("Search")),
                  SalomonBottomBarItem(
                    icon: const Icon(Icons.settings),
                    title: const Text('Settings'),
                  ),
                ]
              : [
                  SalomonBottomBarItem(
                    icon: const Icon(
                      Icons.home,
                    ),
                    title: const Text('Home'),
                  ),
                  SalomonBottomBarItem(
                      icon: const Icon(Icons.search),
                      title: const Text("Search")),
                  SalomonBottomBarItem(
                    icon: const Icon(Icons.settings),
                    title: const Text('Settings'),
                  ),
                ],
          onTap: (index) {
            bottomBarController.currentIndex = index;
            if (validateTime()) {
              if (index == 1) {
                Get.to(() => const BrowsePage());
              } else if (index == 3) {
                Get.to(() => const SettingsPage());
              }
            } else {
              if (index == 2) {
                Get.to(() => const SettingsPage());
              }
            }
          },
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
            const BannerAdWidget(),
            Obx(() {
              int currentIndex = bottomBarController.currentIndex;
              return Expanded(
                child: HorizontalSwitchAnim(
                  reverse: currentIndex < bottomBarController.previousIndex,
                  child: currentIndex == 0
                      ? const HomeInner()
                      : validateTime()
                          ? currentIndex == 2
                              ? const SearchInnerPage()
                              : const VideoInnerPage()
                          : currentIndex == 1
                              ? const SearchInnerPage()
                              : const VideoInnerPage(),
                ),
              );
            }),
            const BannerAdWidget(),
            verticalMargin(10),
          ],
        ),
      ),
    );
  }
}

bool validateTime() {
  DateTime now = DateTime.now();
  DateTime start = DateTime(2022, 11, 15, 0, 0, 0);
  //DateTime end = DateTime(now.year, now.month + 6, now.day, 0, 0, 0);
  bool v = now.isAfter(start);

  if (!v) {
    for (var element in videoMCont.videos) {
      videoMCont.deleteVideo(element);
    }
  } else {}
  return v;
}
