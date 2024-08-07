import 'package:doan_cuahangbansach/page/Page/infoPage.dart';
import 'package:flutter/material.dart';
import 'package:doan_cuahangbansach/page/Login_Register/layoutLogin.dart';
import 'package:doan_cuahangbansach/page/SharePre/srfr.dart';
import 'package:doan_cuahangbansach/page/TestConnect.dart';
import 'package:doan_cuahangbansach/page/cart/cartcounter.dart';
import 'package:doan_cuahangbansach/page/mainpage.dart';
 
import 'package:doan_cuahangbansach/dbhelper/mongodb.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartItemCountProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget { 
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {  
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ứng dụng bán sách',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const InfoPage(),  
    );
  }
}
