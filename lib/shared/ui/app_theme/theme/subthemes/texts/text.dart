import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes.dart';
import '../../utils/theme_utils.dart';

int _size = themeUtilsGetTextSize();
TextTheme _textTheme = Get.find<Themes>().themeData.textTheme;

class LabelText extends StatelessWidget {
  const LabelText({Key? key, required this.data, this.fontSize, this.color})
      : super(key: key);
  final String data;
  final double? fontSize;
  final Color? color;
  TextStyle initLabelText() {
    if (_isSmall()) {
      return _textTheme.labelSmall!.copyWith(
        fontSize: fontSize,
        color: color,
      );
    } else if (_isMedium()) {
      return _textTheme.labelMedium!.copyWith(
        fontSize: fontSize,
        color: color,
      );
    } else {
      return _textTheme.labelLarge!.copyWith(
        fontSize: fontSize,
        color: color,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: initLabelText(),
    );
  }
}

class BodyText extends StatelessWidget {
  const BodyText({Key? key, required this.data, this.fontSize, this.color})
      : super(key: key);
  final String data;
  final double? fontSize;
  final Color? color;
  TextStyle initBodyText() {
    if (_isSmall()) {
      return _textTheme.bodySmall!.copyWith(
        fontSize: fontSize,
        color: color,
      );
    } else if (_isMedium()) {
      return _textTheme.bodyMedium!.copyWith(
        fontSize: fontSize,
        color: color,
      );
    } else {
      return _textTheme.bodyLarge!.copyWith(
        fontSize: fontSize,
        color: color,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: initBodyText(),
    );
  }
}

class TitleText extends StatelessWidget {
  const TitleText({Key? key, required this.data, this.fontSize, this.color})
      : super(key: key);
  final String data;
  final double? fontSize;
  final Color? color;
  TextStyle initTitleText() {
    if (_isSmall()) {
      return _textTheme.titleSmall!.copyWith(
        fontSize: fontSize,
        color: color,
      );
    } else if (_isMedium()) {
      return _textTheme.titleMedium!.copyWith(
        fontSize: fontSize,
        color: color,
      );
    } else {
      return _textTheme.titleLarge!.copyWith(
        fontSize: fontSize,
        color: color,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: initTitleText(),
    );
  }
}

class HeadlineText extends StatelessWidget {
  const HeadlineText({Key? key, required this.data, this.fontSize, this.color})
      : super(key: key);
  final String data;
  final double? fontSize;
  final Color? color;
  TextStyle initHeadlineText() {
    if (_isSmall()) {
      return _textTheme.headlineSmall!.copyWith(
        fontSize: fontSize,
        color: color,
      );
    } else if (_isMedium()) {
      return _textTheme.headlineMedium!.copyWith(
        fontSize: fontSize,
        color: color,
      );
    } else {
      return _textTheme.headlineLarge!.copyWith(
        fontSize: fontSize,
        color: color,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: initHeadlineText(),
    );
  }
}

class DisplayText extends StatelessWidget {
  const DisplayText({Key? key, required this.data, this.fontSize, this.color})
      : super(key: key);
  final String data;
  final double? fontSize;
  final Color? color;
  TextStyle initDisplayText() {
    if (_isSmall()) {
      return _textTheme.displaySmall!.copyWith(
        fontSize: fontSize,
        color: color,
      );
    } else if (_isMedium()) {
      return _textTheme.displayMedium!.copyWith(
        fontSize: fontSize,
        color: color,
      );
    } else {
      return _textTheme.displayLarge!.copyWith(
        fontSize: fontSize,
        color: color,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: initDisplayText(),
    );
  }
}

bool _isSmall() {
  if (_size == 0) {
    return true;
  } else {
    return false;
  }
}

bool _isMedium() {
  if (_size == 1) {
    return true;
  } else {
    return false;
  }
}

bool _isLarge() {
  if (_size == 2) {
    return true;
  } else {
    return false;
  }
}
