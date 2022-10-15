import '../s_prefs.dart';

String? readPrefString(String key) {
  return SAppSharedPreferences.prefs.getString(key);
}

void writePrefString(String key, String value) {
  SAppSharedPreferences.prefs.setString(key, value);
}

bool? readPrefBool(String key) {
  return SAppSharedPreferences.prefs.getBool(key);
}

void writePrefBool(String key, bool value) {
  SAppSharedPreferences.prefs.setBool(key, value);
}

int? readPrefInt(String key) {
  return SAppSharedPreferences.prefs.getInt(key);
}

void writePrefInt(String key, int value) {
  SAppSharedPreferences.prefs.setInt(key, value);
}

double? readPrefDouble(String key) {
  return SAppSharedPreferences.prefs.getDouble(key);
}

void writePrefDouble(String key, double value) {
  SAppSharedPreferences.prefs.setDouble(key, value);
}

List<String>? readPrefStringList(String key) {
  return SAppSharedPreferences.prefs.getStringList(key);
}

void writePrefStringList(String key, List<String> value) {
  SAppSharedPreferences.prefs.setStringList(key, value);
}
