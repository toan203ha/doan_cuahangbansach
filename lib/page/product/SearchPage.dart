import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<SearchPage> {
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
          color: const Color(0xFFE7E7E7),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SearchList(),
              Padding(
                padding: const EdgeInsets.only(left: 25.0,right: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Gợi ý tìm kiếm',
                      style: TextStyle(
                        color: Color(0xFF1A2857),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Clear search history functionality
                      },
                      child: const Text(
                        'Xóa lịch sử tìm kiếm',
                        style: TextStyle(
                          color: Color(0xFF1A2857),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Expanded(
              //   child: GridView.builder(
              //     padding: EdgeInsets.symmetric(horizontal: 16.0),
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 2,
              //       crossAxisSpacing: 10,
              //       mainAxisSpacing: 10,
              //       childAspectRatio: 0.6,
              //     ),
              //     itemCount: 4, // Change to the number of items you have
              //     itemBuilder: (context, index) {
              //       return CardProduct();
              //     },
              //   ),
              // ),
              Column(
                children: [
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SearchList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SearchListWid(
          title: 'Sách trinh thám',
        ),
        SearchListWid(
          title: 'Sách kinh doanh',
        ),
        SearchListWid(
          title: 'Sách khoa học công nghệ',
        ),
        SearchListWid(
          title: 'Sách thiếu nhi',
        ),
        SizedBox(
          height: 6,
        ),
      ],
    );
  }
}

class SearchListWid extends StatelessWidget {
  final String title;

  const SearchListWid({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade400)),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            color: Color.fromARGB(255, 1, 20, 48),
          ),
        ),
        onTap: () {},
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
