import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:video_downloader/shared/ui/app_theme/theme/utils/theme_utils.dart';
import 'package:video_downloader/ui/pages/home/controllers/download_controller.dart';
import 'package:video_downloader/ui/pages/home/controllers/video_controller.dart';
import 'package:video_downloader/ui/pages/home/utils/date_utils.dart';
import 'package:video_downloader/ui/pages/home/widgets/completed_tile.dart';
import 'package:video_downloader/ui/pages/home/widgets/download_tile.dart';

Flushbar? flushbar;

Flushbar _initMessageFlushbar(
    {String? message,
    String? title,
    Color? color,
    IconData? icon,
    String? buttonText}) {
  return Flushbar(
    title: title,
    message: message,
    /* messageText: message != null
        ? Text(
            message,
            maxLines: 20,
            style: const TextStyle(
              color: Colors.white,
            ),
          )
        : null, */
    duration: const Duration(seconds: 4),
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.FLOATING,
    backgroundColor: color ?? theme.cardColor,
    margin: const EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(5),
    icon: Icon(
      icon,
      size: 25.0,
    ),
    mainButton: buttonText != null
        ? TextButton(
            onPressed: () {
              flushbar?.dismiss(true);
            },
            child: Text(
              buttonText,
              style: const TextStyle(color: Colors.white),
            ),
          )
        : null,
  );
}

void showFlushbar(
    {String? message,
    String? title,
    String? buttonText,
    Color? color,
    IconData? icon}) {
  if (flushbar != null) {
    if (flushbar!.isDismissible) {
      flushbar!.dismiss();
    }
  }
  flushbar = _initMessageFlushbar(
    title: title,
    message: message,
    color: color,
    icon: icon,
    buttonText: buttonText,
  );
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    flushbar!.show(Get.context!);
  });
}

void showFlushbarProgress() {
  if (flushbar != null) {
    if (flushbar!.isDismissible) {
      flushbar!.dismiss();
    }
  }
  Color color = themes.isDark ? Colors.grey.shade900 : Colors.grey.shade200;
  flushbar = Flushbar(
    titleText: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: const [
            Icon(Icons.download_for_offline_outlined),
            SizedBox(
              width: 6,
            ),
            Text(
              "Downloads",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        IconButton(
            onPressed: () {
              flushbar?.dismiss(true);
            },
            icon: const Icon(Icons.close))
      ],
    ),
    titleSize: 18,
    animationDuration: const Duration(milliseconds: 400),
    margin: const EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(10),
    backgroundColor: color,
    messageText: Obx(() {
      return Material(
        elevation: 0,
        color: color,
        child: Column(
          children: <Widget>[
            ExpansionPanelList.radio(
              elevation: 0,
              expandedHeaderPadding: const EdgeInsets.symmetric(vertical: 0),
              initialOpenPanelValue: 0,
              children: [
                ExpansionPanelRadio(
                  backgroundColor: color,
                  value: 0,
                  canTapOnHeader: true,
                  headerBuilder: (context, isExpanded) => const ListTile(
                    leading: Icon(
                      Icons.downloading,
                      color: Colors.yellow,
                    ),
                    title: Text("Downloading"),
                  ),
                  body: downloadCont.downloading.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Downloads are empty",
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        )
                      : ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 350),
                          child: ListView.separated(
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(bottom: 10),
                            physics: const BouncingScrollPhysics(),
                            itemCount: downloadCont.downloading.length,
                            separatorBuilder: (context, index) {
                              return const Divider(
                                height: 1,
                                color: Colors.grey,
                              );
                            },
                            itemBuilder: (context, index) {
                              return DownloadingTile(
                                video: downloadCont.downloading[index],
                              );
                            },
                          ),
                        ),
                ),
                ExpansionPanelRadio(
                  value: 1,
                  canTapOnHeader: true,
                  backgroundColor: color,
                  headerBuilder: (context, isExpanded) {
                    return const ListTile(
                      leading: Icon(
                        Icons.download_done,
                        color: Colors.green,
                      ),
                      title: Text("Completed"),
                    );
                  },
                  body: videoMCont.videos.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Completed are empty",
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        )
                      : ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 250),
                          child: GroupedListView(
                            elements: videoMCont.videos,
                            groupBy: (element) => mdy(element.downloadDate),
                            groupHeaderBuilder: (element) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    mdy(element.downloadDate),
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  const Divider()
                                ],
                              ),
                            ),
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(bottom: 10),
                            physics: const BouncingScrollPhysics(),
                            separator: const Divider(
                              height: 1,
                              color: Colors.grey,
                            ),
                            itemBuilder: (context, v) {
                              return CompleteTile(
                                video: v,
                              );
                            },
                          ),
                        ),
                )
              ],
            )
          ],
        ),
      );
    }),
    showProgressIndicator: false,
  );
  flushbar!.show(Get.context!);
}
