import 'dart:core';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../res/utils/asset/asset_utils.dart';

class SLottieComplete extends StatefulWidget {
  const SLottieComplete({
    Key? key,
    required this.size,
  }) : super(key: key);

  final double size;

  @override
  State<SLottieComplete> createState() => _SLottieCompleteState();
}

class _SLottieCompleteState extends State<SLottieComplete>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: Lottie.asset(assetJson("confeti"), frameRate: FrameRate.max),
          ),
          Lottie.asset(assetJson("finished"),
              repeat: false,
              controller: _animationController,
              frameRate: FrameRate.max),
        ],
      ),
    );
  }
}
