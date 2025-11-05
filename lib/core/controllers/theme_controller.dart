import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../services/local_storage_service/theme_storage.dart';

class ThemeController extends GetxController {
  final themeStorage = ThemeStorage();
  var isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadTheme();
  }

  Future<void> loadTheme() async {
    isDarkMode.value = await themeStorage.isDarkMode();
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> toggleTheme() async {
    isDarkMode.value = await themeStorage.toggleTheme();
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}
