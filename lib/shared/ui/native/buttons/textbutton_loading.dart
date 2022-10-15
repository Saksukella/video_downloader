import 'package:flutter/material.dart';

import '../animations/loading_text.dart';
import '../surface/snackbars/snackbar.dart';

class LoadTextButton extends StatefulWidget {
  const LoadTextButton({super.key, required this.text, required this.onPress});

  final String text;
  final String? Function() onPress;
  @override
  State<LoadTextButton> createState() => _LoadTextButtonState();
}

class _LoadTextButtonState extends State<LoadTextButton> {
  bool isLaoding = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          toggleLoading();
          final error = widget.onPress.call();

          if (error != null) {
            showSnackbar("Error", error, error: true);
          }
        },
        child: LoadingText(
          isLoading: isLaoding,
          text: widget.text,
        ));
  }

  void toggleLoading() {
    setState(() {
      isLaoding = !isLaoding;
    });
  }
}
