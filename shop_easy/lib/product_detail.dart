import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Yêu cầu 3: Ảnh co lại thành thanh tiêu đề khi cuộn xuống (SliverAppBar)
          SliverAppBar(
            expandedHeight: 300.0,
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.black.withOpacity(0.3),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 18,
                  ),
                  onPressed: () =>
                      Navigator.pop(context), // Yêu cầu 2: Nút quay lại
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.3),
                  child: IconButton(
                    icon: const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 18,
                    ),
                    onPressed: () {}, // Yêu cầu 2: Nút yêu thích nổi trên ảnh
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  // Yêu cầu 1: Ảnh sản phẩm vuốt ngang được (PageView) có chấm chỉ vị trí
                  PageView(
                    children: [
                      Container(
                        color: Colors.grey[300],
                        child: Image.network(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcre8GBb1zFgdcknZnpLMaximTofaK-cnVXkD-1WwcTA&s=10",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        color: Colors.grey[400],
                        child: const Center(
                          child: Icon(
                            Icons.image,
                            size: 80,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Chấm chỉ vị trí trang (Dots indicator giả lập)
                  Positioned(
                    bottom: 16,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Nội dung chi tiết cuộn bên dưới
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Áo thun nam thời trang cao cấp cotton thoáng mát',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Icon(Icons.star, size: 16, color: Colors.amber),
                      Icon(Icons.star, size: 16, color: Colors.amber),
                      Icon(Icons.star, size: 16, color: Colors.amber),
                      Icon(Icons.star, size: 16, color: Colors.amber),
                      Icon(Icons.star_half, size: 16, color: Colors.amber),
                      SizedBox(width: 8),
                      Text(
                        '4.5 (120 đánh giá)',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: const [
                      Text(
                        '150.000đ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange,
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        '200.000đ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const Text(
                    'Mô tả sản phẩm',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Chất liệu cotton 100% mềm mịn, thấm hút mồ hôi cực tốt. Thiết kế trẻ trung, năng động phù hợp cho cả đi chơi và dạo phố. Đường may tỉ mỉ, sắc nét chuẩn hàng cao cấp.\n\nXem thêm nội dung chi tiết tại đây để biết thêm thông tin về sản phẩm...',
                    style: TextStyle(color: Colors.grey, height: 1.5),
                  ),
                  const SizedBox(
                    height: 100,
                  ), // Khoảng trống tránh bị che bởi thanh hành động dưới đáy
                ],
              ),
            ),
          ),
        ],
      ),
      // Yêu cầu 5: Thanh hành động cố định ở đáy, không cuộn theo nội dung
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.green),
                  ),
                  child: const Text(
                    'Thêm vào giỏ',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text('Mua ngay'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
