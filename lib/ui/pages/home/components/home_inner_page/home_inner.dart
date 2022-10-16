import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:video_downloader/services/models/video_model.dart';
import 'package:video_downloader/shared/ui/native/columns/titled_widget.dart';
import 'package:video_downloader/ui/pages/home/items/video_tile.dart';
import 'package:video_downloader/ui/pages/home/controllers/video_controller.dart';
import 'package:video_downloader/ui/pages/home/utils/video_utils.dart';
import 'package:video_downloader/ui/widgets/videos_empty.dart';

class HomeInner extends StatelessWidget {
  const HomeInner({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        child: videoMCont.videos.isNotEmpty
            ? CupertinoScrollbar(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    lastWatch() != null
                        ? TitledWidget(
                            title: "You were Watching",
                            child: VideoTile(videoModel: lastWatch()!),
                          )
                        : Container(),
                    TitledWidget(
                      title: "Recent",
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: videoMCont.recentVideos.length,
                        itemBuilder: (context, index) {
                          return VideoTile(
                              videoModel: videoMCont.recentVideos[index]);
                        },
                      ),
                    ),
                  ],
                ),
              )
            : const VideosEmpty(),
      );
    });
  }

  VideoModel? lastWatch() {
    String? id = videoUtilsGetLastWatchedVideo();
    if (id == null) {
      return null;
    }

    return videoMCont.getVideo(id);
  }
}
