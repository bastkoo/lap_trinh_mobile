import 'package:flutter/material.dart';

class HoSo extends StatelessWidget {
  const HoSo({super.key});
  //Wiget cần dùng: Stack, Positioned, CircleAvatar, Card, Row, Expanded, Drivider
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [block1(), block2(), const SizedBox(height: 30), block3()],
      ),
    );
  }

  Widget block1() {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQnAN7ZiCfLDDw0A-dpm3TsHc69Puk6mevZQ-wfYkEBzysb_73Hke9Bz6w&s=10',
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: -50,
              left: 0,
              right: 0,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 48,
                  backgroundImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQnMs_Vdlr5a87M0XDsoZHIC6cam_yjB7zuvRuNr21zqQ&s=10',
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 60),
        Text(
          'Nguyễn Quốc Đạt',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          'Số điện thoại: 0123456789',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        SizedBox(height: 20),
        Divider(color: Colors.grey, thickness: 1, indent: 20, endIndent: 20),
        SizedBox(height: 20),
      ],
    );
  }

  Widget block2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text(
              '8',
              style: TextStyle(color: const Color.fromARGB(255, 216, 29, 41)),
            ),
            Text('Bài viết', style: TextStyle(color: Colors.blue)),
          ],
        ),
        Column(
          children: [
            Text(
              '4',
              style: TextStyle(color: const Color.fromARGB(255, 216, 29, 41)),
            ),
            Text('Người theo dõi', style: TextStyle(color: Colors.blue)),
          ],
        ),
        Column(
          children: [
            Text(
              '2',
              style: TextStyle(color: const Color.fromARGB(255, 216, 29, 41)),
            ),
            Text('Đang theo dõi', style: TextStyle(color: Colors.blue)),
          ],
        ),
      ],
    );
  }

  Widget block3() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Canh giữa 2 nút
      children: [
        // Nút 1: Nền xanh, chữ trắng (Theo dõi)
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // Màu nền xanh
            foregroundColor: Colors.white, // Màu chữ trắng
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Bo góc (tùy chọn)
            ),
          ),
          child: const Text('Theo dõi'),
        ),
        const SizedBox(width: 15), // Khoảng cách giữa 2 nút

        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white, // Màu nền trắng
            foregroundColor: Colors.black, // Màu chữ đen
            side: const BorderSide(color: Colors.blue, width: 1.5), // Viền xanh
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('Nhắn tin'),
        ),
      ],
    );
  }
}
