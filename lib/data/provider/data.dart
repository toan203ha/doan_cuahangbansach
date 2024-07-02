import 'package:doan_cuahangbansach/page/product/TrangTheLoai.dart';

List<ProductTheLoai> createDataList(int amount) {
  List<ProductTheLoai> lstPro = [];
  for (int i = 1; i <= amount; i++) {
    lstPro.add(ProductTheLoai(
      id: i,
      name: "Sách $i",
      price: (i * 10000000),
      img: "img_$i.jpg",
      des: "Mô tả",
      categoryID: i,
    ));
  }
  return lstPro;
}

