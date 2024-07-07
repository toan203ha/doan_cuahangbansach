import 'package:doan_cuahangbansach/page/cart/cart.dart';
import 'package:flutter/material.dart';

class DetailProduct extends StatefulWidget {
  const DetailProduct({super.key});

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
        title: const Text(''),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.network(
                        'https://salt.tikicdn.com/ts/product/3b/91/f4/4f4e795d7be736c9e05529d4ac6ff728.jpg',
                        height: 200,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(               
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                          color: const Color(0xFFC1D6CF),
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          const Text(
                            'Công Thức Tự Tin - Để Vươn Tới Sự Tự Lập',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Row(
                                children: [
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
                              const SizedBox(width: 4),
                              const Text('5/5'),
                              const SizedBox(
                                width: 4,
                              ),
                              const Text('(Đã bán 30)'),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              CustomButton(
                                color: const Color.fromARGB(255, 243, 155, 114),
                                icon: Icons.bookmark_outline,
                                text: 'Đổi trả 30 ngày',
                              ),
                              const SizedBox(width: 12),
                              CustomButton(
                                  color: const Color.fromARGB(255, 157, 157, 162),
                                  icon: Icons.check_circle,
                                  text: '100% Chính hãng')
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          const Row(
                            children: [
                              Text(
                                '130.000 VND',
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                '104.000 VND',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 4),
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Số trang',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 250,
                              ),
                              Text('210',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Nhà cung cấp',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 200,
                              ),
                              Text('Nhã Nam',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Tác giả',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 250,
                              ),
                              Text('Tolstoy',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          const Row(
                            children: [
                              Text(
                                'Mô tả',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                            ],
                          ),
                          const Column(
                            children: [
                              Text(
                               'Một đêm vội vã lẩn trốn sau phi vụ khoắng đồ nhà người, Atsuya, Shota và Kouhei đã rẽ vào lánh tạm trong một căn nhà hoang bên con dốc vắng người qua lại. Căn nhà có vẻ khi xưa là một tiệm tạp hóa với biển hiệu cũ kỹ bám đầy bồ hóng, khiến người ta khó lòng đọc được trên đó viết gì. Định bụng nghỉ tạm một đêm rồi sáng hôm sau chuồn sớm, cả ba không ngờ chờ đợi cả bọn sẽ là một đêm không ngủ, với bao điều kỳ bí bắt đầu từ một phong thư bất ngờ gửi đến…')
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          const Row(
                            children: [
                              Text(
                                'Sản phẩm liên quan',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(children: [
                            CardProduct(),
                            const SizedBox(
                              width: 12,
                            ),
                            CardProduct(),
                          ]),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              CardProduct(),
                              const SizedBox(
                                width: 12,
                              ),
                              CardProduct(),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              CardProduct(),
                              const SizedBox(
                                width: 12,
                              ),
                              CardProduct(),
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Add to cart action
             
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                 CartPage(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin =
                                Offset(1.0, 0.0); // Slide từ phải qua trái
                            const end = Offset.zero;
                            const curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ),
                      );
    
                    },
                    label: const Text(
                      'Thêm vào giỏ hàng',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    icon: const Icon(Icons.shopping_cart),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Background color
                      foregroundColor: const Color(0xFF4D9194), // Text color
                      padding: const EdgeInsets.only(top: 19, bottom: 19),
                      //padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      textStyle: const TextStyle(fontSize: 16),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // Make corners square
                      ),
                      side: const BorderSide(color: Color(0xFF4D9194), width: 2),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Buy now action
                  },
                  child: const Text(
                    'Mua ngay',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4D9194),
                    // Background color
                    foregroundColor: Colors.white, // Text color
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 22),
                    textStyle: const TextStyle(fontSize: 16),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // Make corners square
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;

  CustomButton({
    required this.color,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 14),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontSize: 12, color: Colors.white),
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
      decoration: const BoxDecoration(boxShadow: [BoxShadow(offset: Offset(0,0),color: Colors.grey, blurRadius:10)]),
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
                      const Text( 'Công Thức Tự Tin - Để Vươn Tới Sự Tự Lập'),
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
                       Row(
                       
                            children: [
                              Row(
                                
                                children: [
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
                              const SizedBox(width: 50,),
                              const Icon(Icons.card_travel_outlined, color: Color(0xFF4D9194),),
                            ],
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
