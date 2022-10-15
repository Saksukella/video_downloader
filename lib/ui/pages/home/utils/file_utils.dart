import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<File> videoFilefromName(String name) async {
  /* var fileName = name
      .replaceAll(r'\', '')
      .replaceAll('/', '')
      .replaceAll('*', '')
      .replaceAll('?', '')
      .replaceAll('"', '')
      .replaceAll('<', '')
      .replaceAll('>', '')
      .replaceAll('|', ''); */
  var tempDir = await getTemporaryDirectory();

  var file = File("${tempDir.path}/$name.mp4");
  return file;
}
