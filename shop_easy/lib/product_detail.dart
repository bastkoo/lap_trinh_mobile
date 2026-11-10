import 'package:flutter/material.dart';

import 'language_controller.dart';

class ProductDetail extends StatefulWidget {
  final String productId;
  final Map<String, dynamic> productData;
  final VoidCallback onAddToCart;
  final VoidCallback onGoToCart;

  const ProductDetail({
    super.key,
    required this.productId,
    required this.productData,
    required this.onAddToCart,
    required this.onGoToCart,
  });

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final PageController _pageController = PageController();
  int _currentImageIndex = 0;

  // Nếu sản phẩm có danh sách ảnh "images" thì dùng danh sách đó.
  // Nếu không, dùng imageUrl hiện có trong dữ liệu products.
  List<String> get _productImages {
    final images = widget.productData['images'];

    if (images is List && images.isNotEmpty) {
      return images.map((image) => image.toString()).toList();
    }

    final imageUrl = widget.productData['imageUrl']?.toString() ?? '';

    if (imageUrl.isNotEmpty) {
      return [imageUrl];
    }

    return [];
  }

  String get _productName {
    if (LanguageController.isVietnamese) {
      return widget.productData['name']?.toString() ??
          LanguageController.text('Sản phẩm', 'Product');
    }
    return widget.productData['nameEn']?.toString() ??
        widget.productData['name']?.toString() ??
        'Product';
  }

  String get _price =>
      widget.productData['priceStr']?.toString() ??
      LanguageController.text('Liên hệ', 'Contact');

  String get _oldPrice => widget.productData['oldPrice']?.toString() ?? '';

  String get _description =>
      widget.productData['description']?.toString() ??
      LanguageController.text(
        'Thông tin mô tả sản phẩm đang được cập nhật.',
        'Product description is being updated.',
      );

  @override
  void dispose() {
    //dọn dẹp bộ nhớ
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final images = _productImages;
    final rating =
        widget.productData['rating']?.toString() ??
        LanguageController.text('Chưa có', 'Not available');
    final reviewCount = widget.productData['reviewCount']?.toString() ?? '0';
    final discount = widget.productData['discount']?.toString() ?? '';

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        // cho phép hiển thị nhiều kiểu khác nhau và 1 vùng cuộn thông qua slivers
        slivers: [
          SliverAppBar(
            expandedHeight:
                300, // chiều cao tối đa khi người dùng chưa cuộn đi đâu
            pinned: true, // khi cuộn trang thì thanh appbar vẫn hiển thị
            backgroundColor: Colors.white,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: CircleAvatar(
                backgroundColor: Colors.black.withOpacity(0.35),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 18,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.35),
                  child: IconButton(
                    icon: const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 18,
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            LanguageController.text(
                              'Chức năng yêu thích sẽ được bổ sung sau.',
                              'Wishlist feature coming soon.',
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  if (images.isNotEmpty)
                    PageView.builder(
                      controller: _pageController,
                      itemCount: images.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentImageIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Image.network(
                          images[index],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[200],
                              child: const Center(
                                child: Icon(
                                  Icons.image_not_supported_outlined,
                                  size: 72,
                                  color: Colors.grey,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    )
                  else
                    Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          size: 72,
                          color: Colors.grey,
                        ),
                      ),
                    ),

                  if (discount.isNotEmpty)
                    Positioned(
                      left: 16,
                      bottom: 42,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          discount,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                  if (images.length > 1)
                    Positioned(
                      bottom: 16,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(images.length, (index) {
                          final isSelected = index == _currentImageIndex;

                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            width: isSelected ? 18 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.green
                                  : Colors.grey[400],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          );
                        }),
                      ),
                    ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _productName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        LanguageController.text(
                          '$rating ($reviewCount đánh giá)',
                          '$rating ($reviewCount reviews)',
                        ),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Text(
                        _price,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange,
                        ),
                      ),
                      if (_oldPrice.isNotEmpty) ...[
                        const SizedBox(width: 12),
                        Text(
                          _oldPrice,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),

                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 8),

                  Text(
                    LanguageController.text(
                      'Thông tin sản phẩm',
                      'Product information',
                    ),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  _InfoRow(
                    label: LanguageController.text('Mã sản phẩm', 'Product ID'),
                    value: widget.productId,
                  ),
                  _InfoRow(
                    label: LanguageController.text('Danh mục', 'Category'),
                    value: LanguageController.text(
                      widget.productData['category']?.toString() ?? '—',
                      {
                            'Áo thun': 'T-shirts',
                            'Quần jean': 'Jeans',
                            'Giày dép': 'Shoes',
                            'Phụ kiện': 'Accessories',
                            'Balo': 'Backpacks',
                          }[widget.productData['category']?.toString()] ??
                          widget.productData['category']?.toString() ??
                          '—',
                    ),
                  ),
                  _InfoRow(
                    label: LanguageController.text('Đánh giá', 'Reviews'),
                    value: '$rating/5',
                  ),

                  const SizedBox(height: 16),
                  Text(
                    LanguageController.text(
                      'Mô tả sản phẩm',
                      'Product description',
                    ),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _description,
                    style: const TextStyle(color: Colors.grey, height: 1.5),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),

      // Thanh hành động cố định ở dưới, giữ bố cục trang chi tiết ban đầu.
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // Thêm sản phẩm vào giỏ
                    widget.onAddToCart();
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.green),
                  ),
                  child: Text(
                    LanguageController.text('Thêm vào giỏ', 'Add to cart'),
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          LanguageController.text(
                            'Chức năng mua ngay sẽ được bổ sung sau.',
                            'Buy now feature coming soon.',
                          ),
                        ),
                      ),
                    );
                  },
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

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 115,
            child: Text(label, style: const TextStyle(color: Colors.grey)),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
