import 'package:video_downloader/ui/pages/home/res/video_keys.dart';

import '../../../../shared/services/preferences/utils/pref_operations.dart';

Duration videoUtilsLastDurationSecond(String id) {
  int d = readPrefInt(VideoKeys.LAST_DURATION_SECOND + id) ?? 0;
  return Duration(seconds: d);
}

void videoUtilsSetLastDurationSecond(String id, Duration duration) {
  writePrefInt(VideoKeys.LAST_DURATION_SECOND + id, duration.inSeconds);
}
