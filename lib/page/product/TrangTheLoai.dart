import 'dart:convert';
import 'dart:typed_data';
import 'package:doan_cuahangbansach/data/model/category.dart';
import 'package:doan_cuahangbansach/data/model/product.dart';
import 'package:doan_cuahangbansach/dbhelper/mongodb.dart';
import 'package:doan_cuahangbansach/page/product/detailProductPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class theloaiWidget extends StatefulWidget {
  //String cateId;
  const theloaiWidget({super.key});

  @override
  State<theloaiWidget> createState() => _HomewidgetAppState();
}

class _HomewidgetAppState extends State<theloaiWidget> {
  final TextEditingController _searchController = TextEditingController();
  bool searchB = false;
  List<Product> lstProduct = [];
  List<Product> filteredProducts = [];
  List<CateGorys> loaiSach = [];

  CateGorys? selectedCategory;

  // gọi hàm lấy dữ liệu từ mongodb
  Future<void> fetchProducts() async {
    var fetchedProducts = await MongoDatabase.getProducts();
    setState(() {
      lstProduct = fetchedProducts.cast<Product>();
      filteredProducts = fetchedProducts.cast<Product>();
    });
  }

  Future<void> fetchCates() async {
    var fetchedcates = await MongoDatabase.getCategory();
    setState(() {
      loaiSach = fetchedcates.cast<CateGorys>();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
    fetchCates();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
          icon:const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); 
          },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title:const Center(
            child:  Text(
              'KBT',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4D9194),
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                // Xử lý hành động khi nhấn vào biểu tượng giỏ hàng
              },
            icon: const Icon(Icons.shopping_bag, color: Colors.black),
          ),
        ],
      ),
        body: SingleChildScrollView(
          child: Container(
            color: const Color.fromARGB(255, 255, 255, 255),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
          
                   TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                          filled: true,
                          fillColor:const  Color.fromARGB(255, 184, 219, 221),
                      border: const OutlineInputBorder(
                      ),
                       focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF4D9194),
                        ),
                      ),
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: _searchProducts,
                      ),
                      hintText: "Tìm kiếm...",
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
                            title: Text(
                              product.name ?? '',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Price: ${product.price}',
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.red)),
                                const SizedBox(height: 4),
                                Text(product.des ?? '',
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.grey)),
                              ],
                            ),
                            onTap: () {
                              // Navigate to product detail page
                            },
                          ),
                        );
                      },
                    )
                  else
                    Column(
                      children: [
                        const Row(
                          children: [
                            Text(
                              'Thể loại',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4D9194),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: loaiSach.map((category) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedCategory = category;
                                    filterProductsByCategory(category);
                                  });
                                },
                                child: Container(
                                  width: 100,
                                  height: 35,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: category == selectedCategory
                                          ? Colors.blue
                                          : Colors.transparent,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      category.name ?? '',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF4D9194),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: filteredProducts.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.8,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                            ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          const DetailProduct(),
                                    ),
                                  );
                                },
                                child: itemGridViewTheloai(
                                    filteredProducts[index]),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _searchProducts() {
    if (_searchController.text.isNotEmpty) {
      // Navigate to search results page
    }
  }

  void filterProductsByCategory(CateGorys? category) {
    setState(() {
      if (category == null) {
        filteredProducts = List.from(lstProduct);
      } else {
        filteredProducts = lstProduct
            .where(
                (product) => product.categoryID == category.id?.oid.toString())
            .toList();
      }
    });
  }

  String normalizeBase64(String base64String) {
    while (base64String.length % 4 != 0) {
      base64String += '=';
    }
    return base64String;
  }

  Widget itemGridViewTheloai(Product items) {
    String chuoiBase64 = normalizeBase64(items.img ?? '');
    Uint8List imageBytes = base64Decode(chuoiBase64);
    final formatter = NumberFormat('#,##0', 'en_US');
    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 236, 236, 236),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(
            color: const Color.fromARGB(255, 255, 255, 255), width: 2),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Image.memory(
                  imageBytes,
                  height: 130,
                  errorBuilder: (context, error, stachTrace) =>
                      const Icon(Icons.image),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                child: Column(
                  children: [
                    Text(
                      items.name ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Price: ${formatter.format(items.price)} VND',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
