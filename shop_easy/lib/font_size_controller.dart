import 'package:flutter/material.dart';

/// Cỡ chữ dùng chung cho toàn bộ ứng dụng.
class FontSizeController {
  static final ValueNotifier<double> fontSize = ValueNotifier<double>(16);

  static double get value => fontSize.value;

  static void setFontSize(double size) {
    fontSize.value = size.clamp(
      12.0,
      24.0,
    ); //.clamp(12.0, 24.0) để giới hạn cỡ chữ từ 12 đến 24
  }
}
