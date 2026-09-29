import 'package:flutter/material.dart';

void main() {
  List<String> danhMuc = ['Điện tử', 'Thời trang', 'Sách'];
  var soNguyen = [1, 2, 3, 4, 5];
  var rong = <double>[];
  //Truy cập
  print(danhMuc[0]); //pt vị trí 0
  print(danhMuc.first); // pt đầu tiên
  print(danhMuc.length);

  //thêm và xóa
  danhMuc.add('Đồ gia dụng');
  danhMuc.insert(1, 'Thực phẩm');
  danhMuc.addAll(['Sức khỏe', 'Thể thao']);
  danhMuc.remove('Sách'); // Xóa theo giá trị
  danhMuc.removeAt(0); // Xóa theo chỉ số
  // Tìm kiếm
  bool coTonTai = danhMuc.contains('Điện tử');
  int viTri = danhMuc.indexOf('Thời trang'); // -1 nếu không tìm thấy

  var sanPhamNoiBat = ['Laptop', 'Điện thoại'];
  var phuKien = ['Tai nghe', 'Sạc dự phòng'];

  //spread operator (...), trải phần tử của List này vào List khác
  var tatCa = [...sanPhamNoiBat, ...phuKien, 'Chuột'];
  // Null-aware spread (...?), an toàn khi List có thể null
  List<String>? khuyenMai;
  var hienThi = ['Tất cả sản phẩm', ...?khuyenMai]; // Bỏ qua nếu null
  // Collection If, thêm phần tử có điều kiện
  bool laTaiKhoanVIP = true;
  var menu = [
    'Trang chủ',
    'Sản phẩm',
    if (laTaiKhoanVIP) 'Ưu đãi VIP', // Chỉ thêm khi điều kiện đúng
    'Liên hệ',
  ];
  // Collection For, tạo phần tử từ vòng lặp
  var binhPhuong = [
    for (var x in [1, 2, 3]) x * x,
  ]; // [1, 4, 9]

  Map<String, double> giaSanPham = {
    'Laptop Dell XPS': 2500000,
    'iPhone 15': 2200000,
  };

  giaSanPham['AirPods Pro'] = 650000;
  giaSanPham['iPhone 15'] = 2100000;

  double? gia = giaSanPham['Laptop Dell XPS'];
  double giaMacDinh = giaSanPham['Không có'] ?? 0.0;
  bool coKey = giaSanPham.containsKey(
    'iPhone 15',
  ); // .containsKey là kiểm tra key có trong ko
  giaSanPham.forEach((sp, gia) => print('$sp: $gia đồng'));
  List<String> tenSanPham = giaSanPham.keys.toList();

  Set<String> tag = {'flutter', 'dart', 'mobile', 'flutter'};
  print(tag);

  var soNguyen1 = <int>{1, 2, 3, 4, 5};
  // Các phép toán tập hợp, rất hữu ích khi xử lý quyền hạn
  Set<String> quyenAdmin = {'doc', 'ghi', 'xoa', 'sua'};
  Set<String> quyenKhachHang = {'doc', 'ghi'};
  quyenAdmin.intersection(quyenKhachHang); // {'doc', 'ghi'}, giao
  quyenAdmin.union(quyenKhachHang); // hợp
  quyenAdmin.difference(quyenKhachHang); // {'xoa', 'sua'}, hiệu

  //Hàm bậc cao
  var diemSo = [6.5, 8.0, 4.5, 9.0, 7.5, 5.0, 8.5];
  var xepLoai = diemSo.map((d) => d >= 8.0 ? 'Giỏi' : 'Chưa giỏi').toList();
  print(xepLoai);
}
