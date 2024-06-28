// ignore: file_names
import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  var stock = 100.0;
  var pro = 80.0;

void _onItemTapped() {
  setState(() {
    if (pro > 10) {
      pro -= 10;
    }
  }
  );
}
  @override
  Widget build(BuildContext context) {
return Scaffold(
    body: Column(
      children: [
        Row(
          children: [
            RotatedBox(
              quarterTurns: 2,
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0),
                      ),
                    ),
                    height: stock,
                    width: 10,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 0, 183, 255),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0),
                      ),
                    ),
                    height: pro,
                    width: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );  }
}