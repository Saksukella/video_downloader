import 'package:flutter/material.dart';

import '../../../services/info/package_info.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 25});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: SAppInfo.iconAsset,
      child: Image.asset(
        SAppInfo.iconAsset,
        height: size,
        width: size,
      ),
    );
  }
}
