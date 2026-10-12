import 'package:flutter/material.dart';

class TravelPage extends StatelessWidget {
  const TravelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Bên trái: Logo + Chữ Xin chào
        title: Row(
          children: [
            Image.network(
              "https://thumb.wikimedia.org/wikipedia/vi/thumb/2/2a/Logo_th%C3%A0nh_ph%E1%BB%91_Hu%E1%BA%BF.svg/500px-Logo_th%C3%A0nh_ph%E1%BB%91_Hu%E1%BA%BF.svg.png?utm_source=vi.wikipedia.org&utm_campaign=index&utm_content=thumbnail",
              width: 35,
              height: 35,
            ),
            const SizedBox(width: 8), // Khoảng cách giữa Logo và chữ
            const Text('Xin chào,', style: TextStyle(fontSize: 18)),
          ],
        ),
        // Bên phải: Chỉ chứa các Icon nút bấm
        actions: [
          IconButton(
            icon: const Icon(Icons.call, color: Colors.blue),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.near_me, color: Colors.blue),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share, color: Colors.blue),
            onPressed: () {},
          ),
        ],
      ),
      // Bọc SingleChildScrollView để vuốt xuống không bị lỗi Overflow

      body: Column(children: [block1(), block2(), block3(), block4()]),
    );
  }

  String getImgURL() {
    return 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQnAN7ZiCfLDDw0A-dpm3TsHc69Puk6mevZQ-wfYkEBzysb_73Hke9Bz6w&s=10';
  }

  Widget block1() {
    return Image.network(
      getImgURL(),
      width: double.infinity, // Tràn hết chiều ngang
      height: 200, // Giới hạn chiều cao (thay 200 bằng số pixel bạn muốn)
      fit: BoxFit.cover, // Phủ kín khung 200px mà không làm móm/méo hình
    );
  }

  Widget block2() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Đẩy 2 phần về 2 phía
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Căn lề trái cho chữ
              children: [
                Text(
                  'TP Huế xinh đẹp - Nguyễn Quốc Đạt',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  'Địa chỉ: TP Huế, Việt Nam',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const Row(
            children: [
              Icon(Icons.star, color: Colors.red),
              Text('4.5'),
            ],
          ),
        ], // Đóng children của Row ngoài cùng
      ),
    ); // Thêm ngoặc đóng ) cho Row ở đây
  }

  Widget iconText(IconData icon, String text, {required TextStyle style}) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue),
        Text(text, style: const TextStyle(color: Colors.blue)),
      ],
    );
  }

  Widget block3() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceEvenly, // Căn đều các phần tử trong Row
        children: [
          iconText(Icons.call, 'Gọi', style: const TextStyle(fontSize: 12)),
          iconText(
            Icons.near_me,
            'Chỉ đường',
            style: const TextStyle(fontSize: 12),
          ),
          iconText(
            Icons.share,
            'Chia sẻ',
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget block4() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Text("""Huế là một trong chín thành phố trực thuộc trung ương và là thành phố di sản của Việt Nam. Thành phố là một trong các trung tâm văn hóa, y tế và giáo dục lớn của Việt Nam. Đây là thành phố ven biển cực nam thuộc vùng Bắc Trung Bộ, miền Trung Việt Nam. Huế hiện là đô thị loại I, là thành phố trung tâm cấp vùng và cấp quốc gia.

"""),
    );
  }
}
