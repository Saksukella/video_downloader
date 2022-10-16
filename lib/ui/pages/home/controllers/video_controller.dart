import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:video_downloader/services/hive/video_hive.dart';
import 'package:video_downloader/services/models/video_model.dart';
import 'package:video_downloader/ui/pages/home/utils/file_utils.dart';
import 'package:video_player/video_player.dart';

import '../utils/video_utils.dart';

class VideoMController extends GetxController {
  final RxList<VideoModel> _videos = <VideoModel>[].obs;

  VideoMController() {
    _videos.value = HiveVideo().readAll();
  }
  List<VideoModel> get videos => _videos;

  //order list recent
  List<VideoModel> get recentVideos {
    List<VideoModel> list = List.from(_videos);
    list.sort((a, b) => b.downloadDate.compareTo(a.downloadDate));
    return list;
  }

  VideoModel? getVideo(String id) {
    return _videos.firstWhereOrNull((VideoModel element) => element.id == id);
  }

  void addVideo(VideoModel video) {
    _videos.add(video);
    HiveVideo().write(video.id, video);
    refresh();
  }

  void setVideo(VideoModel video) {
    int index =
        _videos.indexWhere((VideoModel element) => element.url == video.url);
    VideoModel lastVideo = _videos[index];
    if (index == -1) {
      return;
    }
    if (lastVideo.downloadProgress.toInt() != video.downloadProgress.toInt()) {
      _videos[index] = video;
      HiveVideo().write(video.id, video);
      //_videos.refresh();
    }
  }

  void deleteVideo(VideoModel videoModel) {
    _videos.removeWhere((VideoModel video) => video.id == videoModel.id);
    HiveVideo().delete(videoModel.id);
    videoFilefromName(videoModel.id).then(
        (value) async => await value.exists() ? value.deleteSync() : null);
    refresh();
  }

  Future<ChewieController> videoControllerwID(String id,
      {fullScreen = false,
      fullScreenByDefault = false,
      autoPlay = false,
      aspectRatio}) async {
    var v = VideoPlayerController.file(
      await videoFilefromName(id),
    );
    //await v.initialize();

    final c = ChewieController(
        videoPlayerController: v,
        aspectRatio: aspectRatio,
        fullScreenByDefault: fullScreenByDefault,
        allowFullScreen: fullScreen,
        autoPlay: autoPlay,
        startAt: videoUtilsLastDurationSecond(id));

    videoUtilsSetLastWatchedVideo(id);
    return c;
  }
  /* Future<void> download(VideoModel videoModel) async {
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
  } */
}

VideoMController get videoMCont => Get.find<VideoMController>();
