import 'package:shared_preferences/shared_preferences.dart';

// TODO: Dynamic theme
class UserPreferences {
  static SharedPreferences _preferences;

  static const _keyTheme = 'dark';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setTheme(String theme) async =>
      await _preferences.setString(_keyTheme, theme);

  static String getTheme() => _preferences.getString(_keyTheme);
}
