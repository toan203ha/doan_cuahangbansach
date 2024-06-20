import 'package:flutter/material.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  @override
  _BottomNavigationBarScreenState createState() => _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom Navigation Bar'),
      ),
      body: _selectedIndex == 0
          ? Screen1(onGoToScreen2: () {
              setState(() {
                _selectedIndex = 1;
              });
            })
          : _selectedIndex == 1
              ? Screen2(onGoToScreen2: () {  },)
              : _selectedIndex == 2
                  ? Screen2(onGoToScreen2: () {  },)
                  : Screen2(onGoToScreen2: () {  },),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
                 selectedItemColor: const Color.fromARGB(255, 63, 63, 64),
                unselectedItemColor: const Color.fromARGB(255, 172, 173, 174),
                onTap: _onItemTapped,
         items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Item 1'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Item 2'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Item 3'),
          BottomNavigationBarItem(icon: Icon(Icons.help), label: 'Item 4'),
        ],
      ),
    );
  }
}

class Screen1 extends StatelessWidget {
  final VoidCallback onGoToScreen2;

  Screen1({required this.onGoToScreen2});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text('Go to Screen 2'),
        onPressed: onGoToScreen2,
      ),
    );
  }
}
 

class Screen2 extends StatelessWidget {
  final VoidCallback onGoToScreen2;

  Screen2({required this.onGoToScreen2});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text('Go to Screen 2'),
        onPressed: onGoToScreen2,
      ),
    );
  }
} 