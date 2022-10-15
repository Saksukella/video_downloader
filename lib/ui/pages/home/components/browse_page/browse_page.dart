import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:video_downloader/ui/pages/home/controllers/bottombar_controller.dart';
import 'package:video_downloader/ui/pages/home/controllers/video_controller.dart';
import 'package:video_downloader/ui/widgets/helpers/margins.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../../services/ads/app_admob.dart';
import '../../../../../services/models/video_model.dart';
import '../../../../surface/snackbars/flushbar.dart';

class BrowsePage extends StatefulWidget {
  const BrowsePage({super.key});

  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  WebViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Browse'),
        leading: BackButton(
          onPressed: () {
            BottomBarController bottomBarController = Get.find();
            bottomBarController.currentIndex = 2;
            Navigator.pop(context);
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: "",
            child: const Icon(Icons.remove_red_eye),
            onPressed: () {
              showFlushbarProgress();
            },
          ),
          verticalMargin(10.h),
          FloatingActionButton(
            onPressed: () async {
              VideoMController mController = Get.find();
              if (controller == null) {
                return;
              }
              String? cu;
              try {
                cu = await controller?.currentUrl();
              } on Exception catch (e) {
                showFlushbar(title: "Error", message: e.toString());
              }
              if (cu == null) {
                return;
              }
              String id = YoutubePlayer.convertUrlToId(cu) ?? "";
              final title = await controller?.getTitle();

              if (!cu.contains('youtube.com/watch?v=')) {
                return;
              }
              if (mController.videos.any((element) => element.id == id)) {
                VideoModel videoModel = mController.getVideo(id);
                if (videoModel.downloadProgress == 100) {
                  showFlushbar(
                      message: 'Video is already downloaded',
                      color: Colors.red,
                      icon: Icons.error);
                }

                showFlushbar(
                    message: 'Video is downloading',
                    color: Colors.red,
                    icon: Icons.error);
                return;
              }
              VideoModel v = VideoModel(
                  id: id,
                  url: cu,
                  title: title ?? "",
                  downloadDate: DateTime.now(),
                  downloadProgress: 0);
              mController.videos.add(v);

              mController.download(v);
            },
            child: const Icon(Icons.download),
          ),
          verticalMargin(25.h),
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (await controller!.canGoBack()) {
            controller!.goBack();
            return false;
          }
          BottomBarController bottomBarController = Get.find();
          bottomBarController.currentIndex = 2;
          return true;
        },
        child: Column(
          children: [
            FutureBuilder(
              future: AdService().createBannerAd(adSize: AdSize.fullBanner),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  BannerAd bannerAd = snapshot.data!;
                  return SizedBox(
                    height: bannerAd.size.height.toDouble(),
                    width: bannerAd.size.width.toDouble(),
                    child: AdWidget(ad: bannerAd),
                  );
                } else {
                  return Container();
                }
              },
            ),
            Expanded(
              child: WebView(
                onWebViewCreated: (c) async {
                  controller = c;
                },
                initialUrl: 'https://www.youtube.com/',
                javascriptMode: JavascriptMode.unrestricted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
