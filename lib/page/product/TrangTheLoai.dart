import 'package:flutter/material.dart';
import '/data/model/product.dart';
import '/data/provider/data.dart';
import '/page/product/itemPro.dart';

class theloaiWidget extends StatefulWidget {
  const theloaiWidget({super.key});

  @override
  State<theloaiWidget> createState() => _HomewidgetAppState();
}

class _HomewidgetAppState extends State<theloaiWidget> {
  List<Product> lstProduct = [];
  List<Product> filteredProducts = [];
  List<String> loaiSach = [
    'Tất cả', 'Tản văn', 'Trinh thám', 'Kinh dị', 'Giả tưởng', 'Siêu nhiên'
  ];
  String selectedCategory = 'Tất cả';

  final TextEditingController _searchController = TextEditingController();
  bool searchB = false;

  @override
  void initState() {
    super.initState();
    lstProduct = createDataList(10);
    filteredProducts = List.from(lstProduct);
  }

  @override
  Widget build(BuildContext context) {
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
                const SizedBox(height: 16),
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.7)),
                    ),
                    fillColor: const Color(0xFF4D9194),
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
                                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: category == selectedCategory
                                          ? Colors.blue
                                          : Colors.transparent),
                                ),
                                child: Center(
                                  child: Text(
                                    category,
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
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                          ),
                          itemBuilder: (context, index) {
                            return itemGridView(filteredProducts[index]);
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
    if (_searchController.text.isNotEmpty) {
      // Navigate to search results page
    }
  }

void filterProductsByCategory(String category) {
  if (category == 'Tất cả') {
    filteredProducts = List.from(lstProduct);
  } else {
    // Ánh xạ tên thể loại sang ID
    int categoryID = categoryToId(category);

    filteredProducts = lstProduct
        .where((product) => product.categoryID == categoryID)
        .toList();
  }
}
// Hàm ánh xạ tên thể loại sang ID
int categoryToId(String category) {
  Map<String, int> categoryMap = {
    'Tất cả': 0,
    'Tản văn': 1,
    'Trinh thám': 2,
    'Kinh dị': 3,
    'Giả tưởng': 4,
    'Siêu nhiên': 5,
  };
  return categoryMap[category] ?? 0;
}
}
