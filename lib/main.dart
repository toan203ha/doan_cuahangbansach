 import 'package:doan_cuahangbansach/page/mainpage.dart';
 import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ứng dụng bán sách',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
       // scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: const Mainpage(),
    );
  }
}
