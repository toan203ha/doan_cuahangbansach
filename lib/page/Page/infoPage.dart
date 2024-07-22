import 'package:doan_cuahangbansach/page/SharePre/srfr.dart';
import 'package:doan_cuahangbansach/page/conf/const.dart';
import 'package:flutter/material.dart';
import 'package:doan_cuahangbansach/page/mainpage.dart'; // Import Mainpage
import 'package:doan_cuahangbansach/page/Login_Register/layoutLogin.dart'; // Import Layoutlogin
 
class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  void initState() {
    super.initState();
     Future.delayed(Duration(seconds: 2), () async {
      bool hasCredentials = await SharedPreferencesHelper.hasUserCredentials();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => hasCredentials ? const Mainpage() : const Layoutlogin(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffC1D6CF),
      body: Padding(
        padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'KBT',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 96,
                color: backgroundColor,
              ),
            ),
            const Text(
              'Nhà sách trực tuyến hàng đầu!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            Expanded(
              child: Center(
                // child: Image.network(
                //   'https://img.freepik.com/premium-vector/woman-reading-book-thinking-good-idea_294791-277.jpg?w=740',
                //   fit: BoxFit.cover,
                // ),
          child: Image.asset('assets/images/background-removebg-preview.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
