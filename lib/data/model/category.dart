import 'package:mongo_dart/mongo_dart.dart';

class CateGorys {
  ObjectId? id;
  String? name;
  String? img;
  
  CateGorys({
    this.id,
    this.name,
    this.img

  });

  factory CateGorys.fromMap(Map<String, dynamic> map) {
    return CateGorys(
      id: map['_id'],
      name: map['TENLOAI'],
      img: map['IMG'],
    );
  }
}
