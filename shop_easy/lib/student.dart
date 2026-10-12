import 'package:flutter/material.dart';

class MyStudent extends StatelessWidget {
  const MyStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thông tin sinh viên')),
      body: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            ListTile(
              leading: const CircleAvatar(
                radius: 52,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 48,
                  backgroundImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQnMs_Vdlr5a87M0XDsoZHIC6cam_yjB7zuvRuNr21zqQ&s=10',
                  ),
                ),
              ),
              title: const Text('Nguyễn Quốc Đạt'),
              subtitle: const Text('23t1080004@husc.edu.vn'),
              trailing: IconButton(
                icon: const Icon(Icons.phone),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Đang kết nối cuộc gọi...'),
                      duration: Duration(seconds: 5), // Tự động mất sau 5 giây
                    ),
                  );
                },
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Họ và tên',
                prefixIcon: const Icon(Icons.person_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
