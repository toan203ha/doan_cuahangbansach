// ignore: file_names
import 'package:flutter/material.dart';

class Donhangxacnhan extends StatefulWidget {
  const Donhangxacnhan({super.key});

  @override
  State<Donhangxacnhan> createState() => _DonhangxacnhanState();
}

class _DonhangxacnhanState extends State<Donhangxacnhan> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text('Đơn hàng đang chờ xác nhận'),
            ],
          ),
        ),
          
      ),
    );
  }
}