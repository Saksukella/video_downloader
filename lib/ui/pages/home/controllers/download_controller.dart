import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:video_downloader/services/models/downloading_model.dart';

import 'package:video_downloader/services/models/video_model.dart';
import 'package:video_downloader/services/res/user_show_ad_key.dart';
import 'package:video_downloader/shared/services/money/ads/app_admob.dart';
import 'package:video_downloader/shared/services/preferences/utils/pref_operations.dart';
import 'package:video_downloader/ui/pages/home/controllers/video_controller.dart';
import 'package:video_downloader/ui/pages/home/utils/file_utils.dart';
import 'package:video_downloader/ui/pages/home/widgets/qualty_dialog.dart';
import 'package:video_downloader/ui/surface/snackbars/flushbar.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../../../../shared/ui/packages/loading_widgets_p/loading_dialog.dart';

class DownloadCont extends GetxController {
  final RxList<DownloadingModel> _downloading = <DownloadingModel>[].obs;

  List<DownloadingModel> get downloading => _downloading;

  DownloadingModel? modelwID(String id) {
    return _downloading
        .firstWhereOrNull((DownloadingModel element) => element.id == id);
  }

  void addDownloading(DownloadingModel downloadingModel) {
    _downloading.add(downloadingModel);
    refresh();
  }

  void setDownloading(DownloadingModel downloadingModel) {
    int index = _downloading.indexWhere(
        (DownloadingModel element) => element.id == downloadingModel.id);
    if (index == -1) {
      return;
    }
    _downloading[index] = downloadingModel;
    refresh();
  }

  void deleteDownloading(DownloadingModel downloadingModel,
      {bool deleteFile = true}) {
    _downloading.removeWhere(
        (DownloadingModel element) => element.id == downloadingModel.id);
    if (deleteFile) {
      videoFilefromName(downloadingModel.id)
          .then((file) async => await file.exists() ? file.deleteSync() : null);
      audioFileFromName(downloadingModel.id)
          .then((file) async => await file.exists() ? file.deleteSync() : null);
      onlyVideoFilefromName(downloadingModel.id)
          .then((file) async => await file.exists() ? file.deleteSync() : null);
    }

    refresh();
  }

  Future<void> download(DownloadingModel downloadingModel) async {
    try {
      loadingDialog();
      final yt = YoutubeExplode();

      var video = await yt.videos.get(downloadingModel.id);
      downloadingModel = downloadingModel.copyWith(
        title: video.title,
        id: video.id.value,
      );

      setDownloading(downloadingModel);

      StreamManifest manifest =
          await yt.videos.streamsClient.getManifest(downloadingModel.id);
      var videoStreams = manifest.videoOnly;

      Get.back();
      VideoOnlyStreamInfo? videoInfo =
          await showDialogQualitySelect(videoStreams.sortByVideoQuality());
      AudioOnlyStreamInfo audioInfo = manifest.audioOnly.first;

      if (videoInfo == null) {
        deleteDownloading(downloadingModel);
        return;
      } else {
        log(("showInterstitial ---- ${readPrefInt(AppKeys.showAd) ?? 0}")
            .toString());
        if ((readPrefInt(AppKeys.showAd) ?? 0) > 3) {
          await AdService.showInterstitialAd();
          writePrefInt(AppKeys.showAd, 0);
        } else {
          writePrefInt(AppKeys.showAd, (readPrefInt(AppKeys.showAd) ?? 0) + 1);
        }
      }
      if (downloading.isNotEmpty) {
        showFlushbarProgress();
      }

      var vidStream = yt.videos.streamsClient.get(videoInfo);
      var audioStream = yt.videos.streamsClient.get(audioInfo);

      File videoFile = await onlyVideoFilefromName(downloadingModel.id);
      File audioFile = await audioFileFromName(downloadingModel.id);

      if (videoFile.existsSync()) {
        videoFile.deleteSync();
      }
      if (audioFile.existsSync()) {
        audioFile.deleteSync();
      }
      var videoFileStream = videoFile.openWrite();
      var audioFileStream = audioFile.openWrite();
      await audioStream.pipe(audioFileStream);

      var len = videoInfo.size.totalBytes;
      var count = 0;

      await for (final data in vidStream) {
        count += data.length;
        var progress = ((count / len) * 100);
        if (modelwID(downloadingModel.id) == null) {
          break;
        }

        setDownloading(downloadingModel.copyWith(progress: progress.toInt()));
        videoFileStream.add(data);
      }
      await audioFileStream.close();
      await videoFileStream.close();
      yt.close();

      await mergeAudioAndVideo(downloadingModel.id);
      if (modelwID(downloadingModel.id) != null) {
        videoMCont.addVideo(VideoModel(
            id: downloadingModel.id,
            title: downloadingModel.title,
            url: video.thumbnails.mediumResUrl,
            downloadDate: DateTime.now(),
            downloadProgress: 100));
        downloadCont.deleteDownloading(downloadingModel, deleteFile: false);
      }
    } on Exception catch (e) {
      log(e.toString());
      showFlushbar(
        title: 'Error',
        message: e.toString(),
      );
    }
  }
}

DownloadCont get downloadCont => Get.find();
