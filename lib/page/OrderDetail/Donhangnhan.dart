import 'package:doan_cuahangbansach/data/model/oder.dart';
import 'package:doan_cuahangbansach/item/ItemOrder.dart';
import 'package:flutter/material.dart';

class Donhangnhan extends StatefulWidget {
  const Donhangnhan({super.key});

  @override
  State<Donhangnhan> createState() => _DonhangnhanState();
}

class _DonhangnhanState extends State<Donhangnhan> {
  final List<Order> orders = List.generate(
    6,
    (index) => Order(
      imageUrl: 'https://via.placeholder.com/150',
      namePro: 'Sơn Tĩnh Thủy Tinh và 02 sản phẩm khác',
      quantity: 'Số lượng: 3 | 20000',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: const Color(0xFFE7E7E7),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: orders.length,
          itemBuilder: (context, index) {
            return itemOrder(orders[index]);
          },
        ),
      ),
    );
  }
}
