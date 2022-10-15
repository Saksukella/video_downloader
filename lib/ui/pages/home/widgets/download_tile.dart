import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:video_downloader/services/models/video_model.dart';
import 'package:video_downloader/shared/ui/app_theme/theme/utils/theme_utils.dart';
import 'package:video_downloader/ui/pages/home/controllers/video_controller.dart';

class DownloadListTile extends StatelessWidget {
  const DownloadListTile({super.key, required this.video});

  final VideoModel video;

  @override
  Widget build(BuildContext context) {
    VideoMController videoMController = Get.find();

    return Obx(() {
      VideoModel videoModel = videoMController.getVideo(video.id);
      log(videoModel.downloadProgress.toString());
      bool isDownloaded() {
        return videoModel.downloadProgress == 100;
      }

      return ListTile(
        minVerticalPadding: 0,
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        leading: CircularPercentIndicator(
            radius: 23.0,
            lineWidth: 3.0,
            animateFromLastPercent: true,
            progressColor: theme.colorScheme.primary,
            percent: (videoModel.downloadProgress / 100),
            center: isDownloaded()
                ? const Icon(Icons.download_done)
                : Text('${videoModel.downloadProgress.toStringAsFixed(0)}%')),
        minLeadingWidth: 0,
        title: Text(
          videoModel.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 15),
        ),
        trailing: isDownloaded()
            ? const SizedBox(
                width: 0,
                height: 0,
              )
            : IconButton(
                onPressed: () {
                  videoMController.deleteVideo(videoModel);
                },
                icon: const Icon(Icons.delete)),
      );
    });
  }
}
