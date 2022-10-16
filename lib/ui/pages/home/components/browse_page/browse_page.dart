import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_downloader/shared/services/money/ads/widget/banner_ad_widget.dart';
import 'package:video_downloader/ui/pages/home/controllers/bottombar_controller.dart';
import 'package:video_downloader/ui/pages/home/controllers/video_controller.dart';
import 'package:video_downloader/ui/widgets/helpers/margins.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../../services/models/downloading_model.dart';
import '../../../../../services/models/video_model.dart';
import '../../../../surface/snackbars/flushbar.dart';
import '../../controllers/download_controller.dart';

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
            bottomBarController.currentIndex = 0;
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

              VideoModel? videoModel = mController.getVideo(id);
              if (videoModel != null) {
                showFlushbar(
                    message: 'Video is already downloaded',
                    color: Colors.red,
                    icon: Icons.error);
                return;
              }
              if (downloadCont.downloading
                          .firstWhereOrNull((element) => element.id == id) ==
                      null
                  ? false
                  : true) {
                showFlushbar(
                    message: 'Video is downloading',
                    color: Colors.red,
                    icon: Icons.error);
                return;
              }
              DownloadingModel d = DownloadingModel(
                  id: id, title: title ?? "Untitled", progress: 0);

              downloadCont.addDownloading(d);
              downloadCont.download(d);
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
            const BannerAdWidget(),
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
