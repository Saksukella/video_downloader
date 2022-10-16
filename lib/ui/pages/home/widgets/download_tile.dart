import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:video_downloader/services/models/downloading_model.dart';
import 'package:video_downloader/shared/ui/app_theme/theme/utils/theme_utils.dart';
import 'package:video_downloader/ui/pages/home/controllers/download_controller.dart';
import 'package:video_downloader/ui/pages/home/controllers/video_controller.dart';

class DownloadingTile extends StatelessWidget {
  const DownloadingTile({super.key, required this.video});

  final DownloadingModel video;

  @override
  Widget build(BuildContext context) {
    VideoMController videoMController = Get.find();

    return Obx(() {
      DownloadingModel downloadingModel = downloadCont.modelwID(video.id)!;

      return ListTile(
        minVerticalPadding: 0,
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        leading: downloadingModel.progress == 0
            ? const CircularProgressIndicator(
                strokeWidth: 3,
              )
            : CircularPercentIndicator(
                radius: 23.0,
                lineWidth: 3.0,
                animateFromLastPercent: true,
                progressColor: theme.colorScheme.primary,
                percent: (downloadingModel.progress / 100),
                center: Text('${downloadingModel.progress}%')),
        minLeadingWidth: 0,
        title: Text(
          downloadingModel.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 15),
        ),
        subtitle: downloadingModel.progress == 0
            ? const Text("Dowloading Audio")
            : null,
        trailing: IconButton(
            onPressed: () {
              downloadCont.deleteDownloading(downloadingModel);
            },
            icon: const Icon(Icons.delete)),
      );
    });
  }
}
