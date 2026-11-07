import 'package:flutter/material.dart';
import 'language_controller.dart';

// =====================================================
// 1. MODEL ĐƠN HÀNG
// =====================================================

class Order {
  final String id;
  final String customer;
  final String date;
  final String total;
  final String status;

  const Order({
    required this.id,
    required this.customer,
    required this.date,
    required this.total,
    required this.status,
  });
}

// =====================================================
// 2. TRANG TỔNG QUAN
// =====================================================

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  // Dữ liệu thống kê mẫu
  final int totalOrders = 128;
  final String revenue = '45.800.000đ';
  final int totalCustomers = 356;
  final int totalProducts = 245;

  // Danh sách đơn hàng mẫu
  static const List<Order> recentOrders = [
    Order(
      id: '#DH001',
      customer: 'Nguyễn Văn A',
      date: '02/11/2026',
      total: '450.000đ',
      status: 'Hoàn thành',
    ),
    Order(
      id: '#DH002',
      customer: 'Trần Văn B',
      date: '02/11/2026',
      total: '320.000đ',
      status: 'Đang giao',
    ),
    Order(
      id: '#DH003',
      customer: 'Lê Thị C',
      date: '01/11/2026',
      total: '520.000đ',
      status: 'Đã hủy',
    ),
    Order(
      id: '#DH004',
      customer: 'Phạm Văn D',
      date: '01/11/2026',
      total: '780.000đ',
      status: 'Chờ xử lý',
    ),
    Order(
      id: '#DH005',
      customer: 'Hoàng Thị E',
      date: '31/10/2026',
      total: '250.000đ',
      status: 'Hoàn thành',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LanguageController.text('Tổng quan', 'Dashboard'),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: CustomScrollView(
        slivers: [
          // Tiêu đề trang
          SliverToBoxAdapter(child: _buildPageHeader()),

          // 4 ô thống kê
          SliverToBoxAdapter(child: _buildStatistics(context)),

          // Tiêu đề đơn hàng gần đây
          SliverToBoxAdapter(child: _buildRecentOrderHeader()),

          // Danh sách đơn hàng
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return RecentOrderItem(order: recentOrders[index]);
            }, childCount: recentOrders.length),
          ),

          // Khoảng trống cuối trang
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }

  // =====================================================
  // 3. TIÊU ĐỀ TRANG
  // =====================================================

  Widget _buildPageHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LanguageController.text('Xin chào, Admin!', 'Hello, Admin!'),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            LanguageController.text('Dưới đây là tình hình kinh doanh của cửa hàng.', 'Here is your store performance overview.'),
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // 4. BLOCK 4 Ô THỐNG KÊ
  // =====================================================

  Widget _buildStatistics(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // Màn hình > 600dp: 4 cột
    // Màn hình <= 600dp: 2 cột
    final crossAxisCount = width > 600 ? 4 : 2;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GridView.count(
        crossAxisCount: crossAxisCount,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: width > 600 ? 1.5 : 1.05,
        children: [
          StatisticCard(
            title: LanguageController.text('Đơn hàng', 'Orders'),
            value: '$totalOrders',
            icon: Icons.shopping_bag_outlined,
            color: Colors.blue,
          ),

          StatisticCard(
            title: LanguageController.text('Doanh thu', 'Revenue'),
            value: revenue,
            icon: Icons.account_balance_wallet_outlined,
            color: Colors.green,
          ),

          StatisticCard(
            title: LanguageController.text('Khách hàng', 'Customers'),
            value: '$totalCustomers',
            icon: Icons.people_outline,
            color: Colors.orange,
          ),

          StatisticCard(
            title: LanguageController.text('Sản phẩm', 'Product'),
            value: '$totalProducts',
            icon: Icons.inventory_2_outlined,
            color: Colors.purple,
          ),
        ],
      ),
    );
  }

  // =====================================================
  // 5. TIÊU ĐỀ ĐƠN HÀNG GẦN ĐÂY
  // =====================================================

  Widget _buildRecentOrderHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            LanguageController.text('Đơn hàng gần đây', 'Recent orders'),
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),

          TextButton(
            onPressed: () {
              // TODO: Chuyển sang trang quản lý đơn hàng
            },
            child: Text(LanguageController.text('Xem tất cả', 'View all')),
          ),
        ],
      ),
    );
  }
}

// =====================================================
// 6. WIDGET THẺ THỐNG KÊ
// =====================================================

class StatisticCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const StatisticCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon hình tròn
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 21),
              ),

              const SizedBox(height: 6),

              // Số liệu lớn
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 2),

              // Nhãn
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================
// 7. WIDGET MỘT ĐƠN HÀNG GẦN ĐÂY
// =====================================================

class RecentOrderItem extends StatelessWidget {
  final Order order;

  const RecentOrderItem({super.key, required this.order});

  // Màu trạng thái
  Color _getStatusColor() {
    switch (order.status) {
      case 'Hoàn thành':
        return Colors.green;

      case 'Đang giao':
        return Colors.orange;

      case 'Đã hủy':
        return Colors.red;

      case 'Chờ xử lý':
        return Colors.blue;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      elevation: 1,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Icon đơn hàng
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                color: Colors.green,
              ),
            ),

            const SizedBox(width: 12),

            // Thông tin đơn hàng
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.id,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    order.customer,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    order.date,
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    order.total,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.deepOrange,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // Nhãn trạng thái
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                LanguageController.text(
                  order.status,
                  order.status == 'Hoàn thành' ? 'Completed' :
                  order.status == 'Đang giao' ? 'Shipping' :
                  order.status == 'Đã hủy' ? 'Cancelled' : 'Pending',
                ),
                style: TextStyle(
                  color: statusColor,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
