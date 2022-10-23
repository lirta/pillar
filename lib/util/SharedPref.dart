import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  final String IS_LOGIN = "IS_LOGIN";
  final String TOKEN = "token";
  final String ADMIN = "admin";
  final String DEVICE_ID = "deviceid";

  Future<bool> contains(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  Future<String> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getString(key));
  }

  Future<bool> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getBool(key));
  }

  void set(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
