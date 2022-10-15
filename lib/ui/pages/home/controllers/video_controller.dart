import 'dart:io';

import 'package:get/get.dart';
import 'package:video_downloader/services/ads/app_admob.dart';
import 'package:video_downloader/services/hive/video_hive.dart';
import 'package:video_downloader/services/models/video_model.dart';
import 'package:video_downloader/services/res/user_show_ad_key.dart';
import 'package:video_downloader/shared/services/preferences/utils/pref_operations.dart';
import 'package:video_downloader/ui/pages/home/utils/file_utils.dart';
import 'package:video_downloader/ui/pages/home/widgets/qualty_dialog.dart';
import 'package:video_downloader/ui/surface/snackbars/flushbar.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../../../../shared/ui/packages/loading_widgets_p/loading_dialog.dart';

class VideoMController extends GetxController {
  RxList<VideoModel> videos = <VideoModel>[].obs;

  VideoMController() {
    videos.value = HiveVideo().readAll();
  }

  VideoModel getVideo(String id) {
    return videos.firstWhere((VideoModel element) => element.id == id);
  }

  void setVideo(VideoModel video) {
    //update video model with video given

    int index =
        videos.indexWhere((VideoModel element) => element.url == video.url);
    VideoModel lastVideo = videos[index];
    if (index == -1) {
      videos.add(video);
    }
    if (lastVideo.downloadProgress.toInt() != video.downloadProgress.toInt()) {
      videos[index] = video;
      HiveVideo().write(video.id, video);
      refresh();
    }
  }

  List<VideoModel> get downloadingVideos => videos
      .where((VideoModel video) => video.downloadProgress != 100)
      .toList();

  List<VideoModel> get downloadedVideos => videos
      .where((VideoModel video) => video.downloadProgress == 100)
      .toList();

  void deleteVideo(VideoModel videoModel) {
    videos.removeWhere((VideoModel video) => video.id == videoModel.id);
    HiveVideo().delete(videoModel.id);
    videoFilefromName(videoModel.title).then(
        (value) async => await value.exists() ? value.deleteSync() : null);
    refresh();
  }

  Future<void> download(VideoModel videoModel) async {
    try {
      loadingDialog();
      final yt = YoutubeExplode();

      var video = await yt.videos.get(videoModel.url);
      videoModel = videoModel.copyWith(
        title: video.title,
        id: video.id.value,
      );

      setVideo(videoModel);

      var manifest = await yt.videos.streamsClient.getManifest(videoModel.url);
      var streams = manifest.video;

      Get.back();
      VideoStreamInfo? muxedInfo =
          await showDialogQualitySelect(streams.sortByVideoQuality());

      if (muxedInfo == null) {
        deleteVideo(videoModel);
        return;
      } else {
        if ((readPrefInt(UserShowAdKey.showAd) ?? 0) > 4) {
          AdService().showInterstitialAd();
          writePrefInt(UserShowAdKey.showAd, 0);
        } else {
          writePrefInt(UserShowAdKey.showAd,
              (readPrefInt(UserShowAdKey.showAd) ?? 0) + 1);
        }
      }
      if (downloadingVideos.isNotEmpty) {
        showFlushbarProgress();
      }

      var vid = streams.firstWhere((element) => element == muxedInfo);
      var vidStream = yt.videos.streamsClient.get(vid);

      var file = await videoFilefromName(videoModel.id);

      if (file.existsSync()) {
        file.deleteSync();
      }

      var output = file.openWrite(mode: FileMode.writeOnlyAppend);

      var len = vid.size.totalBytes;
      var count = 0;

      await for (final data in vidStream) {
        count += data.length;
        var progress = ((count / len) * 100);

        if (!file.existsSync()) {
          return;
        }

        setVideo(
            videoModel.copyWith(downloadProgress: progress.toInt().toDouble()));

        output.add(data);
      }

      await output.close();
      yt.close();
    } on Exception catch (e) {
      showFlushbar(
        title: 'Error',
        message: e.toString(),
      );
    }
  }
}
