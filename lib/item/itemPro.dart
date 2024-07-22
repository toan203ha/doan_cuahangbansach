import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:doan_cuahangbansach/data/model/product.dart';

String normalizeBase64(String base64String) {
  while (base64String.length % 4 != 0) {
    base64String += '=';
  }
  return base64String;
}

Widget itemGridView(Product item) {
  final formatter = NumberFormat('#,##0', 'en_US');
  
  // Chuyển base64
  String chuoiBase64 = normalizeBase64(item.img ?? '');
  Uint8List imageBytes = base64Decode(chuoiBase64);

  return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
    
    children: [
      // Ảnh sản phẩm
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Image.memory(
          imageBytes,
          height: 150,
          width: 100,
         ),
      ),
      // Thông tin sản phẩm
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tên sản phẩm
            Text(
              item.name ?? '',
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis, // Đảm bảo tên không bị tràn
            ),
            // Giá sản phẩm
            Text(
              formatter.format(item.price ?? 0),
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              overflow: TextOverflow.ellipsis, // Đảm bảo giá không bị tràn
            ),
          ],
        ),
      ),
    ],
  );
}
