import 'package:flutter/material.dart';

/// Trạng thái giao diện dùng chung cho toàn bộ ứng dụng.
class ThemeController {
  static final ValueNotifier<ThemeMode> themeMode =
      ValueNotifier<ThemeMode>(ThemeMode.light);

  static bool get isDarkMode => themeMode.value == ThemeMode.dark;

  static void setDarkMode(bool enabled) {
    themeMode.value = enabled ? ThemeMode.dark : ThemeMode.light;
  }

  static void toggle() => setDarkMode(!isDarkMode);
}
