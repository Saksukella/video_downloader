// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

part 'video_model.g.dart';

@HiveType(typeId: 0)
class VideoModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String url;
  @HiveField(3)
  DateTime downloadDate;
  @HiveField(4)
  double downloadProgress;
  VideoModel({
    required this.id,
    required this.title,
    required this.url,
    required this.downloadDate,
    required this.downloadProgress,
  });

  VideoModel copyWith({
    String? id,
    String? title,
    String? url,
    DateTime? downloadDate,
    double? downloadProgress,
  }) {
    return VideoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      url: url ?? this.url,
      downloadDate: downloadDate ?? this.downloadDate,
      downloadProgress: downloadProgress ?? this.downloadProgress,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'url': url,
      'downloadDate': downloadDate.millisecondsSinceEpoch,
      'downloadProgress': downloadProgress,
    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      id: map['id'] as String,
      title: map['title'] as String,
      url: map['url'] as String,
      downloadDate:
          DateTime.fromMillisecondsSinceEpoch(map['downloadDate'] as int),
      downloadProgress: map['downloadProgress'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoModel.fromJson(String source) =>
      VideoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VideoModel(id: $id, title: $title, url: $url, downloadDate: $downloadDate, downloadProgress: $downloadProgress)';
  }

  @override
  bool operator ==(covariant VideoModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.url == url &&
        other.downloadDate == downloadDate &&
        other.downloadProgress == downloadProgress;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        url.hashCode ^
        downloadDate.hashCode ^
        downloadProgress.hashCode;
  }
}
