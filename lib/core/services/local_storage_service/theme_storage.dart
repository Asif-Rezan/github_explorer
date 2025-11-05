import 'package:shared_preferences/shared_preferences.dart';

class ThemeStorage {
  static const _key = "isDarkTheme";

  Future<void> saveTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, isDark);
  }

  Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? false;
  }

  Future<bool> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getBool(_key) ?? false;
    final newTheme = !current;
    await prefs.setBool(_key, newTheme);
    return newTheme;
  }

  Future<void> clearTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
