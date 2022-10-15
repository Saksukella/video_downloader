import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_downloader/services/models/video_model.dart';
import 'package:video_downloader/shared/ui/native/dividers/divider1.dart';
import 'package:video_downloader/ui/pages/home/controllers/video_controller.dart';
import 'package:video_downloader/ui/pages/home/utils/date_utils.dart';
import 'package:video_downloader/ui/pages/home/utils/file_utils.dart';
import 'package:video_downloader/ui/pages/home/utils/video_utils.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../widgets/helpers/margins.dart';

class VideoInnerPage extends StatefulWidget {
  const VideoInnerPage({super.key});

  @override
  State<VideoInnerPage> createState() => _VideoInnerPageState();
}

class _VideoInnerPageState extends State<VideoInnerPage> {
  List<ChewieController> videoControllers = [];

  Future<void> _initVideos(VideoMController videoMControl) async {
    videoControllers.clear();
    for (var element in videoMControl.downloadedVideos) {
      var v = VideoPlayerController.file(await videoFilefromName(element.id));
      await v.initialize();
      ChewieController chewieController = ChewieController(
        aspectRatio: 3.4 / 2,
        startAt: videoUtilsLastDurationSecond(element.id),
        deviceOrientationsAfterFullScreen: [
          DeviceOrientation.portraitUp,
        ],
        videoPlayerController: v,
      );

      videoControllers.add(chewieController);
    }
  }

  @override
  void dispose() {
    super.dispose();
    for (var element in videoControllers) {
      element.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      onRefresh: () async {
        await _initVideos(Get.find<VideoMController>());
        setState(() {});
      },
      child: FutureBuilder(
          future: _initVideos(Get.find<VideoMController>()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (videoControllers.isEmpty) {
                return const Center(
                  child: Text("No videos downloaded"),
                );
              }
              return _VideoList(
                  videoMController: Get.find<VideoMController>(),
                  videoControllers: videoControllers);
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

class _VideoList extends StatelessWidget {
  const _VideoList({
    required this.videoMController,
    required this.videoControllers,
  });

  final VideoMController videoMController;
  final List<ChewieController> videoControllers;

  @override
  Widget build(BuildContext context) {
    return GroupedListView<VideoModel, String>(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      physics: const BouncingScrollPhysics(),
      elements: videoMController.downloadedVideos,
      groupBy: (element) => mdy(element.downloadDate),
      groupComparator: (value1, value2) => value2.compareTo(value1),

      separator: const Divider1(),
      groupSeparatorBuilder: (String groupByValue) => Chip(
        label: Text(
          groupByValue,
          style: const TextStyle(fontSize: 16),
        ),
      ),
      itemBuilder: (context, element) {
        if (videoControllers.length !=
            videoMController.downloadedVideos.length) {
          return SizedBox(
            height: Get.height / 2,
            width: Get.width,
            child: const Center(child: CircularProgressIndicator()),
          );
        }
        ChewieController controller = videoControllers[
            videoMController.downloadedVideos.indexOf(element)];

        Timer.periodic(const Duration(milliseconds: 100), (timer) {
          videoUtilsSetLastDurationSecond(
              element.id, controller.videoPlayerController.value.position);
        });

        return VisibilityDetector(
          key: Key(element.id),
          onVisibilityChanged: (visibilityInfo) {
            if (visibilityInfo.visibleFraction == 0) {
              if (!controller.isFullScreen) {
                controller.pause();
              }
            }
          },
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      element.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () async {
                            var f = await videoFilefromName(element.title);
                            Share.shareFiles([f.path], text: element.title);
                          },
                          icon: const Icon(Icons.share)),
                      IconButton(
                          onPressed: () {
                            videoMController.deleteVideo(element);
                          },
                          icon: const Icon(Icons.delete)),
                    ],
                  ),
                ],
              ),
              verticalMargin(10),
              Transform.scale(
                scale: 1,
                child: AspectRatio(
                  aspectRatio: controller.aspectRatio!,
                  child: Chewie(controller: controller),
                ),
              ),
              verticalMargin(10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(element.title),
              ),
            ],
          ),
        );
      }, // optional
      // optional
      order: GroupedListOrder.ASC, // optional
    );
  }
}
