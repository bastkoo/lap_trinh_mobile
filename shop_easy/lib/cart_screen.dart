import 'package:flutter/material.dart';
import 'language_controller.dart';

class CartScreen extends StatefulWidget {
  final Map<String, int> cart;
  final Map<String, Map<String, dynamic>> products;
  final Function(Map<String, int>) onCartChanged;
  final Function(int) onNavigationChanged; //Hàm callback để điều hướng sang màn hình khác

  const CartScreen({
    super.key,
    required this.cart, //required: tham số bắt buộc, cart là một Map chứa thông tin về giỏ hàng, với key là productId và value là quantity
    required this.products,
    required this.onCartChanged,
    required this.onNavigationChanged,
  }); //hàm tạo có tham số bắt buộc là cart, products, onCartChanged và onNavigationChanged

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Map<String, int> _localCart;

  @override
  void initState() {
    super.initState();
    _localCart = Map.from(widget.cart);
  }

  // ==================== 1. XỬ LÝ GIỎ HÀNG ====================

  void _updateQuantity(String productId, int delta) {
    setState(() {
      int newQty = (_localCart[productId] ?? 0) + delta;

      if (newQty <= 0) {
        _localCart.remove(productId);
      } else {
        _localCart[productId] = newQty;
      }
    });

    widget.onCartChanged(_localCart);
  }

  void _removeItem(String productId) {
    final removedQty = _localCart[productId];
    final removedProduct = widget.products[productId];

    setState(() {
      _localCart.remove(productId);
    });

    widget.onCartChanged(_localCart);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(LanguageController.text('Đã xóa ${removedProduct?['name']}', 'Removed ${removedProduct?['nameEn'] ?? removedProduct?['name']}')),
        action: SnackBarAction(
          label: LanguageController.text('Hoàn tác', 'Undo'),
          onPressed: () {
            setState(() {
              _localCart[productId] = removedQty ?? 1;
            });

            widget.onCartChanged(_localCart);
          },
        ),
      ),
    );
  }

  // ==================== 2. TÍNH TOÁN ĐƠN HÀNG ====================

  double _calculateTotalAmount() {
    double total = 0;

    for (var entry in _localCart.entries) {
      final product = widget.products[entry.key];

      if (product != null) {
        total += (product['price'] as int) * entry.value;
      }
    }

    return total;
  }

  double _calculateShippingFee(double totalAmount) {
    return totalAmount >= 500000 || totalAmount == 0 ? 0 : 30000;
  }

  double _calculateFinalTotal(double totalAmount, double shippingFee) {
    return totalAmount + shippingFee;
  }

  // ==================== 3. BLOCK GIỎ HÀNG TRỐNG ====================

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            LanguageController.text('Giỏ hàng trống', 'Your cart is empty'),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            onPressed: () => widget.onNavigationChanged(0),
            child: Text(LanguageController.text('Tiếp tục mua sắm', 'Continue shopping')),
          ),
        ],
      ),
    );
  }

  // ==================== 4. BLOCK NÚT TĂNG GIẢM ====================

  Widget _buildQuantityButton(String productId, int delta, IconData icon) {
    return InkWell(
      onTap: () => _updateQuantity(productId, delta),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(icon, size: 14),
      ),
    );
  }

  // ==================== 5. BLOCK MỘT SẢN PHẨM ====================

  Widget _buildCartItem(String productId, int quantity) {
    final product = widget.products[productId]!;

    return Dismissible(
      key: Key(productId),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        _removeItem(productId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  product['imageUrl'],
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LanguageController.isVietnamese
                          ? product['name']
                          : (product['nameEn'] ?? product['name']),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      product['priceStr'],
                      style: const TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              Row(
                children: [
                  _buildQuantityButton(productId, -1, Icons.remove),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      '$quantity',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  _buildQuantityButton(productId, 1, Icons.add),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==================== 6. BLOCK DANH SÁCH SẢN PHẨM ====================

  Widget _buildCartList(List<MapEntry<String, int>> cartEntries) {
    return Expanded(
      child: ListView.builder(
        itemCount: cartEntries.length,
        itemBuilder: (context, index) {
          final entry = cartEntries[index];

          return _buildCartItem(entry.key, entry.value);
        },
      ),
    );
  }

  // ==================== 7. BLOCK TỔNG TIỀN ====================

  Widget _buildCartSummary(
    double totalAmount,
    double shippingFee,
    double finalTotal,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(LanguageController.text('Tổng tiền hàng:', 'Subtotal:')),
              Text(
                '${totalAmount.toInt()}đ',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),

          const SizedBox(height: 6),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(LanguageController.text('Phí vận chuyển:', 'Shipping fee:')),
              Text(
                shippingFee == 0
                    ? LanguageController.text('Miễn phí (Đơn từ 500k)', 'Free (orders over 500k)')
                    : '${shippingFee.toInt()}đ',
                style: TextStyle(
                  color: shippingFee == 0 ? Colors.green : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const Divider(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LanguageController.text('Thanh toán:', 'Total:'),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                '${finalTotal.toInt()}đ',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(LanguageController.text('Thanh toán thành công!', 'Payment successful!'))),
                );
              },
              child: Text(LanguageController.text('Thanh toán', 'Checkout')),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== 9. GIAO DIỆN CHÍNH ====================

  @override
  Widget build(BuildContext context) {
    final cartEntries = _localCart.entries.toList();

    final totalAmount = _calculateTotalAmount();
    final shippingFee = _calculateShippingFee(totalAmount);
    final finalTotal = _calculateFinalTotal(totalAmount, shippingFee);

    return Scaffold(
      appBar: AppBar(
        title: Text(LanguageController.text('Giỏ hàng của tôi', 'My cart')),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => widget.onNavigationChanged(0),
        ),
      ),

      body: cartEntries.isEmpty
          ? _buildEmptyCart()
          : Column(
              children: [
                _buildCartList(cartEntries),

                _buildCartSummary(totalAmount, shippingFee, finalTotal),
              ],
            ),
    );
  }
}
