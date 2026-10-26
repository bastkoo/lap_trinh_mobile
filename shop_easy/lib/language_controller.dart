import 'package:flutter/material.dart';

class LanguageController {
  static final ValueNotifier<Locale> locale = ValueNotifier<Locale>(
    const Locale('vi'),
  );

  static void changeLanguage(String languageCode) {
    // The app currently provides Vietnamese and English translations only.
    final normalizedCode = languageCode.toLowerCase();
    locale.value = Locale(normalizedCode == 'en' ? 'en' : 'vi');
  }

  static bool get isVietnamese => locale.value.languageCode == 'vi';

  static String text(String vietnamese, String english) {
    return isVietnamese ? vietnamese : english;
  }
}
