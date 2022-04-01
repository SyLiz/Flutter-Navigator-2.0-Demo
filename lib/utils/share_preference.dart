import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static const keyLogin = 'keyLogin';

  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences?> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static Future<bool> setUserLogin(String key, bool value) async {
    var prefs = await _instance;
    return prefs.setBool(key, value);
  }

  static bool getIsLogged(String key, {required bool defValue}) {
    return _prefsInstance?.getBool(key) ?? defValue;
  }

  static void logout() async {
    await _prefsInstance?.remove(keyLogin);
  }
}
