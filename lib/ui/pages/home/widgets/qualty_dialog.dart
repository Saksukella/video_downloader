import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_downloader/shared/ui/native/dividers/divider1.dart';

import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../../../../shared/ui/native/surface/dialog/raw_dialog.dart';
import '../../../widgets/helpers/margins.dart';

Future<VideoStreamInfo?> showDialogQualitySelect(
    List<VideoStreamInfo> videoInfo) async {
  var rxQuality = videoInfo.bestQuality.obs;

  return await dialogwReturnR(
      rxValue: rxQuality,
      title: "Select Quality",
      content: Obx(() {
        return SizedBox(
          height: 350,
          width: 250,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    verticalMargin(10.h),
                    ...videoInfo
                        .map((vidInfo) => RadioListTile<VideoStreamInfo>(
                              title: Text(vidInfo.qualityLabel),
                              subtitle: Text(
                                  "${(vidInfo.size.totalMegaBytes).toStringAsFixed(1)} MB}"),
                              value: vidInfo,
                              groupValue: rxQuality.value,
                              onChanged: (VideoStreamInfo? value) {
                                rxQuality.value = value!;
                              },
                            ))
                        .toList()
                        .reversed,
                  ],
                ),
              ),
              const Divider1(),
              ListTile(
                leading: const Icon(Icons.spellcheck_outlined),
                title: Text("Selected : ${rxQuality.value.qualityLabel}"),
                subtitle: Text(
                    "${(rxQuality.value.size.totalMegaBytes).toStringAsFixed(1)} MB"),
              )
            ],
          ),
        );
      }));
}
