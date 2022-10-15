import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_theme/theme/utils/text_utils.dart';
import '../../size/margins.dart';

Future<T?> sheetwReturnR<T>({
  String? title,
  Widget? actions,
  double heightp = 0.6,
  Widget? aboveContent,
  required Widget content,
  required var rxValue,
}) async {
  var result = await showModalBottomSheet<T>(
    context: Get.context!,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    isScrollControlled: true,
    constraints: BoxConstraints(
      maxHeight: Get.height * heightp,
    ),
    builder: (context) => Obx(() {
      var value = rxValue.value;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            addVerticalMargin(10),
            Container(
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  title != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            title,
                            style: titleLarge(),
                          ),
                        )
                      : Container(),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.close)),
                  )
                ],
              ),
            ),
            addVerticalMargin(5),
            aboveContent != null ? aboveContent : Container(),
            addVerticalMargin(15),
            Expanded(
                child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(), child: content)),
            addVerticalMargin(10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Get.back(result: value);
                },
                style: TextButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
                child: Text("Confirm"),
              ),
            ),
            addVerticalMargin(10),
          ],
        ),
      );
    }),
  );
  return result;
}
