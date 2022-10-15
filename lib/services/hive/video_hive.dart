import 'package:hive/hive.dart';

import '../../shared/services/hive/app_hive.dart';
import '../models/video_model.dart';

class HiveVideo implements HiveService {
  static late Box<VideoModel> _box;

  @override
  void close() {
    _box.close();
  }

  @override
  void delete(String key) {
    _box.delete(key);
  }

  @override
  void deleteAll() {
    _box.deleteFromDisk();
  }

  @override
  Future<void> init(String boxName) async {
    Hive.registerAdapter(VideoModelAdapter());
    _box = await Hive.openBox<VideoModel>(boxName);
  }

  @override
  VideoModel? read(String key) {
    return _box.get(key);
  }

  @override
  void write(String key, value) {
    _box.put(key, value);
  }

  @override
  readAll() {
    return _box.values.toList();
  }
}
