import 'package:flutter/material.dart';

import '../animations/loading_text.dart';
import '../surface/snackbars/snackbar.dart';

class LoadElevatedButton extends StatefulWidget {
  const LoadElevatedButton(
      {super.key,
      required this.text,
      required this.onPress,
      this.circular = false});

  final String text;
  final Future<String?> Function() onPress;

  final bool circular;

  @override
  State<LoadElevatedButton> createState() => _LoadElevatedButtonState();
}

class _LoadElevatedButtonState extends State<LoadElevatedButton> {
  bool isLaoding = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: widget.circular ? const CircleBorder() : null,
        ),
        onPressed: () async {
          toggleLoading();
          final error = await widget.onPress.call();

          if (error != null) {
            showSnackbar("Error", error, error: true);
          }
          toggleLoading();
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
