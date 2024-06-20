 import 'package:doan_cuahangbansach/config/const.dart';
import 'package:doan_cuahangbansach/data/model/product.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget itemGridView(Product productModel) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(color: Colors.grey.shade200),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          url_img + productModel.img!,
          height: 80,
          width: 80,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.image),
        ),
        Text(
          productModel.name ?? '',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Text(
          NumberFormat('Price: ###,###,###').format(productModel.price),
          style: const TextStyle(fontSize: 15, color: Colors.red),
        ),
        Text(
          NumberFormat('Price: ###,###,###').format(productModel.price),
          style: const TextStyle(fontSize: 15, color: Colors.red),
        ),
        Text(
          productModel.des!,
          style: const TextStyle(fontSize: 13, color: Colors.grey),
        ),
      ],
    ),
  );
}
