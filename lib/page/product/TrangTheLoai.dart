import 'dart:convert';
import 'dart:typed_data';
import 'package:doan_cuahangbansach/data/model/category.dart';
import 'package:doan_cuahangbansach/data/model/product.dart';
import 'package:doan_cuahangbansach/page/SharePre/srfr.dart';
import 'package:doan_cuahangbansach/page/cart/cart.dart';
import 'package:doan_cuahangbansach/page/cart/cartcounter.dart';
import 'package:doan_cuahangbansach/page/conf/const.dart';
import 'package:doan_cuahangbansach/page/product/SearchPage.dart';
import 'package:doan_cuahangbansach/page/product/detailProductPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class theloaiWidget extends StatefulWidget {
  const theloaiWidget({super.key});

  @override
  State<theloaiWidget> createState() => _TheLoaiWidgetState();
}

class _TheLoaiWidgetState extends State<theloaiWidget> {
  //final TextEditingController _searchController = TextEditingController();
  bool searchB = false;
  List<Product> lstProduct = [];
  List<Product> filteredProducts = [];
  CateGorys? selectedCategory;

  // API URI
  final String uri = 'http://172.18.48.1:3000';

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<List<CateGorys>> fetchCategories() async {
    final url = Uri.parse('$uri/api/categories');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        List<CateGorys> categories =
            jsonList.map((json) => CateGorys.fromJson(json)).toList();
        return categories;
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  Future<void> loadProducts() async {
    try {
      List<Product> products = await fetchProducts();
      setState(() {
        lstProduct = products;
        filteredProducts = products; // Set initial state for filtered products
      });
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  Future<List<Product>> fetchProducts() async {
    final url = Uri.parse('$uri/api/products');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        List<Product> pros =
            jsonList.map((json) => Product.fromJson(json)).toList();
        return pros;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  void filterProductsByCategory(CateGorys? category) {
    setState(() {
      selectedCategory = category;
      if (category == null) {
        // If no category is selected, show all products
        filteredProducts = List.from(lstProduct);
      } else {
        filteredProducts = lstProduct
            .where((product) => product.categoryID == category.id?.toString())
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
// API URI
 
  

  Future<String?> getUserId() async {
    return await SharedPreferencesHelper.getId();
  }
Future<void> addCart(String idPro, String idCus, int count, int price) async {
  final String apiUrl = 'http://172.18.48.1:3000/api/cart';
  Map<String, dynamic> user = {
    'idPro': idPro.trim(),
    'idCus': idCus.trim(),
    'giaSP': price,
    'soLuong': count,
  };

  try {
    print('Thông tin: ${jsonEncode(user)}');  
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user),
    );

    print('Response: ${response.statusCode}');  
    print('Response body: ${response.body}');  

    if (response.statusCode == 201) {
      print('Giỏ hàng thêm thành công');
    } else {
      print('Thêm giỏ hàng thất bại: ${response.body}');
    }
  } catch (e) {
    print('Error adding to cart: $e');
  }
}

  Widget itemGridViewTheloai(Product items) {
    String chuoiBase64 = normalizeBase64(items.img ?? '');
    Uint8List imageBytes = base64Decode(chuoiBase64);
    final formatter = NumberFormat('#,##0', 'en_US');
    
    return FutureBuilder<String?>(
      future: getUserId(),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('Không tìm thấy id'));
        } else {
          String idCus = snapshot.data!;
    
          return Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 236, 236, 236),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              border: Border.all(
                  color: const Color.fromARGB(255, 255, 255, 255), width: 2),
            ),
            child: Column(
     
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Image.memory(
                    imageBytes,
                    height: 110,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.image),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 9.0,top: 10),
                  child: Column(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        items.name ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            formatter.format(items.price ?? 0),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.red,
                            ),
                          ),
                          IconButton(
                                            icon: const Icon(Icons.add_shopping_cart, size: 20),
                                            onPressed: () {
                          if (items.soLuongTon == 0) {
                            showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.black.withOpacity(0.3),
                                  content: Opacity(
                                    opacity: 1,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextButton(
                                          child: const Text(
                                            'Sản phẩm đã hết hàng',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            addCart(items.id!, idCus, 1, items.price!);
                            // Cập nhật số lượng giỏ hàng
                            Provider.of<CartItemCountProvider>(context, listen: false)
                                .updateItemCountDetail();
                            showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.black.withOpacity(0.3),
                                  content: Opacity(
                                    opacity: 1,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextButton(
                                          child: const Text(
                                            'Đã thêm vào giỏ hàng',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                                            },
                                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
              ],
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Center(
          child: Text(
            'KBT',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4D9194),
            ),
          ),
        ),
        actions: [
          Consumer<CartItemCountProvider>(
            builder: (context, cartProvider, child) {
              int itemCount = cartProvider.itemCount;
              return Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartPage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.shopping_bag,
                        color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  if (itemCount > 0)
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      child: Text(
                        itemCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              );
            },
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
                

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                          MaterialPageRoute(
                            builder: (context) => const SearchPage(),
                          ),
                        );
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: IgnorePointer(
                          child: TextField(
                   decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 184, 219, 221),
                    border: const OutlineInputBorder(),
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
                ),
                        ),
                      ),
                    ),

                const SizedBox(height: 20),
                 
                 
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
                        child: FutureBuilder<List<CateGorys>>(
                          future: fetchCategories(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return Center(
                                  child: Text('No categories available'));
                            } else {
                              return ListView(
                                scrollDirection: Axis.horizontal,
                                children: snapshot.data!.map((category) {
                                  bool isSelected =
                                      selectedCategory?.id == category.id;
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        filterProductsByCategory(category);
                                      });
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 35,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10),
                                        border: Border.all(
                                          color: isSelected
                                              ? backgroundColor
                                              : Colors.transparent,
                                          width: 2,
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
                              );
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filteredProducts.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                          ),
                          itemBuilder: (context, index) {
                            final itemPro = filteredProducts[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailProduct(product: itemPro)),
                                );
                              },
                              child: itemGridViewTheloai(itemPro),
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
    );
  }

  void _searchProducts() {
    // if (_searchController.text.isNotEmpty) {
    //   // Navigate to search results page
    // }
  }
}
