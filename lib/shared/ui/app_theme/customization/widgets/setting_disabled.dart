import 'package:flutter/material.dart';

import '../../../native/row/iconed_text.dart';

class SSettingDisabled extends StatelessWidget {
  const SSettingDisabled(
      {super.key, required this.isEnable, required this.title});

  final bool isEnable;

  final String title;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      child: Container(
        height: 60,
        width: 500,
        child: IconedText(
          center: true,
          title: title,
          icons: Icons.error,
          color: Colors.red,
          bold: true,
        ),
      ),
    );
  }
}
