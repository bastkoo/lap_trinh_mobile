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
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcre8GBb1zFgdcknZnpLMaximTofaK-cnVXkD-1WwcTA&s=10',
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
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcre8GBb1zFgdcknZnpLMaximTofaK-cnVXkD-1WwcTA&s=10',
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
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcre8GBb1zFgdcknZnpLMaximTofaK-cnVXkD-1WwcTA&s=10',
      'price': 320000,
      'priceStr': '320.000đ',
      'oldPrice': '400.000đ',
      'discount': '-20%',
      'rating': 4.7,
      'reviewCount': 140,
      'category': 'Balo',
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
    return _cart.values.fold(0, (sum, element) => sum + element);
  }

  // ==================== 2. MỞ CHI TIẾT SẢN PHẨM ====================

  void _openProductDetail(String productId) {
    final selectedProduct = products[productId];

    if (selectedProduct == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetail(
          productId: productId,
          productData: selectedProduct,

          // Thêm sản phẩm vào giỏ hàng
          onAddToCart: () => _addToCart(productId),

          // Chuyển sang tab giỏ hàng
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
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.60,
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
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,

      child: InkWell(
        onTap: onTap,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ảnh sản phẩm
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
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
                    left: 8,
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
