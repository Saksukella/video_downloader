import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../app_theme/theme/utils/text_utils.dart';
import '../../../app_theme/theme/utils/theme_utils.dart';

Flushbar? flushbar;

Flushbar _flushbar(String title, String message,
    {IconData? iconData,
    Function? action,
    bool error = false,
    bool dismissible = true,
    String actionText = 'Undo',
    int seconds = 4}) {
  if (dismissible) {
    flushbar != null ? flushbar!.dismiss() : flushbar = null;
  }

  bool isClicked = false;
  IconData icon = error ? Icons.error : iconData ?? Icons.info_outline;
  Color bg = error
      ? Colors.red
      : themes.isDark
          ? Colors.grey.shade800.withOpacity(0.7)
          : Colors.grey.shade200.withOpacity(0.7);
  return Flushbar(
    titleText: Text(
      title,
      style: titleMedium(),
    ),
    messageText: Text(
      message,
      style: bodyMedium(),
    ),
    animationDuration: const Duration(milliseconds: 800),
    mainButton: action != null
        ? TextButton(
            onPressed: () {
              if (!isClicked) {
                isClicked = true;
                action();
                flushbar!.dismiss();
              }
            },
            child: Text(
              actionText,
              style: TextStyle(color: theme.primaryColor),
            ))
        : null,
    backgroundColor: bg,
    isDismissible: dismissible,
    icon: Icon(icon),
    margin: const EdgeInsets.fromLTRB(8, 8, 8, 10),
    padding: const EdgeInsets.symmetric(vertical: 10),
    duration: Duration(seconds: seconds),
    borderRadius: BorderRadius.circular(10),
    barBlur: 20,
    flushbarStyle: FlushbarStyle.FLOATING,
  );
}

showSnackbar(
  String title,
  String message, {
  IconData? iconData,
  bool error = false,
}) {
  ScaffoldMessenger.of(Get.context!).clearSnackBars();

  if (error) {
    title = 'Opss!';
  }

  flushbar = _flushbar(title, message, error: error, iconData: iconData)
    ..show(Get.context!);
}

Flushbar showPermSnackbar(
  String title,
  String message, {
  IconData? iconData,
  bool error = false,
}) {
  if (error) {
    title = 'Opss!';
  }

  flushbar = _flushbar(
    title,
    message,
    error: error,
    iconData: iconData,
    seconds: 1000000,
    dismissible: false,
  )..show(Get.context!);
  return flushbar!;
}

showSnackbarWithAction(
    String title, String message, String actionLabel, Function() action,
    {IconData? iconData, int duration = 4}) {
  flushbar = _flushbar(title, message,
      iconData: iconData, actionText: actionLabel, action: action)
    ..show(Get.context!);
}
