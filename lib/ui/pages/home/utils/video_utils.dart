import 'package:share_plus/share_plus.dart';
import 'package:video_downloader/services/models/video_model.dart';
import 'package:video_downloader/ui/pages/home/res/video_keys.dart';
import 'package:video_downloader/ui/pages/home/utils/file_utils.dart';

import '../../../../shared/services/preferences/utils/pref_operations.dart';

Duration? videoUtilsLastDurationSecond(String id) {
  int? d = readPrefInt(VideoKeys.LAST_DURATION_SECOND + id);
  if (d == null) {
    return null;
  }
  return Duration(seconds: d);
}

void videoUtilsSetLastDurationSecond(String id, Duration duration) {
  writePrefInt(VideoKeys.LAST_DURATION_SECOND + id, duration.inSeconds);
}

void videoUtilsSetLastWatchedVideo(String id) {
  writePrefString(VideoKeys.LAST_WATCHED_VIDEO, id);
}

String? videoUtilsGetLastWatchedVideo() {
  return readPrefString(VideoKeys.LAST_WATCHED_VIDEO);
}

Duration? videoUtilsEndDuration(String id) {
  int? d = readPrefInt(VideoKeys.LAST_DURATION_SECOND + id);
  if (d == null) {
    return null;
  }
  return Duration(seconds: d);
}

Future<void> shareVideo(VideoModel videoModel) async {
  final file = await videoFilefromName(videoModel.id);
  Share.shareFiles([file.path], mimeTypes: ["video/mp4"]);
}
