import 'package:flutter/material.dart';
import 'package:video_downloader/services/models/video_model.dart';
import 'package:video_downloader/shared/ui/native/surface/dialog/raw_dialog.dart';
import 'package:video_downloader/ui/pages/home/controllers/video_controller.dart';

void deleteVideoDialog(VideoModel video) {
  dialogwButtons(
          title: "Delete Video",
          content: Text("${video.title} will be deleted!"))
      .then((value) {
    if (value == null) return;

    videoMCont.deleteVideo(video);
  });
}
