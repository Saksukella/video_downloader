import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_downloader/services/models/video_model.dart';
import 'package:video_downloader/ui/pages/home/controllers/video_controller.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../home/utils/video_utils.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key, required this.videoID});

  final String videoID;

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  ChewieController? _videoController;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
  }

  @override
  void dispose() {
    if (_videoController?.isPlaying ?? false) {
      _videoController!.pause();
    }
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
          future: videoMCont.videoControllerwID(
            widget.videoID,
            autoPlay: true,
            aspectRatio: 16 / 9,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              _videoController = snapshot.data;
              if (_videoController == null) {
                return const Center(
                  child: Text('Error'),
                );
              }
              _listen();

              return VisibilityDetector(
                key: const Key('video_page'),
                onVisibilityChanged: (visibilityInfo) {
                  if (visibilityInfo.visibleFraction == 0) {
                    _videoController!.pause();
                  }
                },
                child: Stack(
                  children: [
                    Chewie(controller: snapshot.data!),
                    const Positioned(
                        left: 7,
                        top: 7,
                        child: BackButton(
                          color: Colors.white,
                        )),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }

  void _listen() {
    _videoController!.videoPlayerController.addListener(() {
      VideoModel? model = videoMCont.getVideo(widget.videoID);
      if (model != null) {
        model.downloadProgress = (_videoController!
                .videoPlayerController.value.position.inMilliseconds /
            _videoController!
                .videoPlayerController.value.duration.inMilliseconds);
        videoMCont.setVideo(model);
      }

      log('video progress: ${_videoController!.videoPlayerController.value.position.toString()} ');

      videoUtilsSLastDurationSecond(widget.videoID,
          _videoController!.videoPlayerController.value.position);
      videoUtilsSetEndDuration(widget.videoID,
          _videoController!.videoPlayerController.value.duration);
    });
  }
}
