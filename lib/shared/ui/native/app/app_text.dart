import 'package:flutter/cupertino.dart';

import '../../../services/info/package_info.dart';
import '../../app_theme/theme/utils/text_utils.dart';

class AppText extends StatelessWidget {
  const AppText({super.key, this.style});

  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: SAppInfo.appName,
      child: Text(
        SAppInfo.appName,
        style: style ?? titleLarge(),
      ),
    );
  }
}
