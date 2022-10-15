import 'package:flutter/material.dart';

import 'animation/custom_anims.dart';
import 'theme/custom_themes.dart';

class SCustomizations extends StatelessWidget {
  const SCustomizations({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Customization"),
      ),
      body: ListView(
        controller: scrollController,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        children: [
          SCustomThemes(
            scrollController: scrollController,
          ),
          SCustomAnimations(
            scrollController: scrollController,
          ),
          Divider(),
        ],
      ),
    );
  }
}
