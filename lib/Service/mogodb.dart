import 'dart:developer';

import 'package:doan_cuahangbansach/Service/DatabaseService.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Mogodbase{
  static connect() async{
    var db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    var status = db.serverStatus();
   // print(status);
    var collection = db.collection(COLECTION_NAME);
   // print(await collection.find().toList());

  }
}