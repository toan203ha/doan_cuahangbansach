import 'dart:ui';
import 'package:doan_cuahangbansach/page/Customer/CusEditInfo.dart';
import 'package:doan_cuahangbansach/page/Customer/Gadget/MyPaymentMethod.dart';
import 'package:doan_cuahangbansach/page/Customer/Gadget/MyVoucher.dart';
import 'package:doan_cuahangbansach/page/Customer/Order/Rate/Rating.dart';
import 'package:doan_cuahangbansach/page/Membership/PageMember.dart';
import 'package:doan_cuahangbansach/page/OrderDetail/mainOrder.dart';
import 'package:flutter/material.dart';

class CusInfo extends StatefulWidget {
  const CusInfo({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CusInfoState createState() => _CusInfoState();
}

class _CusInfoState extends State<CusInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thông tin người dùng"),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Phần ảnh bìa
            Container(
              width: double.infinity,
              height: 220,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(80),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
                image: const DecorationImage(
                  image: AssetImage(
                    'assets/images/background.jpeg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(80),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Container(
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ),
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                          'https://www.dog-on-it-parks.com/blog/wp-content/uploads/2018/06/Sting-300x225.jpg',
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dogbee',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email: dogbee@gmail.com',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                'Số điện thoại: (+84) 9xx xxx xxx',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                'Địa chỉ: 828 Sư Vạn Hạnh...',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 20,
              right: 10,
              child: IconButton(
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: () {
                  // Chuyển đến trang CusEditInfo
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CusEditInfo()),
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 250, 10, 10),
              child: SizedBox(
                height: 200,
                child: Orders(),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 430, 10, 10),
              child: MyGadget(),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 620, 10, 120),
              child: Support(),
            ),
          ],
        ),
      ),
    );
  }
}

//class Orders

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OrdersState createState() => _OrdersState();
}
class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: ShapeDecoration(
            color: const Color(0xFFFAFAFA),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 15,
                offset: Offset(0, 0),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Đơn hàng',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOrderCard(
                    context,
                    assetPath: 'assets/icons/wait.png',
                    title: 'Chờ xác nhận',
                    destinationPage: const MainOrder(),
                  ),
                  _buildOrderCard(
                    context,
                    assetPath: 'assets/icons/box.jpg',
                    title: 'Chờ đóng hàng',
                    destinationPage: const MainOrder(),
                  ),
                  _buildOrderCard(
                    context,
                    assetPath: 'assets/icons/delivery.png',
                    title: 'Chờ giao hàng',
                    destinationPage: const MainOrder(),
                  ),
                  _buildOrderCard(
                    context,
                    assetPath: 'assets/icons/rate.png',
                    title: 'Đánh giá',
                    destinationPage: const Rating(),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ],
    );
  }
Widget _buildOrderCard(BuildContext context,
      {required String assetPath, required String title, required Widget destinationPage}) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 35,
            height: 35,
            child: Image.asset(
              assetPath,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

//class MyGadget

class MyGadget extends StatefulWidget {
  const MyGadget({super.key});

  @override
  State<MyGadget> createState() => _MyGadgetState();
}
class _MyGadgetState extends State<MyGadget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: ShapeDecoration(
            color: const Color(0xFFFAFAFA),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 15,
                offset: Offset(0, 0),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Tiện ích của tôi',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOrderCard(
                    context,
                    assetPath: 'assets/icons/payment.png',
                    title: 'Ví của tôi',
                    destinationPage: const MyPaymentMethod(),
                  ),
                  _buildOrderCard(
                    context,
                    assetPath: 'assets/icons/voucher.png',
                    title: 'Kho Voucher',
                    destinationPage: const MyVoucher(),
                  ),
                  _buildOrderCard(
                    context,
                    assetPath: 'assets/icons/membership.png',
                    title: 'Thẻ thành viên',
                    destinationPage: const PageMember(),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrderCard(BuildContext context,
      {required String assetPath, required String title, required Widget destinationPage}) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: Image.asset(
              assetPath,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

//class Support

class Support extends StatefulWidget {
  const Support({super.key});

  @override
  State<Support> createState() => _SupportState();
}
class _SupportState extends State<Support> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: ShapeDecoration(
            color: const Color(0xFFFAFAFA),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 15,
                offset: Offset(0, 0),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hỗ trợ khách hàng',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  _buildSupportCard(
                    assetPath: 'assets/icons/question.jpg',
                    title: 'Trung tâm trợ giúp khách hàng',
                  ),
                  _buildSupportCard(
                    assetPath: 'assets/icons/support.png',
                    title: 'Yêu cầu tư vấn',
                  ),
                  _buildSupportCard(
                    assetPath: 'assets/icons/report.png',
                    title: 'Báo cáo',
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSupportCard({required String assetPath, required String title}) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            height: 50, // Điều chỉnh chiều cao theo ý của bạn
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: Colors.black.withOpacity(0.5),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    assetPath,
                    width: 30, // Điều chỉnh kích thước hình ảnh nếu cần thiết
                    height: 30,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
