import 'package:doan_cuahangbansach/page/Oder/Oder.dart';
import 'package:doan_cuahangbansach/page/conf/const.dart';
import 'package:doan_cuahangbansach/page/product/detailProductPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Giỏ hàng',
            style: titleStyle,
          ),
          backgroundColor: const Color(0xFFE7E7E7),
        ),
        body: Container(
          color: const Color(0xFFE7E7E7),
          child: Column(children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(alignment: Alignment.topRight, children: [
                      const Positioned(
                          top: 5,
                          right: 3,
                          child: Icon(
                            Icons.delete,
                            size: 30,
                          )),
                      Product(context)
                    ]),
                    Product(context),
                    Product(context),
                    Product(context),
                  ],
                ),
              ),
            ),
            BottonNav()
          ]),
        ));
  }

  // sản phẩm
  // ignore: non_constant_identifier_names
  Widget Product(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const DetailProduct(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0); // Slide từ phải qua trái
              const end = Offset.zero;
              const curve = Curves.easeInCubic;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
            //  transitionDuration: Duration(seconds: 1),
            reverseTransitionDuration: Duration(seconds: 1),
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Radio(value: false, groupValue: null, onChanged: null),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Image.network(
                        height: 100,
                        width: 63,
                        'https://th.bing.com/th/id/OIP.8Bvucb7uRIbVBIBQfXOJmAAAAA?rs=1&pid=ImgDetMain',
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      //thông tin sản phẩm
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Tấm lòng cao cả',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
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
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  '163.170',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 80,
                                ),
                                //thêm sản phẩn
                                Row(
                                  children: [
                                    CircleAvatar(
                                      maxRadius: 15,
                                      backgroundColor: backgroundColor,
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.remove,
                                          size: 15,
                                        ),
                                        onPressed: () {},
                                        color:
                                            Colors.white, // Màu của biểu tượng
                                      ),
                                    ),
                                    const SizedBox(
                                        width:
                                            10), // Khoảng cách giữa các nút và số đếm
                                    const Text(
                                      '1',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(width: 10),
                                    // Nút cộng
                                    CircleAvatar(
                                      maxRadius: 15,
                                      backgroundColor: backgroundColor,
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.add,
                                          size: 15,
                                        ),
                                        onPressed: () {},
                                        color:
                                            Colors.white, // Màu của biểu tượng
                                      ),
                                    ),
                                  ],
                                )
                              ])
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

///////////

// ignore: non_constant_identifier_names
  Widget BottonNav() {
    return Column(children: [
      Container(
        color: backgroundColor,
        height: 60,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.local_offer, color: Colors.black),
                  SizedBox(width: 8.0),
                  Text('Mã giảm giá'),
                ],
              ),
              Text('chọn mã giảm giá')
            ],
          ),
        ),
      ),
      Container(
        color: textColor,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Radio(value: false, groupValue: null, onChanged: null),
                  Text(
                    'chọn tất cả',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const Text(
                '163.170',
                style: TextStyle(
                    color: Colors.white, // Text color
                    fontWeight: FontWeight.bold,
                    fontSize: 30 // Bold text
                    ),
              ),
              Builder(
                  builder: (context) => ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Oder()),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Đặt hàng',
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0), // Text color
                              fontWeight: FontWeight.bold, // Bold text
                            ),
                          ),
                        ),
                      ))
            ],
          ),
        ),
      ),
    ]);
  }
}
