import 'dart:convert';
import 'package:doan_cuahangbansach/data/model/donhang.dart';
import 'package:doan_cuahangbansach/item/ItemOrder.dart';
import 'package:doan_cuahangbansach/page/OrderDetail/mainOrder.dart';
import 'package:doan_cuahangbansach/page/Orders/0derDetail.dart';
import 'package:doan_cuahangbansach/page/SharePre/srfr.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ThongBao extends StatefulWidget {
  const ThongBao({super.key});

  @override
  State<ThongBao> createState() => _ThongBaoState();
}

class _ThongBaoState extends State<ThongBao> {
  late Future<String?> _idFuture;
  late Future<List<Donhang>> _donhangsFuture;

  @override
  void initState() {
    super.initState();
    _idFuture = SharedPreferencesHelper.getId();
  }

  Future<List<Donhang>> fetchDonhangs(String idCus) async {
    var url = Uri.parse('http://172.18.48.1:3000/api/donhang/thongbao/$idCus');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);

      List<Donhang> donhangs = jsonList.map((json) {
        DateTime? ngayDat = json['ngayDat'] != null ? DateTime.tryParse(json['ngayDat']) : null;
        DateTime? ngayNhan = json['ngayNhan'] != null ? DateTime.tryParse(json['ngayNhan']) : null;

        return Donhang(
          id: json['_id'],
          idCus: json['idCus'],
          ngayDat: ngayDat,
          ngayNhan: ngayNhan,
          idPro: json['idPro'],
          address: json['address'],
          tenUser: json['tenUser'],
          daGiao: json['daGiao'],
          daHuy: json['daHuy'],
          dangChoXacNhan: json['dangChoXacNhan'],
          thongBao: json['thongBao'],
          thanhTien: (json['thanhTien'] ?? 0).toDouble(),
        );
      }).toList();

      return donhangs;
    } else {
      throw Exception('Failed to load data');
    }
  }
Future<void> updateThongBao(String orderId) async {
    final String apiUrl =
        'http://172.18.48.1:3000/api/donhang/thongbao/$orderId';

    try {
      var response = await http.put(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'thongBao': true}),
      );

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


  Future<void> _refreshData() async {
    final idCus = await _idFuture;
    if (idCus != null) {
      setState(() {
        _donhangsFuture = fetchDonhangs(idCus);
      });
    }
  }

  Future<void> _reloadData() async {
    await _refreshData(); // Ensure _refreshData is completed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Thông báo',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF4D9194),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(
                Icons.message_sharp,
                color: Colors.white,
              ),
              onPressed: () async {
                await _reloadData();
                setState(() {}); // Refresh the UI
              },
            ),
          ),
        ],
      ),
      body: FutureBuilder<String?>(
        future: _idFuture,
        builder: (context, idSnapshot) {
          if (idSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (idSnapshot.hasError) {
            return Center(child: Text('Error: ${idSnapshot.error}'));
          } else if (!idSnapshot.hasData || idSnapshot.data!.isEmpty) {
            return Center(child: Text('No customer ID found'));
          } else {
            String idCus = idSnapshot.data!;
            _donhangsFuture = fetchDonhangs(idCus); // Initialize the future

            return RefreshIndicator(
              onRefresh: _refreshData,
              child: FutureBuilder<List<Donhang>>(
                future: _donhangsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          NotificationSection(),
                          Text('Chưa có thông tin đơn hàng'),
                        ],
                      ),
                    );
                  } else {
                    List<Donhang> orders = snapshot.data!;
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          NotificationSection(),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: orders.length,
                            itemBuilder: (context, index) {
                              var item = orders[index];
                              return Column(
                                children: [
                                  if (item.daGiao == true)
                                    OrderUpdateTile(context, item, true, false, false, idCus),
                                  if (item.daHuy == true)
                                    OrderUpdateTile(context, item, false, true, false, idCus),
                                  if (item.dangChoXacNhan == true)
                                    OrderUpdateTile(context, item, false, false, true, idCus),
                                ],
                              );
                            },
                          ),
                          SizedBox(height: 100,)
                        ],
                      ),
                    );
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }

  Widget OrderUpdateTile(BuildContext context, Donhang item, bool daGiao, bool daHuy, bool dangcho, String idCus) {
    return GestureDetector(
      onTap: () {
        updateThongBao(item.id!);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetailView(
              dh: item,
              customerName: idCus,
              status: daGiao ? OrderStatus.completed : (daHuy ? OrderStatus.cancel : (dangcho ? OrderStatus.confirm : OrderStatus.cancel)),
            ),
          ),
        );
      },
      child: Column(
        children: [
          if (item.daGiao == true)
            _buildCard(context, item, 'Giao hàng đã giao', idCus, OrderStatus.completed),
          if (item.daHuy == true)
            _buildCard(context, item, 'Giao hàng đã hủy', idCus, OrderStatus.cancel),
          if (item.dangChoXacNhan == true)
            _buildCard(context, item, 'Đang chờ xác nhận', idCus, OrderStatus.confirm),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, Donhang item, String title, String idCus, OrderStatus oder) {
    return GestureDetector(
      onTap: () {
        updateThongBao(item.id!);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetailView(
              dh: item,
              customerName: idCus,
              status: oder,
            ),
          ),
        );
      },
      child: Card(
        color: Color.fromARGB(255, 203, 201, 201),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: ListTile(
          leading: Image.network(
            'https://salt.tikicdn.com/ts/product/3b/91/f4/4f4e795d7be736c9e05529d4ac6ff728.jpg',
            height: 0,   
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: const Text(
            'Đơn hàng của bạn có thông báo mới\nVui lòng xác nhận đơn hàng và đánh giá',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class NotificationSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NotificationTile(
          icon: Icons.local_offer,
          iconColor: Colors.orange,
          title: 'Khuyến mãi',
          subtitle: 'Các mã khuyến mãi hấp dẫn đang chờ bạn!',
        ),
        NotificationTile(
          icon: Icons.access_time,
          iconColor: const Color.fromARGB(255, 233, 212, 15),
          title: 'Khung giờ vàng',
          subtitle: 'Các sản phẩm ưu đãi đang chờ bạn!!!',
        ),
        NotificationTile(
          icon: Icons.card_giftcard,
          iconColor: Colors.lightGreen,
          title: 'Phần thưởng hấp dẫn',
          subtitle: 'Tham gia sự kiện nhận quà liền tay!!!',
        ),
        const SizedBox(
          height: 6,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 16,
            ),
            Text(
              'Cập nhật đơn hàng',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        )
      ],
    );
  }
}

class NotificationTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  NotificationTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade400)),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.2),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 1, 20, 48),
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: () {},
      ),
    );
  }
}
