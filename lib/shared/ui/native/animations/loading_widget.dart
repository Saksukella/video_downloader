import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../app_theme/theme/utils/theme_utils.dart';

class LoadingWidget extends StatelessWidget {
  LoadingWidget(
      {super.key, this.size = 40, this.strokeWidth = 2, this.bg = false});

  double? size;
  final double strokeWidth;
  final bool bg;
  @override
  Widget build(BuildContext context) {
    if (size != null) {
      size = size! * 2.2;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                bg ? theme.primaryColor.withOpacity(0.2) : Colors.transparent,
          ),
          child: Lottie.asset("assets/json/loading.json",
              repeat: true, frameRate: FrameRate.max),
        ),
      ],
    );
  }
}

class PageLoading extends StatelessWidget {
  const PageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingWidget(
        size: 35,
        bg: true,
      ),
    );
  }
}
