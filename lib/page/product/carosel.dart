import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageCarousel extends StatelessWidget {
  final List<String> imgList = [
    'assets/carosel/Samsung_A14.png',
    'assets/carosel/Samsung_A23.png',
    'assets/carosel/Samsung_A34.png',
    'assets/carosel/Samsung_A14.png',
    'assets/carosel/Samsung_A23.png',
    'assets/carosel/Samsung_A34.png',
  ];
 @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
         enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 500),
        viewportFraction: 0.6,
      ),
      items: imgList.map((item) {
        bool isCurrent = imgList.indexOf(item) == 1; // Assuming the center item
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              if (!isCurrent) // Add shadow to non-center items
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset:const Offset(0, 3), // changes position of shadow
                ),
            ],
            border: Border.all(
              color: isCurrent ? Colors.transparent : Colors.green,
              width: 3,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              item,
              fit: BoxFit.cover,
              width: 600,
            ),
          ),
        );
      }).toList(),
    );
  }
}