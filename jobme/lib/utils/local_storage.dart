import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences sharedPreferences;

  static Future<SharedPreferences> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences;
  }

  static String getString(String key) {
    return sharedPreferences.getString(key) ?? "";
  }

  static Future<bool> setString(String key, String value) async {
    return sharedPreferences.setString(key, value);
  }
}