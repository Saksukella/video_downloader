import 'package:flutter/cupertino.dart';

class GeneralModel {
  final String text;
  final dynamic value;
  final IconData? icon;

  final String? routeName;
  final Function()? onTap;

  GeneralModel(
      {required this.text, this.icon, this.routeName, this.onTap, this.value});
}
