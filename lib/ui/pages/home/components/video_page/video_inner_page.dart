import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:video_downloader/services/models/video_model.dart';
import 'package:video_downloader/shared/ui/native/dividers/divider1.dart';
import 'package:video_downloader/ui/pages/home/controllers/video_controller.dart';
import 'package:video_downloader/ui/pages/home/dialog/delete_video_dialog.dart';
import 'package:video_downloader/ui/pages/home/utils/video_utils.dart';
import 'package:video_downloader/ui/widgets/videos_empty.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../widgets/helpers/margins.dart';

class VideoInnerPage extends StatefulWidget {
  const VideoInnerPage({super.key});

  @override
  State<VideoInnerPage> createState() => _VideoInnerPageState();
}

class _VideoInnerPageState extends State<VideoInnerPage> {
  List<ChewieController> videoControllers = [];

  Future<void> _initVideos(videos) async {
    videoControllers.clear();
    for (var element in videos) {
      ChewieController videoPlayerController =
          await videoMCont.videoControllerwID(element.id,
              fullScreen: true,
              fullScreenByDefault: false,
              aspectRatio: 3.4 / 2);

      videoControllers.add(videoPlayerController);
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
    return Obx(() {
      return FutureBuilder(
          future: _initVideos(videoMCont.videos),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (videoControllers.isEmpty) {
                return const VideosEmpty();
              }
              return CupertinoScrollbar(
                  child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: _VideoList(videoControllers: videoControllers)));
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
    });
  }
}

class _VideoList extends StatelessWidget {
  const _VideoList({
    required this.videoControllers,
  });

  final List<ChewieController> videoControllers;

  @override
  Widget build(BuildContext context) {
    return GroupedListView<VideoModel, String>(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      elements: videoMCont.videos,
      groupBy: (element) => element.downloadDate.toIso8601String(),
      groupComparator: (value1, value2) => value2.compareTo(value1),
      separator: const Divider1(),
      groupSeparatorBuilder: (String groupByValue) => Chip(
        label: Text(
          groupByValue,
          style: const TextStyle(fontSize: 16),
        ),
      ),
      itemBuilder: (context, element) {
        if (videoControllers.length != videoMCont.videos.length) {
          return SizedBox(
            height: Get.height / 2,
            width: Get.width,
            child: const Center(child: CircularProgressIndicator()),
          );
        }
        ChewieController controller =
            videoControllers[videoMCont.videos.indexOf(element)];

        return VisibilityDetector(
          key: Key(element.id),
          onVisibilityChanged: (visibilityInfo) {
            if (visibilityInfo.visibleFraction == 0) {
              if (!controller.isPlaying) {
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
                            shareVideo(element);
                          },
                          icon: const Icon(Icons.share)),
                      IconButton(
                          onPressed: () {
                            deleteVideoDialog(element);
                          },
                          icon: const Icon(Icons.delete)),
                    ],
                  ),
                ],
              ),
              verticalMargin(10),
              SizedBox(
                height: Get.height / 3,
                child: Chewie(
                  controller: controller,
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
