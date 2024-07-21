import 'dart:convert';
import 'package:doan_cuahangbansach/data/model/donhang.dart';
import 'package:doan_cuahangbansach/item/ItemOrder.dart';
import 'package:doan_cuahangbansach/page/Orders/0derDetail.dart';
import 'package:doan_cuahangbansach/page/Orders/Oder.dart';
import 'package:doan_cuahangbansach/page/SharePre/srfr.dart';
import 'package:doan_cuahangbansach/page/product/ThongBao.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Donhangxacnhan extends StatefulWidget {
  const Donhangxacnhan({super.key});

  @override
  State<Donhangxacnhan> createState() => _DonhangxacnhanState();
}

class _DonhangxacnhanState extends State<Donhangxacnhan> {
  late Future<String?> _id;
  @override
  void initState() {
    super.initState();
    _getIdFromSharedPreferences();
  }


Future<void> cancelDH(String orderId) async {
  final String apiUrl = 'http://172.18.48.1:3000/api/donhang/cancel/$orderId';

  try {
    var response = await http.put(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          {'thongBao': false, 'daHuy': true, 'dangChoXacNhan': false}),
    );
      setState(() {});
    if (response.statusCode == 200) {
      print('Cập nhật thông báo thành công');
      setState(() {});
    } else {
      print(
          'Failed to update notification with status code ${response.statusCode}');
      throw Exception('Failed to update notification');
    }
  } catch (e) {
    print('Error updating notification: $e');
    throw Exception('Failed to update notification');
  }
}
  Future<void> _getIdFromSharedPreferences() async {
    _id = SharedPreferencesHelper.getId();
  }

  static DonhangStatus? _parseStatus(String? statusString) {
    if (statusString == null) return null;
    switch (statusString) {
      case 'daGiao':
        return DonhangStatus.daGiao;
      case 'daHuy':
        return DonhangStatus.daHuy;
      case 'dangChoXacNhan':
        return DonhangStatus.dangChoXacNhan;
      default:
        return null;
    }
  }

  Future<List<Donhang>> fetchDonhangs(
      String idCus, bool daGiao, bool daHuy, bool dangChoXacNhan) async {
    var url = Uri.parse(
        'http://172.18.48.1:3000/api/donhang/payment/$idCus?daGiao=$daGiao&daHuy=$daHuy&dangChoXacNhan=$dangChoXacNhan');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);

      List<Donhang> donhangs = jsonList.map((json) {
        DateTime? ngayDat =
            json['ngayDat'] != null ? DateTime.tryParse(json['ngayDat']) : null;
        DateTime? ngayNhan = json['ngayNhan'] != null
            ? DateTime.tryParse(json['ngayNhan'])
            : null;
        return Donhang(
          id: json['_id'],
          idCus: json['idCus'],
          ngayDat: ngayDat,
          ngayNhan: ngayNhan,
          idPro: json['idPro'],
          status: _parseStatus(json['status']),
          address: json['address'],
          tenUser: json['tenUser'],
          thongBao: json['thongBao'],
          thanhTien: (json['thanhTien'] ?? 0).toDouble(),
                    maKM: json['maKM'],

        );
      }).toList();

      return donhangs;
    } else {
      throw Exception('tải thất bại');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _id,
      builder: (context, idSnapshot) {
        if (idSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (idSnapshot.hasError) {
          return Center(child: Text('Error: ${idSnapshot.error}'));
        } else if (!idSnapshot.hasData || idSnapshot.data!.isEmpty) {
          return Center(child: Text('No customer ID found'));
        } else {
          String idCus = idSnapshot.data!;
          return FutureBuilder<List<Donhang>>(
            future: fetchDonhangs(idCus, false, false, true),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                    child: Column(
                   children: [
                      Image.network(
                          'https://th.bing.com/th/id/OIP.KHgLzsvgkcl8wsWTjSHYpwHaHa?w=187&h=187&c=7&r=0&o=5&dpr=1.4&pid=1.7'),
                      Text('Chưa có thông tin đơn hàng'),
                    ],
                ));
              } else {
                List<Donhang> orders = snapshot.data!;

                return SingleChildScrollView(
                  child: Container(
                    color: const Color(0xFFE7E7E7),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        final itemPro = snapshot.data![index];
                        if (itemPro != null) {
                          return GestureDetector(
                            onTap: () {
                              print(itemPro.id);
                              if (itemPro.id != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OrderDetailView(
                                      dh: itemPro,
                                      customerName: idCus,
                                      status: OrderStatus.confirm,
                                      idkm: itemPro.maKM,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: itemOrderNhan(orders[index],idCus),
                          );
                        } else {
                       }
                      },
                    ),
                  ),
                );
              }
            },
          );
        }
      },
    );
  }
  
Widget itemOrderNhan(Donhang order,String idCus) {

    // Navigator.push(
    //                               context,
    //                               MaterialPageRoute(
    //                                 builder: (context) => OrderDetailView(
    //                                   dh: itemPro,
    //                                   customerName: idCus,
    //                                   status: OrderStatus.confirm,
    //                                 ),
    //                               ),
    //                             );
  final NumberFormat formatter = NumberFormat('#,##0', 'en_US');
  String formattedNgayDat =
      DateFormat('yyyy-MM-dd HH:mm:ss').format(order.ngayDat!);
  return Padding(
    padding: const EdgeInsets.all(1.0),
    child: Card(
      elevation: 5,
      shadowColor: Colors.grey,
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFF3E4154),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: const Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Giao hàng thành công',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Text(
                    'Viết đánh giá',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.network(
                  'https://th.bing.com/th/id/OIP.qn2ZoH7zzBHc3PkhKrj9gAAAAA?w=328&h=166&c=7&r=0&o=5&dpr=1.4&pid=1.7',
                  width: 50,
                  height: 50,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formattedNgayDat,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                       
                      const SizedBox(height: 5),
                      Text(
                        '${formatter.format(order.thanhTien ?? 0)} VND',
                      ),
                    ],
                  ),
                ),
                //iconTrangThai(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle navigate to detail screen
                      Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OrderDetailView(
                                      dh: order,
                                      customerName: idCus,
                                      status: OrderStatus.confirm,
                                    ),
                                  ),
                                );
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      shadowColor: Colors.grey,
                      backgroundColor: const Color(0XFFC4C4C4),
                    ),
                    child: const Text(
                      'Xem Chi Tiết',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      cancelDH(order.id!);
                      setState(() {
                          ThongBao();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 4,
                      shadowColor: Colors.grey,
                      backgroundColor: const Color(0xFF4D9194),
                    ),
                    child: const Text(
                      'Hủy đơn hàng',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
}
