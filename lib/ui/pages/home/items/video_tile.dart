import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:video_downloader/services/models/video_model.dart';
import 'package:video_downloader/shared/ui/app_theme/theme/utils/theme_utils.dart';
import 'package:video_downloader/shared/ui/native/size/margins.dart';
import 'package:video_downloader/ui/pages/home/controllers/video_controller.dart';
import 'package:video_downloader/ui/pages/home/dialog/delete_video_dialog.dart';
import 'package:video_downloader/ui/pages/home/utils/video_utils.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../../video_full/video_page.dart';

class VideoTile extends StatelessWidget {
  VideoTile({
    super.key,
    required this.videoModel,
  });

  final VideoModel videoModel;
  final yt = YoutubeExplode();

  String? convertSecondsToMinAndSeconds() {
    int? lastDuration = videoUtilsGLastDurationSecond(videoModel.id)?.inSeconds;
    int? endDuration = videoUtilsGetEndDuration(videoModel.id)?.inSeconds;
    log('lastDuration: $lastDuration');
    if (lastDuration == null || endDuration == null) {
      return null;
    }
    //convert seconds to minutes and seconds in mm : ss format
    String lastDurationString =
        "${(lastDuration / 60).floor()}:${(lastDuration % 60) < 10 ? '0' : ''}${(lastDuration % 60).toStringAsFixed(0)}";
    String endDurationString =
        "${(endDuration / 60).floor()}:${(endDuration % 60) < 10 ? '0' : ''}${(endDuration % 60).toStringAsFixed(0)}";
    return "$lastDurationString / $endDurationString";
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      VideoModel obxModel = videoMCont.getVideo(videoModel.id)!;

      String? duration = convertSecondsToMinAndSeconds();
      return InkWell(
        onTap: () {
          Get.to(() => VideoPage(videoID: videoModel.id));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Card(
            child: BounceInRight(
              from: 20,
              duration: const Duration(milliseconds: 700),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: CachedNetworkImage(
                                imageUrl: videoModel.url,
                                fit: BoxFit.cover,
                                width: duration == null ? 100 : 105,
                                height: duration == null ? 100 : 105,
                              ),
                            )
                            /* FutureBuilder(
                                  future: yt.videos.get(videoModel.id),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.done) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: CachedNetworkImage(
                                          imageUrl: snapshot.data!.thumbnails.mediumResUrl,
                                          fit: BoxFit.cover,
                                          width: 100,
                                          height: 100,
                                        ),
                                      );
                                    }
                                    return const SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: Center(
                                        child: SizedBox(
                                            width: 25,
                                            height: 25,
                                            child: CircularProgressIndicator()),
                                      ),
                                    );
                                  }), */
                          ],
                        ),
                        addHorizontalMargin(15),
                        Expanded(child: Text(videoModel.title, maxLines: 5)),
                        addHorizontalMargin(10),
                        Column(
                          children: [
                            IconButton(
                                onPressed: () {
                                  deleteVideoDialog(videoModel);
                                },
                                icon: const Icon(Icons.delete)),
                            addVerticalMargin(0),
                            IconButton(
                                onPressed: () {
                                  shareVideo(videoModel);
                                },
                                icon: const Icon(Icons.share)),
                            addVerticalMargin(2)
                          ],
                        )
                      ],
                    ),
                    duration != null
                        ? Column(
                            children: [
                              addVerticalMargin(4),
                              LinearPercentIndicator(
                                percent: obxModel.downloadProgress,
                                animation: false,
                                progressColor: theme.primaryColor,
                                barRadius: const Radius.circular(10),
                                trailing: Text(duration),
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
