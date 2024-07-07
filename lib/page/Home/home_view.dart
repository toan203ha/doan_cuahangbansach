import 'package:doan_cuahangbansach/data/model/category.dart';
import 'package:doan_cuahangbansach/data/model/product.dart';
import 'package:doan_cuahangbansach/dbhelper/mongodb.dart';
import 'package:doan_cuahangbansach/page/Home/common_widget/best_seller_cell.dart';
import 'package:doan_cuahangbansach/page/Home/common_widget/genres_cell.dart';
import 'package:doan_cuahangbansach/page/product/TrangTheLoai.dart';
import 'package:doan_cuahangbansach/page/product/carosel.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();

  // khai báo danh sách sản phẩm, danh mục
  List<Product> lstProduct = [];
  List<Product> filteredProducts = [];
  List<CateGorys> loaiSach = [];
  // tim kiem
  bool searchB = false;
  final TextEditingController _searchController = TextEditingController();

  // gọi hàm lấy dữ liệu từ mongodb
  Future<void> fetchProducts() async {
    var fetchedProducts = await MongoDatabase.getProducts();
    setState(() {
      lstProduct = fetchedProducts;
      filteredProducts = fetchedProducts; // Cập nhật danh sách sản phẩm đã lọc
    });
  }

  Future<void> fetchCates() async {
    var fetchedcates = await MongoDatabase.getCategory();
    setState(() {
      loaiSach = fetchedcates;
    });
  }

    @override
    void initState() {
      super.initState();
      fetchProducts();
      fetchCates();
    }

  void filterProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredProducts = lstProduct;
      } else {
        filteredProducts = lstProduct.where((product) {
          return product.name?.toLowerCase().contains(query.toLowerCase()) ??
              false;
        }).toList();
      }
    });
  }

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
                      height: media.width * 0.08,
                    ),

                    //Thanh search

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.7)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF4D9194),
                            ),
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
                    ),
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
                                //chuyển sang trang chi tiết sản phẩm
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => DetailProduct(),
                                //   ),
                                // );
                              },
                            ),
                          );
                        },
                      )
                    else 
                      SizedBox(
                        width: media.width,
                        height: media.width * 0.65,
                        child: ImageCarousel(),
                      ),
                        const SizedBox(height: 20),
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
                            itemCount: filteredProducts.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {},
                                child: BestSellerCell(
                                    filteredProducts[index], context),
                              );
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              const Text(
                                "Thể loại",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                width: 190,
                              ),
                              TextButton(
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
                            itemCount: loaiSach.length,
                            itemBuilder: (context, index) {
                              if (index < 4) {
                                return genres_cell(
                                    loaiSach[index],
                                    context,
                                    index % 2 == 0
                                        ? const Color(0xff1C4A7E)
                                        : const Color(0xffC65135));
                              }
                              return null;
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
                          height: media.width * 0.9,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 8,
                            ),
                            scrollDirection: Axis.horizontal,
                            itemCount: lstProduct.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {},
                                child: BestSellerCell(lstProduct[index], context),
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
