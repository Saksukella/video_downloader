import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'cancel_confirm.dart';

Future<T?> dialogwReturnR<T>({
  String? title,
  Widget? actions,
  bool showActions = true,
  required Widget content,
  required var rxValue,
}) async {
  var result = await showDialog<T>(
    context: Get.context!,
    builder: (context) => Obx(() {
      var value = rxValue.value;
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: title != null
            ? Center(
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            : null,
        content: content,
        actions: [
          Visibility(
            visible: showActions,
            child: actions ??
                CancelConfirmButtons(
                  onSubmit: () {
                    Get.back(result: value);
                    return null;
                  },
                ),
          ),
        ],
        actionsPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        titlePadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      );
    }),
  );
  return result;
}

Future<T?> dialogwButtons<T>({
  String? title,
  Widget? actions,
  bool showActions = true,
  required Widget content,
}) async {
  var result = await showDialog<T>(
      context: Get.context!,
      builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: title != null
                ? Center(
                    child: Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                : null,
            content:
                Column(mainAxisSize: MainAxisSize.min, children: [content]),
            actions: [
              Visibility(
                visible: showActions,
                child: actions ??
                    CancelConfirmButtons(onSubmit: () {
                      Get.back(result: true);
                      return null;
                    }),
              ),
            ],
            actionsPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            titlePadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          ));
  return result;
}
// dialog with no buttons

Future<T?> rawDialog<T>({
  String? title,
  Widget? actions,
  required Widget content,
}) async {
  var result = await showDialog<T>(
      context: Get.context!,
      builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: title != null
                ? Center(
                    child: Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                : null,
            content: content,
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            titlePadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          ));
  return result;
}
