import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.network(
                'data:image/jpeg;base64,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',
                width: 300,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                'Nguyễn Văn An · 21T1020123',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                'Lap trinh Flutter - Nhom 1',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text('Nguyễn Quốc Đạt'),
                    SizedBox(width: 20),
                    Icon(Icons.person_outline, size: 20),
                    SizedBox(width: 12),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(Icons.class_outlined, size: 20),
                    SizedBox(width: 20),

                    Text('Lớp KTPMK47B'),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(Icons.email, size: 20),
                    SizedBox(width: 20),

                    Text('Email: 23t1080004@husc.edu.vn'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
