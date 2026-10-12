import 'package:flutter/material.dart';
import 'package:flutter_application_1/img5.dart';
import 'package:flutter_application_1/travel.dart'; // Import file travel.dart chứa TravelPage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TravelPage(), // Hiển thị TravelPage làm màn hình chính
    );
  }
}
