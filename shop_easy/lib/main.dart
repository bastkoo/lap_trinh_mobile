import 'package:flutter/material.dart';

import 'student.dart'; // Import tương đối ngắn gọn và chính xác

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyStudent(), // Hiển thị MyCounter làm màn hình chính
    );
  }
}
