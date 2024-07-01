import 'package:doan_cuahangbansach/data/model/product.dart';
import 'package:doan_cuahangbansach/dbhelper/const.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static late Db db;
  static late DbCollection userCollect;
  static late DbCollection proCollect;
  static late DbCollection cateCollect;

  // lấy dữ liệu từ collection
  static Future<void> connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    userCollect = db.collection(USER);
    proCollect = db.collection(PRODUCT);
    cateCollect = db.collection(CATEGORY);
  }
  // danh sách sản phẩm -------------------------------------------------------------------
  // static Future<List<Map<String, dynamic>>> getProducts() async {
  //   var products = await proCollect.find().toList();
  //   return products.map((product) => product).toList();
  // }

  // danh sách danh mục, thể loại ---------------------------------------------------------
  static Future<List<Map<String, dynamic>>> getCategory() async {
    var categorys = await cateCollect.find().toList();
    return categorys.map((cate) => cate).toList();
  }
  // danh sach san pham
  static Future<List<Product>> getProducts() async {
    var products = await proCollect.find().toList();
    return products.map((product) => Product.fromMap(product)).toList();
  }
}
