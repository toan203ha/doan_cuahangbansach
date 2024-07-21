 
import 'package:doan_cuahangbansach/dbhelper/const.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static late Db db;
   static late DbCollection dhCollect;

  // lấy dữ liệu từ collection
  static Future<void> connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    dhCollect = db.collection(donHang); 
  }
}
