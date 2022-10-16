import 'package:flutter/cupertino.dart';
import 'package:video_downloader/services/models/video_model.dart';
import 'package:video_downloader/ui/pages/home/utils/video_utils.dart';

import '../controllers/video_controller.dart';

class VideoWatchedTime extends StatelessWidget {
  const VideoWatchedTime({super.key, required this.videoID});

  final String videoID;

  @override
  Widget build(BuildContext context) {
    final VideoModel video = videoMCont.getVideo(videoID)!;
    int? minutes = videoUtilsLastDurationSecond(videoID)?.inMinutes;
    return minutes != null
        ? minutes != 0
            ? Text("watched $minutes mins")
            : Container()
        : Container();
  }
}
