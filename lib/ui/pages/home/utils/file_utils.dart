import 'dart:developer';
import 'dart:io';

import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:path_provider/path_provider.dart';

Future<File> videoFilefromName(String id) async {
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

  var file = File("${tempDir.path}/$id.mp4");
  return file;
}

Future<File> onlyVideoFilefromName(String id) async {
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

  var file = File("${tempDir.path}/${id}video.mp4");
  return file;
}

Future<File> audioFileFromName(String id) async {
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

  var file = File("${tempDir.path}/${id}audio.mp4");
  return file;
}

Future<File> mergeAudioAndVideo(String id) async {
  var videoFile = await onlyVideoFilefromName(id);
  var audioFile = await audioFileFromName(id);
  var mergedFile = await videoFilefromName(id);

  log("videoFile: ${videoFile.path}  -- ${videoFile.existsSync()}");
  log("audioFile: ${audioFile.path}  -- ${audioFile.existsSync()}");

  if (mergedFile.existsSync()) {
    mergedFile.deleteSync();
  }
  //merge audio and video use FFmpeg
  await FFmpegKit.execute(
      "-i ${videoFile.path} -i ${audioFile.path} -c copy ${mergedFile.path}");

  videoFile.deleteSync();
  audioFile.deleteSync();

  return mergedFile;
}
