import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:video_downloader/services/models/downloading_model.dart';
import 'package:video_downloader/shared/res/utils/asset/asset_utils.dart';
import 'package:video_downloader/ui/pages/home/controllers/download_controller.dart';
import 'package:video_downloader/ui/pages/home/home.dart';
import 'package:video_downloader/ui/surface/snackbars/flushbar.dart';
import 'package:video_downloader/ui/widgets/helpers/margins.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../../shared/ui/app_theme/theme/utils/theme_utils.dart';

class SearchInnerPage extends StatefulWidget {
  const SearchInnerPage({super.key});

  @override
  State<SearchInnerPage> createState() => _SearchInnerPageState();
}

class _SearchInnerPageState extends State<SearchInnerPage> {
  TextEditingController controller = TextEditingController();

  String? safeID() {
    if (controller.text.startsWith("https://m.youtube.com/watch?v=") ||
        controller.text.startsWith("https://www.youtube.com/watch?v=")) {
      return YoutubePlayer.convertUrlToId(controller.text);
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final YoutubePlayerController playerController = YoutubePlayerController(
      initialVideoId: safeID() ?? '',
      flags: const YoutubePlayerFlags(
        showLiveFullscreenButton: false,
        autoPlay: false,
        mute: true,
      ),
    );

    return Obx(() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.w),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              verticalMargin(11.h),
              playerController.initialVideoId != ""
                  ? Transform.scale(
                      scale: 0.91,
                      child: YoutubePlayer(controller: playerController))
                  : Container(),
              verticalMargin(11.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  children: <Widget>[
                    Visibility(
                      visible: safeID() == "",
                      child: SizedBox(
                        height: 105,
                        width: 105,
                        child: Lottie.asset(
                          assetJson("download"),
                          repeat: true,
                          animate: true,
                        ),
                      ),
                    ),
                    verticalMargin(17),
                    TextField(
                      minLines: 1,
                      maxLines: 5,
                      autofocus: false,
                      controller: controller,
                      keyboardType: TextInputType.multiline,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        hintText: validateTime() ? "Enter Video Url" : "Url",
                        suffixIcon: IconButton(
                            onPressed: () {
                              controller.clear();
                              setState(() {});
                            },
                            icon: const Icon(Icons.close)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    verticalMargin(22.h),
                    MaterialButton(
                      onPressed: () {
                        if (safeID() != "" && validateTime()) {
                          YoutubeMetaData y = playerController.metadata;
                          playerController.addListener(() {
                            if (playerController.value.isReady) {
                              log(playerController.metadata.title);
                            }
                          });

                          log("video id is ${safeID()}");

                          DownloadingModel d = DownloadingModel(
                              id: safeID()!, title: y.title, progress: 0);

                          downloadCont.addDownloading(d);
                          downloadCont.download(d);
                        } else {
                          showFlushbar(
                            title: "Invalid Url",
                            message: "Please enter a valid url",
                            icon: Icons.error,
                            color: Colors.red,
                          );
                        }
                      },
                      height: 41.h,
                      minWidth: 300.w,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      color: theme.colorScheme.primaryContainer,
                      child: Text(validateTime() ? "Download" : "Find"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
