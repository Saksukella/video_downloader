import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:video_downloader/shared/res/utils/asset/asset_utils.dart';
import 'package:video_downloader/shared/ui/app_theme/theme/utils/text_utils.dart';
import 'package:video_downloader/shared/ui/native/columns/column2.dart';
import 'package:video_downloader/shared/ui/native/size/margins.dart';

class VideosEmpty extends StatelessWidget {
  const VideosEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: ColumnTB(
          t: SizedBox(
              width: 150, height: 150, child: Lottie.asset(assetJson("empty"))),
          b: Column(
            children: [
              Text(
                "No Videos!",
                style: headLineMedium(),
              ),
              addVerticalMargin(10),
              Text(
                "Download videos to see them here",
                style: headLineMedium(),
                textAlign: TextAlign.center,
              ),
            ],
          )),
    );
  }
}
