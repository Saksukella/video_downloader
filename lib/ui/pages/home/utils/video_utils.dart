import 'package:share_plus/share_plus.dart';
import 'package:video_downloader/services/models/video_model.dart';
import 'package:video_downloader/ui/pages/home/res/video_keys.dart';
import 'package:video_downloader/ui/pages/home/utils/file_utils.dart';

import '../../../../shared/services/preferences/utils/pref_operations.dart';

void videoUtilsSetLastWatchedVideo(String id) {
  writePrefString(VideoKeys.last_watched, id);
}

String? videoUtilsGetLastWatchedVideo() {
  return readPrefString(VideoKeys.last_watched);
}

void videoUtilsSetEndDuration(String id, Duration duration) {
  writePrefInt(VideoKeys.end_duration + id, duration.inSeconds);
}

Duration? videoUtilsGetEndDuration(String id) {
  int? d = readPrefInt(VideoKeys.end_duration + id);
  if (d == null) {
    return null;
  }
  return Duration(seconds: d);
}

void videoUtilsSLastDurationSecond(String id, Duration duration) {
  writePrefInt(VideoKeys.last_duration + id, duration.inSeconds);
}

Duration? videoUtilsGLastDurationSecond(String id) {
  int? d = readPrefInt(VideoKeys.last_duration + id);
  if (d == null) {
    return null;
  }
  return Duration(seconds: d);
}

Future<void> shareVideo(VideoModel videoModel) async {
  final file = await videoFilefromName(videoModel.id);
  Share.shareFiles([file.path], mimeTypes: ["video/mp4"]);
}
