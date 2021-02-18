import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
  static Future<void> setString(String key, String value) async {
    final p = await prefs;
    await p.setString(key, value);
  }

  static Future<String> getString(String key) async {
    final p = await prefs;
    return p.getString(key);
  }

  static Future<void> clearPrefs() async {
    final p = await prefs;
    await p.clear();
  }
}
