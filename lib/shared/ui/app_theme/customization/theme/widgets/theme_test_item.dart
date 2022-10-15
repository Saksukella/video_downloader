import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/theme_controller.dart';
import 'themed_listTile.dart';

class SThemedTestItem extends StatelessWidget {
  const SThemedTestItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SCustomThemeController _customThemeController = Get.find();
    return Container(
      padding: EdgeInsets.all(12),
      color: _customThemeController.getBackgroundColor(),
      child: Center(
          child: Card(
        color: _customThemeController.getCardColor(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Test Item",
                    style: TextStyle(
                        fontSize: 18,
                        color: _customThemeController.getTextColor(),
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.edit,
                          color: _customThemeController.getIconColor(),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.delete,
                          color: _customThemeController.getIconColor(),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  SThemedListTile(),
                  SThemedListTile(),
                  SThemedListTile(),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
