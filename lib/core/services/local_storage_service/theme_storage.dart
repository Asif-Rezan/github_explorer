import 'package:get_storage/get_storage.dart';

class ThemeStorage {
  static const String _themeKey = "isDarkMode";
  final GetStorage _box = GetStorage();

  Future<bool> isDarkMode() async {
    return _box.read(_themeKey) ?? false;
  }

  Future<bool> toggleTheme() async {
    final current = _box.read(_themeKey) ?? false;
    final newTheme = !current;
    await _box.write(_themeKey, newTheme);
    return newTheme;
  }

  Future<void> setTheme(bool isDark) async {
    await _box.write(_themeKey, isDark);
  }
}
