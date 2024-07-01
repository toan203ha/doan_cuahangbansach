import 'package:flutter/material.dart';

class Productpage extends StatefulWidget {
  const Productpage({super.key});
  @override
  State<Productpage> createState() => _ProductpageState();
}

class _ProductpageState extends State<Productpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomSearchBar(),
          ),
          backgroundColor: const Color(0xFF4D9194),
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 240, 240, 243),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  FlashSaleSection(),
                  const SizedBox(
                    height: 8,
                  ),
                  const DropdownMenuExample(),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CardProduct(),
                  CardProduct(),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CardProduct(),
                  CardProduct(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: const Color(0xFF7EAEB4),
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(color: const Color(0xFF24242E)),
      ),
      child: const Row(
        children: [
          Icon(Icons.search, color: Colors.black),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Tìm kiếm...',
                hintStyle: TextStyle(color: Colors.black),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FlashSaleSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
              side: const BorderSide(color: Color(0xFF4D9194)),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Flash Sale kết thúc trong',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFD233),
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Xem tất cả',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_outlined),
                ],
              ),
              Row(
                children: [
                  FlashSaleItem(),
                  FlashSaleItem(),
                  FlashSaleItem(),
                ],
              ),
            ])));
  }
}

class FlashSaleItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 134,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(color: Color.fromARGB(255, 127, 129, 129)),
        ),
        child: Stack(
          children: [
            Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10.0)),
                  child: Image.network(
                    'https://salt.tikicdn.com/ts/product/3b/91/f4/4f4e795d7be736c9e05529d4ac6ff728.jpg',
                    height: 130,
                    width: double.infinity,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(height: 4),
                      Text(
                        '130.000 đ',
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                            fontSize: 12),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '104.000 đ',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 4),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF0000),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.flash_on_outlined,
                      color: Colors.white,
                      size: 16,
                    ),
                    Text(
                      '-50%',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

const List<String> list = <String>[
  'Bán chạy tuần',
  'Bán chạy tháng',
  'Bán chạy ngày'
];

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String dropdownValue = 'Bán chạy tuần';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 25.0),
          child: Text(
            'Sắp xếp:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.white,
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          child: PopupMenuButton<String>(
            onSelected: (String value) {
              setState(() {
                dropdownValue = value;
              });
            },
            itemBuilder: (BuildContext context) {
              return <String>[
                'Bán chạy tuần',
                'Bán chạy tháng',
                'Bán chạy ngày'
              ].map<PopupMenuItem<String>>((String value) {
                return PopupMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList();
            },
            child: Row(
              children: <Widget>[
                Text(
                  dropdownValue,
                  style: const TextStyle(color: Colors.black),
                ),
                const Icon(Icons.keyboard_arrow_down_outlined),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CardProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(color: Color(0xFF4D9194)),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10.0)),
                  child: Image.network(
                    'https://salt.tikicdn.com/ts/product/3b/91/f4/4f4e795d7be736c9e05529d4ac6ff728.jpg',
                    height: 150,
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      const Text('Công thức Tự Tin - Để Vươn Tới Sự Tư Lập'),
                      const SizedBox(height: 4),
                      const Text(
                        '130.000 VND',
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '104.000 VND',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: List.generate(
                          5,
                          (index) => const Icon(
                            Icons.star,
                            size: 14,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF4D9194),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '-20%',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
