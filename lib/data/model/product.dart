import 'package:mongo_dart/mongo_dart.dart';

class Product {
  ObjectId? id;
  String? name;
  String? des;
  String? img;
  int? price;
  int? categoryID;

  Product({
    this.id,
    this.name,
    this.des,
    this.img,
    this.price,
    this.categoryID,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['_id'],
      name: map['TEN'],
      img: map['IMG'],
      des: map['DES'],
      price: map['PRICE'] ,
      //  categoryID: map['categoryID'],
    );
  }
}
