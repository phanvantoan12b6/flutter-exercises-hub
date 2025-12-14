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
      {"id":6,"name":"Áo khoác nữ","price":420000,"image":"https://picsum.photos/seed/p6/500"}
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
    return "${v.toString().replaceAllMapped(RegExp(r"(\d)(?=(\d{3})+(?!\d))"), (m) => "${m[1]}.")}₫";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFf093fb).withOpacity(0.1), Colors.white],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 120,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'Shop Online',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFf093fb), Color(0xFFf5576c)],
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(16),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.7,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final p = products[index];
                    return _ProductCard(
                      product: p,
                      formatVND: formatVND,
                    );
                  },
                  childCount: products.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductCard extends StatefulWidget {
  final Product product;
  final String Function(int) formatVND;

  const _ProductCard({
    required this.product,
    required this.formatVND,
  });

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    widget.product.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () => setState(() => _isFavorite = !_isFavorite),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Icon(
                      _isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: _isFavorite ? Colors.red : Colors.grey,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                  ),
                  Spacer(),
                  Text(
                    widget.formatVND(widget.product.price),
                    style: TextStyle(
                      color: Color(0xFFf5576c),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Đã thêm vào giỏ hàng 🛒"),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFf5576c),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_cart, size: 16),
                          SizedBox(width: 4),
                          Text("Mua", style: TextStyle(fontSize: 13)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
