class Product {
  int? id;
  String? name;
  int? price;
  String? img;
  String? des;
  int? categoryID;

  Product({
    this.id,
    this.name,
    this.price,
    this.img,
    this.des,
    this.categoryID,
  });


  // Product.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   name = json['name'];
  //   price = json['price'];
  //   img = json['img'];
  //   des = json['des'];
  //   categoryID = json['catId'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['id'] = id;
  //   data['name'] = name;
  //   data['img'] = img;
  //   data['price'] = price;
  //   data['des'] = des;
  //   data['catId'] = categoryID;
  //   return data;
  // }

}
