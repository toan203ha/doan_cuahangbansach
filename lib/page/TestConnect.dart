import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VoucherInfoScreen extends StatelessWidget {
 
  const VoucherInfoScreen({super.key,  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin Voucher'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getVoucherInfo('669b59ae335d1bf629c870ea'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Mã voucher: ${data['titleVoucher']}'),
                  Text('Tên voucher: ${data['descVoucher']}'),
                  Text('Giá trị voucher: ${data['valueVoucher']}'),
                 ],
              ),
            );
          } else {
            return Center(child: Text('Không có dữ liệu'));
          }
        },
      ),
    );
  }
}

Future<Map<String, dynamic>> getVoucherInfo(String idVou) async {
  final url ='http://172.18.48.1:3000/api/vourcher/info/$idVou';
 
  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      if (data.isNotEmpty) {
        return data[0] as Map<String, dynamic>;  
      } else {
        throw Exception('Voucher không tìm thấy');
      }
    } else {
      throw Exception('Lỗi khi lấy thông tin voucher');
    }
  } catch (error) {
    throw Exception('Lỗi kết nối: $error');
  }
}
