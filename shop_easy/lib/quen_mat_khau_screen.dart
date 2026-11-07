import 'package:flutter/material.dart';
import 'language_controller.dart';

import 'dang_ky_screen.dart';

class QuenMatKhauScreen extends StatelessWidget {
  const QuenMatKhauScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LanguageController.text('Quên mật khẩu', 'Forgot password'))),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              LanguageController.text('Nhập email của bạn để khôi phục mật khẩu', 'Enter your email to reset your password'),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            TextField(
              decoration: InputDecoration(
                labelText: LanguageController.text('Email của bạn', 'Your email'),
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DangKyScreen(),
                    ),
                  );
                },
                child: Text(
                  LanguageController.text('Gửi yêu cầu', 'Send request'),
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
