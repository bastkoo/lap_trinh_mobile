void main() {
  // kiểu tường minh
  print("Xin chào, Flutter!");
  String ten = "Nguyễn Quốc Đạt";
  int tuoi = 20;
  double diemTB = 9.5;
  bool laSinhVien = true;
  //suy luận kiểu
  var ten1 = "Nguyễn Văn Huy";
  var tuoi1 = 21;
  var diemTB1 = 8.5;

  //final và const
  final String ten2 = "Nguyễn Văn A"; //final int tuoi2 = 22; //final có thể được khởi tạo tại thời điểm chạy
  const double diemTB2 = 7.5; //const phải được khởi tạo tại thời điểm biên dịch

  print("Sinh viên $ten1, tuổi $tuoi1");

  //biểu thức phức tạp hơn dùng ${}
  print(
    "${diemTB1.toStringAsFixed(2)}, xếp loại ${diemTB1 >= 8 ? "Giỏi" : "Khá"}",
  );

  String moTa = '''
  Đây là một chuỗi nhiều dòng
  Dùng dấu nháy ba để tạo chuỗi nhiều dòng
  ''';
  String duongDan = r"C:\Users\NguyenQuocDat\Documents\Flutter"; //r để tạo chuỗi raw, không cần escape ký tự đặc biệt

  dynamic batKy = "Bắt đầu là chuỗi"; //dynamic có thể thay đổi kiểu dữ liệu
  batKy = 10; // có thể thay đổi thành kiểu khác

  //Null Safety
  String ten3; //Không bao giờ null, phải được khởi tạo trước khi sử dụng
  String?
  ten4; //Có thể null, có thể không được khởi tạo phải kiểm tra trc khi sử dụng

  //4 Toán tử làm việc với giá trị nullable
  //1. Toán tử ?. gọi phương thức ai toàn

  String? email;
  String? nguoiDung;
  String? diaChi;
  int? doDai =
      email?.length; // nếu email null thì doDai cũng null, không gây lỗi
  String? quocGia = nguoiDung?.diaChi?.quocGia; // nếu nguoiDung hoặc diaChi null thì quocGia cũng null, không gây lỗi

  //2. Toán tử ?? nếu null thì trả về giá trị mặc định
  String tenHienThi =
      tenDangNhap ??
      'Khách'; //Nếu tenDangNhap null thì tenHienThi sẽ là 'Khách'
  cache ??= layDuLieuTuServer(); //Nếu cache null thì lấy dữ liệu từ server, nếu không thì giữ nguyên giá trị cache

  //3. Toán tử ! ép kiểu không null
  String link = duongLink!; //Nếu duongLink null thì sẽ gây lỗi, nếu không null thì link sẽ có giá trị của duongLink

  // Từ khóa late để khai báo biến sẽ được khởi tạo sau, nhưng chắc chắn sẽ được khởi tạo trước khi sử dụng
  late String tenNguoiDung;
  void layTenNguoiDung() {
    tenNguoiDung = "Nguyễn Văn B";
  }

  void hienThiTenNguoiDung() {
    print(tenNguoiDung);
  }

  //Arrow function
  int tinhTong(int a, int b) =>
      a + b; // khi thân hàm chỉ có 1 lệnh thì có thể dùng arrow function

  //named parameter, chìa khóa hiểu cú pháp flutter
  void taoNguoiDung({
    required String ten, //required bắt buộc truyền tham số
    int tuoi = 18, //mặc định là 18 có thể ko truyền
    String? soDienThoai,
  }) {
    // nếu ko truyền thì là null
    print("Tên: $ten, Tuổi: $tuoi");
  }

  taoNguoiDung(
    ten: "Nguyễn Văn C",
    tuoi: 22,
    soDienThoai: "0123456789",
  ); //k cần theo thứ tự
  taoNguoiDung(ten: "Nguyễn Văn D", tuoi: 25); // chỉ truyền tên và tuổi

  //Danh sách
  List<String> danhMuc = ["Điện thoại", "Máy tính", "Tablet"];
  var soNguyen = [1, 2, 3, 4, 5];
  var rong = <double>[]; // danh sách rỗng kiểu double

  //truy capaj
  print(danhMuc[0]); //Điện thoại
  print(danhMuc.first);
  print(danhMuc.length);

  danhMuc.add("Laptop"); //thêm phần tử vào cuối danh sách
  danhMuc.insert(1, "Tai nghe"); //thêm phần tử vào vị trí 1
  danhMuc.removeAt(2); //xóa phần tử tại vị trí 2
  danhMuc.addAll(["Chuột", "Bàn phím"]); //thêm nhiều phần tử vào cuối danh sách
  danhMuc.remove('Sách'); //xóa phần tử có giá trị là 'Sách'
  danhMuc.removeAt(0); //xóa phần tử tại vị trí 0

  //tìm kiếm
  bool coTonTai = danhMuc.contains('Diện thoại'); //true nếu tồn tại, false nếu không tồn tại
  int viTri = danhMuc.indexOf('Máy tính'); // trả về vị trí của phần tử, nếu không tồn tại trả về -1

  //Toán tử spread ... và collection if, for
  var danhSachMoi = [...danhMuc, "Máy ảnh"]; // Sao chép tất cả phần tử từ danhMuc và thêm "Máy ảnh"
}
