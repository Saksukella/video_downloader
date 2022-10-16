// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DownloadingModel {
  String id;
  String title;
  int progress;
  DownloadingModel({
    required this.id,
    required this.title,
    required this.progress,
  });

  DownloadingModel copyWith({
    String? id,
    String? title,
    int? progress,
  }) {
    return DownloadingModel(
      id: id ?? this.id,
      title: title ?? this.title,
      progress: progress ?? this.progress,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'progress': progress,
    };
  }

  factory DownloadingModel.fromMap(Map<String, dynamic> map) {
    return DownloadingModel(
      id: map['id'] as String,
      title: map['title'] as String,
      progress: map['progress'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory DownloadingModel.fromJson(String source) =>
      DownloadingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'DownloadingModel(id: $id, title: $title, progress: $progress)';

  @override
  bool operator ==(covariant DownloadingModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.title == title && other.progress == progress;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ progress.hashCode;
}
