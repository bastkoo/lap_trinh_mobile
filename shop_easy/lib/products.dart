import 'package:flutter/material.dart';

import 'language_controller.dart';

import 'setting.dart';
import 'cart_screen.dart';
import 'product_detail.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  int _selectedIndex = 0;
  String _selectedCategory = 'Tất cả';
  String _searchText = '';

  // Danh sách giỏ hàng
  final Map<String, int> _cart = {};

  final List<String> categories = [
    'Tất cả',
    'Áo thun',
    'Quần jean',
    'Giày dép',
    'Phụ kiện',
    'Balo',
  ];

  // Dữ liệu sản phẩm
  final Map<String, Map<String, dynamic>> products = {
    'SP01': {
      'name': 'Áo thun nam thời trang cao cấp cotton',
      'nameEn': 'Premium cotton mens T-shirt',
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcre8GBb1zFgdcknZnpLMaximTofaK-cnVXkD-1WwcTA&s=10',
      'price': 150000,
      'priceStr': '150.000đ',
      'oldPrice': '200.000đ',
      'discount': '-20%',
      'rating': 4.5,
      'reviewCount': 120,
      'category': 'Áo thun',
    },
    'SP02': {
      'name': 'Quần jean nam ống rộng phong cách Hàn Quốc',
      'nameEn': 'Korean-style wide-leg mens jeans',
      'imageUrl': 'https://img.lazcdn.com/g/p/12e559ff910d296b40ae782a04be5424.jpg_720x720q80.jpg',
      'price': 280000,
      'priceStr': '280.000đ',
      'oldPrice': '350.000đ',
      'discount': '-20%',
      'rating': 4.8,
      'reviewCount': 95,
      'category': 'Quần jean',
    },
    'SP03': {
      'name': 'Giày sneaker thể thao nam nữ năng động',
      'nameEn': 'Unisex sporty sneakers',
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT21AxJIg9maalHml9sQoOHSNDfwTNNUCpsX2wRz8PdzoMNqHpDKOI44S4&s=10',
      'price': 450000,
      'priceStr': '450.000đ',
      'oldPrice': '600.000đ',
      'discount': '-25%',
      'rating': 4.6,
      'reviewCount': 230,
      'category': 'Giày dép',
    },
    'SP04': {
      'name': 'Balo laptop chống thấm nước thời trang',
      'nameEn': 'Stylish water-resistant laptop backpack',
      'imageUrl': 'https://bizweb.dktcdn.net/thumb/large/100/044/266/products/balo-rolltop-fix-laptop-15-6-inch-thiet-ke-sanh-dieu-thoi-trang-moi-nhat-kingbag-sofia-ii-14.jpg?v=1723513379603',
      'price': 320000,
      'priceStr': '320.000đ',
      'oldPrice': '400.000đ',
      'discount': '-20%',
      'rating': 4.7,
      'reviewCount': 140,
      'category': 'Balo',
    },
    'SP05': {
      'name': 'Tai nghe Bluetooth không dây',
      'nameEn': 'Wireless Bluetooth headphones',
      'imageUrl':
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e',
      'price': 250000,
      'priceStr': '250.000đ',
      'oldPrice': '350.000đ',
      'discount': '-29%',
      'rating': 4.8,
      'reviewCount': 125,
      'category': 'Phụ kiện',
    },

    'SP06': {
      'name': 'Đồng hồ thông minh thể thao',
      'nameEn': 'Smart sports watch',
      'imageUrl':
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30',
      'price': 450000,
      'priceStr': '450.000đ',
      'oldPrice': '600.000đ',
      'discount': '-25%',
      'rating': 4.6,
      'reviewCount': 98,
      'category': 'Phụ kiện',
    },

    'SP07': {
      'name': 'Giày sneaker nam phong cách trẻ trung',
      'nameEn': 'Stylish casual mens sneakers',
      'imageUrl': 'https://images.unsplash.com/photo-1542291026-7eec264c27ff',
      'price': 550000,
      'priceStr': '550.000đ',
      'oldPrice': '750.000đ',
      'discount': '-27%',
      'rating': 4.9,
      'reviewCount': 210,
      'category': 'Giày dép',
    },

    'SP08': {
      'name': 'Áo thun nam cotton basic',
      'nameEn': 'Basic cotton mens T-shirt',
      'imageUrl':
          'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab',
      'price': 180000,
      'priceStr': '180.000đ',
      'oldPrice': '240.000đ',
      'discount': '-25%',
      'rating': 4.7,
      'reviewCount': 165,
      'category': 'Áo thun',
    },
  };

  // ==================== 1. XỬ LÝ GIỎ HÀNG ====================

  void _addToCart(String productId) {
    setState(() {
      if (_cart.containsKey(productId)) {
        _cart[productId] = _cart[productId]! + 1;
      } else {
        _cart[productId] = 1;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          LanguageController.text(
            'Đã thêm ${products[productId]!['name']} vào giỏ hàng!',
            'Added ${products[productId]!['nameEn'] ?? products[productId]!['name']} to cart!',
          ),
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  int get _totalCartItems {
    // hàm tính tổng số lượng sản phẩm trong giỏ hàng
    return _cart.values.fold(0, (sum, element) => sum + element);
  }

  // ==================== 2. MỞ CHI TIẾT SẢN PHẨM ====================

  void _openProductDetail(String productId) {
    final selectedProduct = products[productId];

    if (selectedProduct == null) return;

    Navigator.push(
      //chồng lên màn hình chi tiết sản phẩm
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetail(
          productId: productId,
          productData: selectedProduct,

          // Thêm sản phẩm vào giỏ hàng
          onAddToCart: () => _addToCart(productId),

          onGoToCart: () {
            setState(() {
              _selectedIndex = 1;
            });
          },
        ),
      ),
    );
  }

  // ==================== 3. BUILD ====================

  @override
  Widget build(BuildContext context) {
    if (_selectedIndex == 1) {
      return CartScreen(
        cart: _cart,
        products: products,
        onCartChanged: (newCart) {
          setState(() {
            _cart.clear();
            _cart.addAll(newCart);
          });
        },
        onNavigationChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      );
    } else if (_selectedIndex == 2) {
      return Scaffold(
        appBar: AppBar(
          title: Text(LanguageController.text('Cài đặt', 'Settings')),
        ),
        body: const MySettings(),
        bottomNavigationBar: _buildBottomNavigationBar(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop Easy'),
        actions: [
          IconButton(
            icon: Badge(
              label: Text('$_totalCartItems'),
              isLabelVisible: _totalCartItems > 0,
              child: const Icon(Icons.shopping_cart),
            ),
            onPressed: () {
              setState(() {
                _selectedIndex = 1;
              });
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBox(),

            const SizedBox(height: 16),

            _buildCategoryList(),

            const SizedBox(height: 16),

            _buildProductGrid(),
          ],
        ),
      ),

      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // ==================== 4. Ô TÌM KIẾM ====================

  Widget _buildSearchBox() {
    return TextField(
      decoration: InputDecoration(
        hintText: LanguageController.text(
          'Nhập tên sản phẩm...',
          'Search products...',
        ),
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      onChanged: (value) {
        setState(() {
          _searchText = value;
        });
      },
    );
  }

  // ==================== 5. DANH MỤC SẢN PHẨM ====================

  Widget _buildCategoryList() {
    return SingleChildScrollView(
      //giúp màn hình cuộn ngang trái phải
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          final isSelected = _selectedCategory == category;

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FilterChip(
              label: Text(
                LanguageController.text(
                  category,
                  {
                        'Tất cả': 'All',
                        'Áo thun': 'T-shirts',
                        'Quần jean': 'Jeans',
                        'Giày dép': 'Shoes',
                        'Phụ kiện': 'Accessories',
                        'Balo': 'Backpacks',
                      }[category] ??
                      category,
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = category;
                });
              },
              selectedColor: Colors.green[200],
              checkmarkColor: Colors.green[800],
            ),
          );
        }).toList(),
      ),
    );
  }

  // ==================== 6. LƯỚI SẢN PHẨM ====================

  Widget _buildProductGrid() {
    final filteredProducts = products.entries.where((entry) {
      final product = entry.value;

      final matchCategory =
          _selectedCategory == 'Tất cả' ||
          product['category'] == _selectedCategory;

      final matchSearch = product['name'].toString().toLowerCase().contains(
        _searchText.toLowerCase(),
      );

      return matchCategory && matchSearch;
    }).toList();

    return GridView.builder(
      shrinkWrap: true, //chiếm 1 phần không gian, không chiếm toàn bộ màn hình
      physics: const NeverScrollableScrollPhysics(), // vô hiệu hóa cuộn riêng của GridView, để SingleChildScrollView cuộn
      itemCount: filteredProducts.length, // số lượng ô
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // số cột
        crossAxisSpacing: 12, // khoảng cách ngang giữa các ô
        mainAxisSpacing: 12, // khoảng cách dọc giữa các ô
        childAspectRatio: 0.60, // tỷ lệ chiều rộng/chiều cao của mỗi ô
      ),
      itemBuilder: (context, index) {
        final entry = filteredProducts[index];

        return ProductCard(
          productId: entry.key,
          productData: entry.value,

          // Thêm vào giỏ hàng
          onAddToCart: () => _addToCart(entry.key),

          // Mở trang chi tiết
          onTap: () => _openProductDetail(entry.key),
        );
      },
    );
  }

  // ==================== 7. THANH ĐIỀU HƯỚNG ====================

  NavigationBar _buildBottomNavigationBar() {
    return NavigationBar(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.home),
          label: LanguageController.text('Trang chủ', 'Home'),
        ),
        NavigationDestination(
          icon: Badge(
            label: Text('$_totalCartItems'),
            isLabelVisible: _totalCartItems > 0,
            child: const Icon(Icons.shopping_cart),
          ),
          label: LanguageController.text('Giỏ hàng', 'Cart'),
        ),
        NavigationDestination(
          icon: const Icon(Icons.settings),
          label: LanguageController.text('Cài đặt', 'Settings'),
        ),
      ],
    );
  }
}

// =====================================================
// 8. WIDGET THẺ SẢN PHẨM
// =====================================================

class ProductCard extends StatelessWidget {
  final String productId;
  final Map<String, dynamic> productData;
  final VoidCallback onAddToCart;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.productId,
    required this.productData,
    required this.onAddToCart,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3, // độ nổi của thẻ = 3
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias, // cắt các góc tròn của thẻ và con bên trong

      child: InkWell(
        // tạo hiệu ứng nhấn cho thẻ
        onTap: onTap,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ảnh sản phẩm
            Expanded(
              //để phần ảnh chiếm hết không gian còn lại của thẻ ở nửa trên
              child: Stack(
                //cho phép xếp chồng các lớp lên nhau
                children: [
                  Container(
                    width: double.infinity, // chiếm hết chiều ngang của thẻ
                    color: Colors.grey[300],
                    child: Image.network(
                      productData['imageUrl'],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(Icons.error, color: Colors.red),
                        );
                      },
                    ),
                  ),

                  // Nhãn giảm giá
                  Positioned(
                    top: 8,
                    left: 8, // vị trí nhãn dán
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        productData['discount'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Thông tin sản phẩm
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (LanguageController.isVietnamese
                        ? productData['name']
                        : (productData['nameEn'] ?? productData['name'])),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  // Đánh giá
                  Row(
                    children: [
                      const Icon(Icons.star, size: 12, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        '${productData['rating']}',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '(${productData['reviewCount']})',
                        style: const TextStyle(fontSize: 9, color: Colors.grey),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // Giá sản phẩm
                  Row(
                    children: [
                      Text(
                        productData['priceStr'],
                        style: const TextStyle(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        productData['oldPrice'],
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // Nút thêm vào giỏ
                  SizedBox(
                    width: double.infinity,
                    height: 28,
                    child: FilledButton.icon(
                      onPressed: onAddToCart,
                      icon: const Icon(Icons.add_shopping_cart, size: 12),
                      label: Text(
                        LanguageController.text('Thêm vào giỏ', 'Add to cart'),
                        style: TextStyle(fontSize: 10),
                      ),
                      style: FilledButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
