import 'package:flutter/material.dart';

class DonhangHuy extends StatefulWidget {
  const DonhangHuy({super.key});

  @override
  State<DonhangHuy> createState() => _DonhangHuyState();
}

class _DonhangHuyState extends State<DonhangHuy> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text('Đơn hàng đã hủy'),
            ],
          ),
        ),
          
      ),
    );
  }
}