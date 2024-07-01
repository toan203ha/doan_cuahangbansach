import 'package:doan_cuahangbansach/page/Home/home_loading.dart';
import 'package:doan_cuahangbansach/page/Page/favourite.dart';
import 'package:doan_cuahangbansach/page/User/layoutLogin.dart';
import 'package:doan_cuahangbansach/page/Home/TrangChu.dart';
import 'package:doan_cuahangbansach/page/cart/cart.dart';
import 'package:doan_cuahangbansach/page/product/ThongBao.dart';
 import 'package:flutter/material.dart';
class Mainpage extends StatefulWidget {
  const Mainpage({Key? key}) : super(key: key);

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int _selectedIndex = 0;
  final _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  static const List<Widget> _widgetOptions = <Widget>[
    ThongBao(),
    Favourite(),
    Homewidget(),
    CartPage(),
    Layoutlogin(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
                color: const Color(0xFFE7E7E7),

        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: List.generate(_widgetOptions.length, (index) {
              IconData icon;
              String label;
              switch (index) {
                case 0:
                  icon = Icons.announcement_sharp;
                  label = 'Thông báo';
                  break;
                case 1:
                  icon = Icons.favorite_sharp;
                  label = 'Yêu thích';
                  break;
                case 2:
                  icon = Icons.add_home;
                  label = 'Home';
                  break;
                case 3:
                  icon = Icons.card_travel_outlined;
                  label = 'Giỏ hàng';
                  break;
                case 4:
                  icon = Icons.info_sharp;
                  label = 'Thông tin người dùng';
                  break;
                default:
                  icon = Icons.home;
                  label = 'Home';
              }
              return BottomNavigationBarItem(
                icon: Container(
                  decoration: BoxDecoration(
                    color: _selectedIndex == index
                        ? const Color.fromARGB(255, 41, 41, 41)
                            .withOpacity(0.2)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Icon(icon),
                ),
                label: label,
              );
            }),
            currentIndex: _selectedIndex,
            selectedItemColor: const Color.fromARGB(255, 63, 63, 64),
            unselectedItemColor: const Color.fromARGB(255, 172, 173, 174),
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
