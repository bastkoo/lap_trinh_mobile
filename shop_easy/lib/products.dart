import 'package:flutter/material.dart';
import 'package:flutter_application_1/setting.dart';
import 'package:flutter_application_1/product_detail.dart';

void main() {
  runApp(
    const MaterialApp(home: ProductList(), debugShowCheckedModeBanner: false),
  );
}

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  int _selectedIndex = 0;
  String _selectedCategory = 'Tất cả';
  String _searchText = '';

  final List<String> categories = [
    'Tất cả',
    'Áo thun',
    'Quần jean',
    'Giày dép',
    'Phụ kiện',
    'Balo',
  ];

  // 1. Tạo MỘT TỪ ĐIỂN duy nhất chứa tất cả sản phẩm
  // Key: Mã sản phẩm
  // Value: Thông tin sản phẩm

  final Map<String, Map<String, dynamic>> products = {
    'SP01': {
      'name': 'Áo thun nam thời trang cao cấp cotton',
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcre8GBb1zFgdcknZnpLMaximTofaK-cnVXkD-1WwcTA&s=10',
      'price': '150.000đ',
      'oldPrice': '200.000đ',
      'discount': '-20%',
      'rating': 4.5,
      'reviewCount': 120,
      'category': 'Áo thun',
    },

    'SP02': {
      'name': 'Quần jean nam ống rộng phong cách Hàn Quốc',
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcre8GBb1zFgdcknZnpLMaximTofaK-cnVXkD-1WwcTA&s=10',
      'price': '280.000đ',
      'oldPrice': '350.000đ',
      'discount': '-20%',
      'rating': 4.8,
      'reviewCount': 95,
      'category': 'Quần jean',
    },

    'SP03': {
      'name': 'Giày sneaker thể thao nam nữ năng động',
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcre8GBb1zFgdcknZnpLMaximTofaK-cnVXkD-1WwcTA&s=10',
      'price': '450.000đ',
      'oldPrice': '600.000đ',
      'discount': '-25%',
      'rating': 4.6,
      'reviewCount': 230,
      'category': 'Giày dép',
    },

    'SP04': {
      'name': 'Balo laptop chống thấm nước thời trang',
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcre8GBb1zFgdcknZnpLMaximTofaK-cnVXkD-1WwcTA&s=10',
      'price': '320.000đ',
      'oldPrice': '400.000đ',
      'discount': '-20%',
      'rating': 4.7,
      'reviewCount': 140,
      'category': 'Balo',
    },
  };

  // 2. In toàn bộ từ điển sản phẩm ra Console
  @override
  void initState() {
    super.initState();

    print('===== DANH SÁCH SẢN PHẨM =====');
    print(products);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),

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

  // APP BAR
  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Shop Easy'),
      actions: [
        IconButton(icon: const Icon(Icons.search), onPressed: () {}),

        IconButton(
          icon: const Badge(label: Text('3'), child: Icon(Icons.shopping_cart)),
          onPressed: () {},
        ),
      ],
    );
  }

  // THANH TÌM KIẾM
  Widget _buildSearchBox() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Nhập tên sản phẩm...',
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

  // DANH MỤC SẢN PHẨM
  Widget _buildCategoryList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,

      child: Row(
        children: categories.map((category) {
          final isSelected = _selectedCategory == category;

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),

            child: FilterChip(
              label: Text(category),
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

  // 3. LẤY DỮ LIỆU TỪ TỪ ĐIỂN ĐỂ HIỂN THỊ
  Widget _buildProductGrid() {
    // Chuyển các phần tử trong Map thành danh sách để duyệt
    final filteredProducts = products.entries.where((entry) {
      final product = entry.value;

      // Lọc theo danh mục
      final matchCategory =
          _selectedCategory == 'Tất cả' ||
          product['category'] == _selectedCategory;

      // Lọc theo tên sản phẩm
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
        childAspectRatio: 0.65,
      ),

      itemBuilder: (context, index) {
        // Lấy mã sản phẩm và thông tin sản phẩm từ Map
        final entry = filteredProducts[index];

        return ProductCard(productId: entry.key, productData: entry.value);
      },
    );
  }

  // THANH ĐIỀU HƯỚNG
  NavigationBar _buildBottomNavigationBar() {
    return NavigationBar(
      selectedIndex: _selectedIndex,

      onDestinationSelected: (index) {
        if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MySettings()),
          );

          return;
        }

        setState(() {
          _selectedIndex = index;
        });
      },

      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: 'Trang chủ'),

        NavigationDestination(
          icon: Badge(label: Text('3'), child: Icon(Icons.shopping_cart)),
          label: 'Giỏ hàng',
        ),

        NavigationDestination(icon: Icon(Icons.settings), label: 'Cài đặt'),
      ],
    );
  }
}

// ==========================================================
// WIDGET THẺ SẢN PHẨM
// ==========================================================

class ProductCard extends StatelessWidget {
  final String productId;
  final Map<String, dynamic> productData;

  const ProductCard({
    super.key,
    required this.productId,
    required this.productData,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProductDetail()),
        );
      },

      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildCardImage(), _buildCardInfo()],
        ),
      ),
    );
  }

  // HÌNH ẢNH SẢN PHẨM
  Widget _buildCardImage() {
    return Expanded(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            color: Colors.grey[300],

            child: Image.network(
              productData['imageUrl'],
              fit: BoxFit.cover,

              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;

                return const Center(child: CircularProgressIndicator());
              },

              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(Icons.error, color: Colors.red),
                );
              },
            ),
          ),

          // NHÃN GIẢM GIÁ
          Positioned(
            top: 8,
            left: 8,

            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),

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

          // YÊU THÍCH
          Positioned(
            top: 6,
            right: 6,

            child: CircleAvatar(
              radius: 14,
              backgroundColor: Colors.white,

              child: const Icon(
                Icons.favorite_border,
                size: 16,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // THÔNG TIN SẢN PHẨM
  Widget _buildCardInfo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productData['name'],

            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),

            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 4),

          // ĐÁNH GIÁ
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

          // GIÁ SẢN PHẨM
          Row(
            children: [
              Text(
                productData['price'],

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

          // NÚT THÊM VÀO GIỎ
          SizedBox(
            width: double.infinity,
            height: 28,

            child: FilledButton.icon(
              onPressed: () {},

              icon: const Icon(Icons.add_shopping_cart, size: 12),

              label: const Text('Thêm vào giỏ', style: TextStyle(fontSize: 10)),

              style: FilledButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
