import 'package:flutter/material.dart';

class ImgFive extends StatelessWidget {
  const ImgFive({super.key});

  final String img1 =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSetFbU5owZnJAIZCLeQlxbPyVqtMSTp8AR6L0gNAbBdg&s=10";
  final String img2 =
      "https://cdn.pixabay.com/photo/2016/10/25/12/28/iceland-1768744_1280.jpg";
  final String img3 =
      "https://marketplace.canva.com/HCuXc/MAEzXIHCuXc/1/tl/canva--a-beautiful-scenery-of-a-mountain-range-MAEzXIHCuXc.jpg";
  final String img4 =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8lnXEf7jVOtNG_hr-gM5tFAEQWNVUgBoQUTAlEoaMB8Fzh84Cuo6RR54&s=10";
  final String img5 =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8f4121wLrCmjw1V7VFsFDRm0ChZclvWs3zurZAivo7dVi9oVvudCRvRFx&s=10";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // 1. Chuyển hướng cuộn sang chiều ngang
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          // Bọc Padding để các ảnh có khoảng cách nhẹ không dính liền nhau
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Image.network(
              img1,
              width:
                  300, // 2. Đổi double.infinity thành chiều rộng cụ thể (300px)
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Image.network(
              img2,
              width: 300,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Image.network(
              img3,
              width: 300,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Image.network(
              img4,
              width: 300,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Image.network(img5, width: 300, height: 200, fit: BoxFit.cover),
        ],
      ),
    );
  }
}
