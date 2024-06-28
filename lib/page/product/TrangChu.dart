import 'package:doan_cuahangbansach/data/model/product.dart';
import 'package:doan_cuahangbansach/data/provider/data.dart';
import 'package:doan_cuahangbansach/page/product/TrangTheLoai.dart';
import 'package:doan_cuahangbansach/page/product/carosel.dart';
import 'package:doan_cuahangbansach/page/product/itemPro.dart';
import 'package:flutter/material.dart';

class Homewidget extends StatefulWidget {
  // final String categoryID;
  // const Homewidget({super.key, required this.categoryID});
 
  const Homewidget({super.key});
  @override
  State<Homewidget> createState() => _HomewidgetAppState();
}

class _HomewidgetAppState extends State<Homewidget> {
  List<Product> lstProduct = [];
  List<Product> filteredProducts = [];
  List<String> loaiSach = [
    'Tất cả',
    'Tản văn',
    'Trinh thám',
    'Kinh dị',
    'Giả tưởng',
    'Trinh thám',
    'Kinh dị',
    'Giả tưởng',
    'Trinh thám',
    'Kinh dị',
    'Giả tưởng',
    'Siêu nhiên'
  ];

  int x = 0;
  int getLength() {
    if (loaiSach.isNotEmpty) return loaiSach.length;
    return 0;
  }

  final TextEditingController _searchController = TextEditingController();
  bool searchB = false;

  @override
  void initState() {
    super.initState();
    lstProduct = createDataList(10);
    filteredProducts = List.from(lstProduct);
    x = loaiSach.length;
  }

  @override
  Widget build(BuildContext context) {
    List<String> filteredLoaiSach =
        loaiSach.where((category) => category != 'Tất cả').toList();

    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                const SizedBox(height: 16),
                const Text(
                  'KBT',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4D9194),
                  ),
                ),
                // tìm kiếm -----------------------------------------------
                const SizedBox(height: 16),
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.7)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF4D9194),
                      ),
                      // borderRadius: BorderRadius.all(Radius.circular(25.7)),
                      //borderRadius: BorderRadius.circular(25.7),
                    ),
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        _searchProducts();
                      },
                    ),
                    hintText: "Nhập tên sản phẩm...",
                  ),
                  onChanged: (query) {
                    setState(() {
                      filteredProducts = lstProduct
                          .where((product) => product.name!
                              .toLowerCase()
                              .contains(query.toLowerCase()))
                          .toList();
                      searchB = query.isNotEmpty;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ImageCarousel(),

                const SizedBox(height: 20),
                if (searchB)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16.0),
                          // hình ảnh hiển thị
                          // leading: Image.asset(
                          //   'assets/images/${product.img}',
                          //   height: 60,
                          //   width: 60,
                          //   fit: BoxFit.cover,
                          // ),
                          title: Text(
                            product.name ?? '',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Price: \$${product.price}',
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.red)),
                              const SizedBox(height: 4),
                              Text(product.des ?? '',
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.grey)),
                            ],
                          ),
                          onTap: () {
                            // chuyển sang trang chi tiết sản phẩm
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => ProductDetailPage(product: product),
                            //   ),
                            // );
                          },
                        ),
                      );
                    },
                  )
                else
                  Column(
                    children: [
                      const Text(
                        'Thể loại',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4D9194),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filteredLoaiSach.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                          ),
                          itemBuilder: (context, index) {
                            if (index < 5) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFC1D6CF),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 9, 0, 0),
                                  child: Column(
                                    children: <Widget>[
                                      Image.asset(
                                          'assets/carosel/Samsung_A34.png',
                                          height: 90,
                                          // color: Color.fromARGB(255, 15, 147, 59),
                                          opacity: const AlwaysStoppedAnimation<
                                              double>(0.5)),
                                      Text(
                                        filteredLoaiSach[index],
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF4D9194),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else if (index == 5)
                              // ignore: curly_braces_in_flow_control_structures
                              return Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFC1D6CF),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const theloaiWidget(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Xem Thêm',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFF4D9194),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            return null;
                          },
                        ),
                      ),
                      Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '🔥Sale🔥',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF4D9194),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: lstProduct.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.8,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                              ),
                              itemBuilder: (context, index) {
                                return itemGridView(lstProduct[index]);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _searchProducts() {
    if (_searchController.text.isNotEmpty) {
      // ignore: avoid_print
      print('chuyen sang trang thong tin san pham');
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => SearchResultsPage(query: _searchController.text, products: lstProduct),
      //   ),
      // );
    }
  }
}
