import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_downloader/shared/res/utils/asset/asset_utils.dart';
import 'package:video_downloader/shared/services/in_app_review/in_app_review.dart';
import 'package:video_downloader/shared/services/info/package_info.dart';
import 'package:video_downloader/shared/services/money/ads/widget/banner_ad_widget.dart';
import 'package:video_downloader/shared/ui/app_theme/customization/customization.dart';
import 'package:video_downloader/shared/ui/app_theme/theme/utils/text_utils.dart';
import 'package:video_downloader/shared/ui/native/card/animated_card.dart';
import 'package:video_downloader/shared/ui/native/columns/titled_widget.dart';
import 'package:video_downloader/shared/ui/native/dividers/divider1.dart';
import 'package:video_downloader/shared/ui/native/surface/dialog/raw_dialog.dart';
import 'package:video_downloader/ui/pages/home/controllers/bottombar_controller.dart';
import 'package:video_downloader/ui/pages/home/controllers/video_controller.dart';
import 'package:video_downloader/ui/pages/home/utils/file_utils.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return WillPopScope(
        onWillPop: () async {
          BottomBarController bottomBarController = Get.find();
          bottomBarController.currentIndex = 0;
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 12),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      TitledWidget(
                        title: "Video Settings",
                        child: AnimatedCard(
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                    "Delete All Videos (${videoMCont.videos.length})"),
                                trailing: TextButton(
                                  onPressed: () {
                                    dialogwButtons(
                                      title: "Delete",
                                      content: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("Delete All Videos?"),
                                      ),
                                    ).then((value) {
                                      if (value == null) return;

                                      for (var video in videoMCont.videos) {
                                        videoMCont.deleteVideo(video);
                                      }
                                    });
                                  },
                                  child: Text(
                                    "Delete",
                                    style: bodyMedium()
                                        .copyWith(color: Colors.red),
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                    "Share All Videos (${videoMCont.videos.length})"),
                                trailing: TextButton(
                                  onPressed: () async {
                                    List<File> files = [];
                                    for (var video in videoMCont.videos) {
                                      files.add(
                                          await videoFilefromName(video.id));
                                    }
                                    if (files.isNotEmpty) {
                                      Share.shareFiles(
                                          files.map((e) => e.path).toList());
                                    }
                                  },
                                  child: const Text("Share"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      TitledWidget(
                          title: "General",
                          child: Column(
                            children: [
                              AnimatedCard(
                                  child: Column(
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.color_lens),
                                    title: const Text("Customization"),
                                    trailing:
                                        const Icon(Icons.arrow_forward_ios),
                                    onTap: () {
                                      Get.to(() => const SCustomizations());
                                    },
                                  ),
                                  ListTile(
                                    title: const Text("About"),
                                    leading: const Icon(Icons.info),
                                    onTap: () {
                                      showAboutDialog(
                                        context: context,
                                        applicationVersion: SAppInfo.version,
                                        applicationName: SAppInfo.appName,
                                        applicationIcon: SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: Image.asset(
                                              "assets/icons/launcher_icon.png"),
                                        ),
                                      );
                                    },
                                    trailing:
                                        const Icon(Icons.arrow_forward_ios),
                                  ),
                                ],
                              )),
                              const Divider08(),
                              AnimatedCard(
                                child: ListTile(
                                  leading: SizedBox(
                                      width: 45,
                                      height: 45,
                                      child:
                                          Lottie.asset(assetJson("support"))),
                                  title: const Text("Support Developer!"),
                                  subtitle: const Text(
                                      "You can support me by just rating the app!"),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: () {
                                    //AppReviewServ.openStoreListing();
                                    AppReviewServ.requestReview();
                                  },
                                ),
                              )
                            ],
                          ))
                    ]),
              ),
              const BannerAdWidget(adSize: AdSize(width: 550, height: 95)),
            ],
          ),
        ),
      );
    });
  }
}
