
import 'package:carousel_slider/carousel_slider.dart';
import 'package:doan_cuahangbansach/page/Home/common_widget/best_seller_cell.dart';
import 'package:doan_cuahangbansach/page/Home/common_widget/genres_cell.dart';
import 'package:doan_cuahangbansach/page/Home/common_widget/recently_cell.dart';
import 'package:doan_cuahangbansach/page/Home/common_widget/top_picks_cell.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();

  List topPicksArr = [
    {
      "name": "The Disappearance of Emila Zola",
      "author": "Michael Rosen",
      "img": "assets/images/1.jpg"
    },
    {
      "name": "Fatherhood",
      "author": "Marcus Berkmann",
      "img": "assets/images/2.jpg"
    },
    {
      "name": "The Time Traveller's Handbook",
      "author": "Stride Lottie",
      "img": "assets/images/3.jpg"
    }
  ];

  List bestArr = [
    {
      "name": "Fatherhood",
      "author": "by Christopher Wilson",
      "img": "assets/images/4.jpg",
      "rating": 5.0
    },
    {
      "name": "In A Land Of Paper Gods",
      "author": "by Rebecca Mackenzie",
      "img": "assets/images/5.jpg",
      "rating": 4.0
    },
    {
      "name": "Tattletale",
      "author": "by Sarah J. Noughton",
      "img": "assets/images/6.jpg",
      "rating": 3.0
    }
  ];

  List genresArr = [
    {
      "name": "Graphic Novels",
      "img": "assets/images/g1.png",
    },
    {
      "name": "Graphic Novels",
      "img": "assets/images/g1.png",
    },
    {
      "name": "Graphic Novels",
      "img": "assets/images/g1.png",
    }
  ];

  List recentArr = [
    {
      "name": "The Fatal Tree",
      "author": "by Jake Arnott",
      "img": "assets/images/10.jpg"
    },
    {
      "name": "Day Four",
      "author": "by LOTZ, SARAH",
      "img": "assets/images/11.jpg"
    },
    {
      "name": "Door to Door",
      "author": "by Edward Humes",
      "img": "assets/images/12.jpg"
    }
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Trang chủ",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
       actions: [
          IconButton(
            onPressed: () {
              // Xử lý hành động khi nhấn vào biểu tượng giỏ hàng
            },
            icon: const Icon(Icons.shopping_bag, color: Colors.black),
          ),
          IconButton(
            onPressed: () {
              // Xử lý hành động khi nhấn vào biểu tượng tìm kiếm
            },
            icon: const Icon(Icons.search, color: Colors.black),
          ),
        ],
        
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Align(
                  child: Transform.scale(
                    scale: 1.5,
                    origin: Offset(0, media.width * 0.8),
                    child: Container(
                      width: media.width,
                      height: media.width,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4D9194),
                        borderRadius: BorderRadius.circular(media.width * 0.5),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: media.width * 0.1,
                    ),
                    SizedBox(
                      width: media.width,
                      height: media.width * 0.8,
                      child: CarouselSlider.builder(
                        itemCount: topPicksArr.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) {
                          var iObj = topPicksArr[itemIndex] as Map? ?? {};
                          return TopPicksCell(
                            iObj: iObj,
                          );
                        },
                        options: CarouselOptions(
                          autoPlay: false,
                          aspectRatio: 1,
                          enlargeCenterPage: true,
                          viewportFraction: 0.45,
                          enlargeFactor: 0.4,
                          enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Row(
                        children: [
                          Text(
                            "Bán chạy",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.9,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 8,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: bestArr.length,
                        itemBuilder: (context, index) {
                          var bObj = bestArr[index] as Map? ?? {};

                          return GestureDetector(
                            onTap: () {},
                            child: BestSellerCell(
                              bObj: bObj,
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Row(
                        children: [
                          Text(
                            "Thể loại",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.6,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 8,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: genresArr.length,
                        itemBuilder: (context, index) {
                          var bObj = genresArr[index] as Map? ?? {};

                          return GenresCell(
                            bObj: bObj,
                            bgcolor:
                                index % 2 == 0 ? const Color(0xff1C4A7E) : const Color(0xffC65135),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.1,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Row(
                        children: [
                          Text(
                            "Vừa xem",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.7,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 8,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: recentArr.length,
                        itemBuilder: (context, index) {
                          var bObj = recentArr[index] as Map? ?? {};

                          return RecentlyCell(
                            iObj: bObj,
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.25,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}



