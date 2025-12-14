import 'dart:convert';
import 'package:flutter/material.dart';

class Product {
  final int id;
  final String name;
  final int price;
  final String image;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });
}

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  void loadProducts() async {
    const jsonData = '''
    [
      {"id":1,"name":"Áo thun nam Basic","price":99000,"image":"https://picsum.photos/seed/p1/500"},
      {"id":2,"name":"Giày thể thao Ultra","price":450000,"image":"https://picsum.photos/seed/p2/500"},
      {"id":3,"name":"Tai nghe Bluetooth","price":350000,"image":"https://picsum.photos/seed/p3/500"},
      {"id":4,"name":"Balo du lịch 20L","price":230000,"image":"https://picsum.photos/seed/p4/500"},
      {"id":5,"name":"Đồng hồ thời trang","price":520000,"image":"https://picsum.photos/seed/p5/500"},
      {"id":6,"name":"Áo khoác nữ mùa đông","price":420000,"image":"https://picsum.photos/seed/p6/500"}
    ]
    ''';

    final List list = json.decode(jsonData);
    setState(() {
      products = list
          .map((e) => Product(
              id: e['id'],
              name: e['name'],
              price: e['price'],
              image: e['image']))
          .toList();
    });
  }

  String formatVND(int v) {
    return "${v.toString().replaceAllMapped(RegExp(r"(\d)(?=(\d{3})+(?!\d))"), (m) => "${m[1]}.")} ₫";
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    int columnCount = width < 360 ? 1 : 2;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2F53D8),
        title: const Text(
          "Danh sách sản phẩm",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columnCount,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) {
            final p = products[index];

            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(
                        p.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          formatVND(p.price),
                          style: const TextStyle(
                            color: Color(0xFF2F53D8),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2F53D8),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            icon: const Icon(Icons.shopping_cart,
                                color: Colors.white),
                            label: const Text("Mua ngay",
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        "Đã thêm '${p.name}' vào giỏ hàng")),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
