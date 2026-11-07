import 'package:flutter/material.dart';
import 'language_controller.dart';

import 'quen_mat_khau_screen.dart';
import 'dang_ky_screen.dart';
import 'products.dart';

class DangNhapScreen extends StatelessWidget {
  const DangNhapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LanguageController.text('Đăng nhập', 'Log in'))),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock_person, size: 80, color: Colors.blue),
                const SizedBox(height: 16),
                Text(
                  LanguageController.text('Xin chào!', 'Hello!'),
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),

                // Ô nhập Tên đăng nhập
                TextField(
                  decoration: InputDecoration(
                    labelText: LanguageController.text('Tên đăng nhập hoặc Email', 'Username or email'),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 16),

                // Ô nhập Mật khẩu
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: LanguageController.text('Mật khẩu', 'Password'),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: Icon(Icons.visibility_off),
                  ),
                ),
                const SizedBox(height: 8),

                // Nút Quên mật khẩu
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QuenMatKhauScreen(),
                        ),
                      );
                    },
                    child: Text(LanguageController.text('Quên mật khẩu?', 'Forgot password?')),
                  ),
                ),
                const SizedBox(height: 16),

                // Nút Đăng nhập
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProductList(),
                        ),
                      );
                    },
                    child: Text(
                      LanguageController.text('Đăng nhập', 'Log in'),
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Chuyển sang trang Đăng ký
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(LanguageController.text('Chưa có tài khoản?', "Don't have an account?")),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DangKyScreen(),
                          ),
                        );
                      },
                      child: Text(LanguageController.text('Đăng ký ngay', 'Register now')),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
