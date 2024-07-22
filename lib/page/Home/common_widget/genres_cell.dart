import 'dart:convert';
import 'dart:typed_data';
import 'package:doan_cuahangbansach/data/model/category.dart';
import 'package:flutter/material.dart';

String normalizeBase64(String base64String) {
  while (base64String.length % 4 != 0) {
    base64String += '=';
  }
  return base64String;
}
Widget genres_cell(CateGorys cate, BuildContext context) {
  String chuoiBase64 = normalizeBase64(cate.img ?? '');
  Uint8List imageBytes = base64Decode(chuoiBase64);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: MemoryImage(imageBytes),
          fit: BoxFit.cover,
          onError: (exception, stackTrace) {
            debugPrint('Failed to load image: $exception');
          },
        ),
      ),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black54, 
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            cate.name!,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }