import '../model/product.dart';  
List<Product> createDataList(int amount) {
  List<Product> lstPro = [];
  for (int i = 1; i <= amount; i++) {
    lstPro.add(Product(
      id: i,
      name: "Smartphone new version $i",
      price: (i * 10000000),
      img: "img_$i.jpg",
      des: "Iphone",
      categoryID: i,
    ));
  }
  return lstPro;
}