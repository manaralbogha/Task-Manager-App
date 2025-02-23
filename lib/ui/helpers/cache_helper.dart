import 'package:shared_preferences/shared_preferences.dart';

abstract class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await sharedPreferences!.setString(key, value);
    }

    if (value is int) {
      return await sharedPreferences!.setInt(key, value);
    }

    if (value is bool) {
      return await sharedPreferences!.setBool(key, value);
    }

    return await sharedPreferences!.setDouble(key, value);
  }

  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences!.get(
      key,
    );
  }

  static dynamic deleteData({
    required String key,
  }) {
    return sharedPreferences!.remove(
      key,
    );
  }

  static dynamic setStringList({
    required String key,
    required List<String> list,
  }) {
    return sharedPreferences!.setStringList(key, list);
  }

  static dynamic getStringList({
    required String key,
  }) {
    return sharedPreferences!.getStringList(key);
  }
}
