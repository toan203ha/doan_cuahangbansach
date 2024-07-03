import 'package:doan_cuahangbansach/page/Orders/OderSuccess.dart';
import 'package:doan_cuahangbansach/page/conf/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Oder extends StatefulWidget {
  const Oder({super.key});

  @override
  State<Oder> createState() => _OderState();
}

class _OderState extends State<Oder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Đơn hàng',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                  color: Color(0xFF4D9096))),
        ),
        body: Container(
          color: const Color(0xFFE7E7E7),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    InfoUser(),
                    ProductOder(),
                    ProductOder(),
                    ProductOder(),
                    ProductOder()
                  ],
                )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TotalOder(),
              )
            ],
          ),
        ));
  }

  //thông tin người dùng
  // ignore: non_constant_identifier_names
  Widget InfoUser() {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, bottom: 20, top: 20),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(
              color: backgroundColor,
              width: 2,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black, blurRadius: 1, offset: Offset(0, 2))
            ]),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Địa chỉ nhận hàng'),
                Text('Trần Hoài An | (+84) 9xx xxx xxx'),
                Text('828 Sư Vạn Hạnh'),
                Divider(),
                SizedBox(
                  height: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Địa chỉ nhận hàng'),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                      )
                    ])
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget ProductOder() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, left: 16, bottom: 10),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(blurRadius: 2, offset: Offset(0, 2))
                      ]),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, right: 40, left: 20),
                    child: Row(children: [
                      Image.network(
                        'https://th.bing.com/th/id/OIP.8Bvucb7uRIbVBIBQfXOJmAAAAA?rs=1&pid=ImgDetMain',
                        height: 70,
                        width: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.error),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      //thông tin sản phẩm
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tấm lòng cao cả',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: backgroundColor),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.orange, width: 1),
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Padding(
                                    padding: EdgeInsets.all(3),
                                    child: Text(
                                      'Đổi trả 15 ngày',
                                      style: TextStyle(fontSize: 10),
                                    ))),
                            const SizedBox(
                              height: 10,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '163.170',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'số lượng : 1',
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ]),
                  )),
            ),
          )
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget TotalOder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8.0),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Sản phẩm'),
            Text(
              '163.170đ',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Phí giao hàng'),
            Text(
              '30.000đ',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
        const Divider(thickness: 1.0),
        const SizedBox(height: 8.0),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tổng cộng',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(
              '193.170đ',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OderSuccess()));
                },
                style:
                    ElevatedButton.styleFrom(backgroundColor: backgroundColor),
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text('Tiếp tục mua hàng',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15,
                      )),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
