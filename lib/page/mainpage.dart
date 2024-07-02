import 'package:doan_cuahangbansach/page/Customer/CusInfo.dart';
import 'package:doan_cuahangbansach/page/Home/TrangChu.dart';
import 'package:doan_cuahangbansach/page/cart/cart.dart';
import 'package:doan_cuahangbansach/page/conf/const.dart';
import 'package:doan_cuahangbansach/page/product/ThongBao.dart';
import 'package:flutter/material.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({Key? key}) : super(key: key);

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  static const List<Widget> _widgetOptions = <Widget>[
    ThongBao(),
    // Favourite(),
    Homewidget(),
    CartPage(),
    CusInfo(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Chuyển trang với PageController
    _pageController.jumpToPage(
      index,
 
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFE7E7E7),
        child: PageView(
          controller: _pageController,
          children: _widgetOptions,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFFE7E7E7),
        padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 5),
        child: SafeArea(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
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
                        icon = Icons.add_home;
                        label = 'Home';
                        break;
                      case 2:
                        icon = Icons.card_travel_outlined;
                        label = 'Giỏ hàng';
                        break;
                      case 3:
                        icon = Icons.info_sharp;
                        label = 'Thông tin người dùng';
                        break;
                      default:
                        icon = Icons.home;
                        label = 'Home';
                    }
                    return BottomNavigationBarItem(
                      icon: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: _selectedIndex == index
                              ? backgroundColor.withOpacity(0.2)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        
                        child: Icon(
                          icon,
                          size: 25,
                          color: _selectedIndex == index
                              ? backgroundColor
                              : Colors.grey,
                        ),
                      ),
                      label: label,
                    );
                  }),
                  currentIndex: _selectedIndex,
                  selectedItemColor: backgroundColor,
                  unselectedItemColor: Colors.grey,
                  onTap: _onItemTapped,
                ),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                bottom: 0,
                left: _selectedIndex *
                    (MediaQuery.of(context).size.width - 40) /
                    _widgetOptions.length,
                child: Container(
                  width: (MediaQuery.of(context).size.width - 40) /
                      _widgetOptions.length,
                  height: 4,
                  color: backgroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
