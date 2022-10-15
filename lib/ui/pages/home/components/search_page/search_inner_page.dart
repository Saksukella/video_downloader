import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:video_downloader/services/models/video_model.dart';
import 'package:video_downloader/ui/pages/home/controllers/video_controller.dart';
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

  String? safeUrl() {
    if (controller.text.startsWith("https://m.youtube.com/watch?v=") ||
        controller.text.startsWith("https://www.youtube.com/watch?v=")) {
      return YoutubePlayer.convertUrlToId(controller.text);
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    VideoMController videoMController = Get.find();

    final YoutubePlayerController playerController = YoutubePlayerController(
      initialVideoId: safeUrl() ?? '',
      flags: const YoutubePlayerFlags(
        showLiveFullscreenButton: false,
        autoPlay: false,
        mute: true,
      ),
    );

    return Obx(() {
      log(videoMController.videos.toString());
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.w),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              verticalMargin(10.h),
              playerController.initialVideoId != ""
                  ? Transform.scale(
                      scale: 0.9,
                      child: YoutubePlayer(controller: playerController))
                  : Container(),
              verticalMargin(10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  children: <Widget>[
                    Visibility(
                      visible: safeUrl() == "",
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Lottie.asset(
                          'assets/jsons/download.json',
                          repeat: true,
                          animate: true,
                        ),
                      ),
                    ),
                    verticalMargin(15),
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
                        hintText: "Enter Video Url",
                        suffixIcon: IconButton(
                            onPressed: () {
                              controller.clear();
                              setState(() {});
                            },
                            icon: const Icon(Icons.close)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                      ),
                    ),
                    verticalMargin(20.h),
                    MaterialButton(
                      onPressed: () {
                        if (safeUrl() != "") {
                          YoutubeMetaData y = playerController.metadata;
                          playerController.addListener(() {
                            if (playerController.value.isReady) {
                              log(playerController.metadata.title);
                            }
                          });

                          VideoModel v = VideoModel(
                              id: y.videoId,
                              url: controller.text,
                              title: y.title,
                              downloadDate: DateTime.now(),
                              downloadProgress: 0);

                          videoMController.videos.add(v);

                          videoMController.download(v);
                        } else {
                          showFlushbar(
                            title: "Invalid Url",
                            message: "Please enter a valid youtube url",
                            icon: Icons.error,
                            color: Colors.red,
                          );
                        }
                      },
                      height: 43.h,
                      minWidth: 300.w,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      color: theme.colorScheme.primaryContainer,
                      child: const Text("Download"),
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
