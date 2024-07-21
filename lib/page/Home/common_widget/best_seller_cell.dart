import 'dart:convert';
import 'dart:typed_data';
import 'package:doan_cuahangbansach/data/model/product.dart';
import 'package:doan_cuahangbansach/page/SharePre/srfr.dart';
import 'package:doan_cuahangbansach/page/cart/cartcounter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Hàm lấy ID người dùng từ SharedPreferences
  late Future<String?> _id;

Future<String?> getUserId() async {
   return _id = SharedPreferencesHelper.getId();

}

String normalizeBase64(String base64String) {
  while (base64String.length % 4 != 0) {
    base64String += '=';
  }
  return base64String;
}

Future<void> addCart(String idPro, String idCus, int count, int price) async {
  final String apiUrl = 'http://172.18.48.1:3000/api/cart';  
  Map<String, dynamic> user = {
    'idPro': idPro.trim(),
    'idCus': idCus.trim(),
    'giaSP': price,
    'soLuong': count,
  };

  try {
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user),
    );

    if (response.statusCode == 201) {
      print('Giỏ hàng thêm thành công');
    } else {
      print('Thêm giỏ hàng thất bại: ${response.body}');
    }
  } catch (e) {
    print('Thêm giỏ hàng thất bại: $e');
  }
}

Widget BestSellerCell(Product pro, BuildContext context) {
  return FutureBuilder<String?>(
    future: getUserId(),
    builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (!snapshot.hasData || snapshot.data == null) {
        return const Center(child: Text('No user ID found'));
      } else {
        String idCus = snapshot.data!;
        String chuoiBase64 = normalizeBase64(pro.img ?? '');
        Uint8List imageBytes = base64Decode(chuoiBase64);
        var media = MediaQuery.of(context).size;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          width: media.width * 0.32,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38,
                      offset: Offset(0, 2),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.memory(
                    imageBytes,
                    width: media.width * 0.32,
                    height: media.width * 0.50,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                pro.name!,
                maxLines: 3,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                pro.des!,
                maxLines: 1,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: const Color(0xff212121).withOpacity(0.4),
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IgnorePointer(
                    ignoring: true,
                    child: RatingBar.builder(
                      initialRating: 2,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 12,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Color(0xFF4D9194),
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                  ),
                  const SizedBox(height: 8),
                  IconButton(
                    icon: const Icon(Icons.add_shopping_cart,size: 20,),
                    onPressed: () {
                      if (pro.soLuongTon == 0) {
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.black.withOpacity(0.3),
                              content: Opacity(
                                opacity: 1,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextButton(
                                      child: const Text(
                                        'Sản phẩm đã hết hàng',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        addCart(pro.id!, idCus, 1, pro.price!);
                        // Cập nhật số lượng giỏ hàng
                        Provider.of<CartItemCountProvider>(context, listen: false).updateItemCountDetail();
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.black.withOpacity(0.3),
                              content: Opacity(
                                opacity: 1,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextButton(
                                      child: const Text(
                                        'Đã thêm vào giỏ hàng',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      }
    },
  );
}
