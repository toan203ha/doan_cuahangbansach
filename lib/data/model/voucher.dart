import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:http/http.dart' as http;

class Voucher {
  String? id;
  String? titleVoucher;
  double? valueVoucher;
  String? descVoucher;

  Voucher({this.id, this.titleVoucher, this.valueVoucher, this.descVoucher});

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
      id: json['_id'] != null ? ObjectId.parse(json['_id']).toHexString() : '',
      titleVoucher: json['titleVoucher'],
      valueVoucher: json['valueVoucher'],
      descVoucher: json['descVoucher'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'titleVoucher': titleVoucher,
      'valueVoucher': valueVoucher,
      'descVoucher': descVoucher,
    };
  }
}

Future<List<Voucher>> fetchVouchers() async {
  final response = await http.get(Uri.parse('http://172.18.48.1:3000/api/vourcher'));
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((voucher) => Voucher.fromJson(voucher)).toList();
  } else {
    throw Exception('Failed to load vouchers');
  }
}
