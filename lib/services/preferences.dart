import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences _preferences;
  // a
  static const _keyTheme = 'dark';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setTheme(String theme) async =>
      await _preferences.setString(_keyTheme, theme);

  static String? getTheme() => _preferences.getString(_keyTheme);
}
