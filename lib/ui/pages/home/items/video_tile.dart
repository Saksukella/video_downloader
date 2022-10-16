import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_downloader/services/models/video_model.dart';
import 'package:video_downloader/shared/ui/native/size/margins.dart';
import 'package:video_downloader/ui/pages/home/dialog/delete_video_dialog.dart';
import 'package:video_downloader/ui/pages/home/utils/video_utils.dart';
import 'package:video_downloader/ui/pages/home/widgets/watched_time.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../../video_full/video_page.dart';

class VideoTile extends StatelessWidget {
  VideoTile({
    super.key,
    required this.videoModel,
  });

  final VideoModel videoModel;
  final yt = YoutubeExplode();

  @override
  Widget build(BuildContext context) {
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
              child: Row(
                children: [
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CachedNetworkImage(
                          imageUrl: videoModel.url,
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
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
                      ,
                      addVerticalMargin(3),
                      VideoWatchedTime(videoID: videoModel.id),
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
                      addVerticalMargin(8),
                      IconButton(
                          onPressed: () {
                            shareVideo(videoModel);
                          },
                          icon: const Icon(Icons.share)),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
