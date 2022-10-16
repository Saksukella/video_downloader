import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_downloader/shared/ui/native/dividers/divider1.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../../../../shared/ui/native/surface/dialog/raw_dialog.dart';
import '../../../widgets/helpers/margins.dart';

Future<dynamic?> showDialogQualitySelect(
    List<VideoStreamInfo> videoInfo) async {
  var rxQuality = (videoInfo.withHighestBitrate()).obs;

  return await dialogwReturnR(
      rxValue: rxQuality,
      title: "Select Quality",
      content: Obx(() {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 400),
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
                  "${(rxQuality.value.size.totalMegaBytes).toStringAsFixed(1)} MB"),
            ),
          ],
        );
      }));
}
