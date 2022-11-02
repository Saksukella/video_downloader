import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_downloader/services/models/downloading_model.dart';
import 'package:video_downloader/shared/ui/native/dividers/divider1.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../../../../shared/ui/native/surface/dialog/raw_dialog.dart';
import '../../../widgets/helpers/margins.dart';

Future<dynamic?> showDialogQualitySelect(List<VideoStreamInfo> videoInfo,
    DownloadingModel downloadingModel, double audioSize) async {
  var rxQuality = (videoInfo.withHighestBitrate()).obs;

  return await dialogwReturnR(
      rxValue: rxQuality,
      title: "Select Video Quality",
      content: Obx(() {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: SizedBox(
                  width: 80,
                  height: 45,
                  child: CachedNetworkImage(
                    imageUrl: downloadingModel.url ?? "",
                  )),
              title: Text(
                downloadingModel.title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Divider08(),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: Get.height / 2),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    verticalMargin(10.h),
                    ...videoInfo
                        .map((vidInfo) => RadioListTile<dynamic>(
                              title: Text(vidInfo.qualityLabel),
                              subtitle: Text(
                                  "${(vidInfo.size.totalMegaBytes).toStringAsFixed(1)} MB}"),
                              value: vidInfo,
                              groupValue: rxQuality.value,
                              onChanged: (dynamic? value) {
                                rxQuality.value = value!;
                              },
                            ))
                        .toList(),
                  ],
                ),
              ),
            ),
            const Divider1(),
            ListTile(
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.high_quality),
                ],
              ),
              title: Text("Selected : ${rxQuality.value.qualityLabel}"),
              subtitle: Text(
                  "${(rxQuality.value.size.totalMegaBytes + audioSize).toStringAsFixed(1)} MB with Audio"),
            ),
          ],
        );
      }));
}
