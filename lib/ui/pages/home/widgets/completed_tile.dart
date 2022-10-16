import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:video_downloader/services/models/video_model.dart';

import 'package:video_downloader/ui/pages/home/controllers/video_controller.dart';

class CompleteTile extends StatelessWidget {
  const CompleteTile({super.key, required this.video});

  final VideoModel video;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      VideoModel videoModel = videoMCont.getVideo(video.id)!;

      return ListTile(
        minVerticalPadding: 0,
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        leading: const CircleAvatar(child: Icon(Icons.check)),
        minLeadingWidth: 0,
        title: Text(
          videoModel.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 15),
        ),
      );
    });
  }
}
