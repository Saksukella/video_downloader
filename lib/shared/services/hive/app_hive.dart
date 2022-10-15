abstract class HiveService {
  Future<void> init(
    String boxName,
  ) async {}

  void write(String key, dynamic value) {}

  readAll() {}

  read(String key) {}

  void delete(String key) {}

  void deleteAll() {}

  void close() {}
}
