import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  const Rating({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đánh Giá'),
      ),
      body: const Center(
        child: Text('Nội dung đánh giá'),
      ),
    );
  }
}