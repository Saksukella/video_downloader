import 'package:flutter/material.dart';

postframe(Function() callback) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    callback.call();
  });
}
