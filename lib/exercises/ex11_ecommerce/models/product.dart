class ProductEcom {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;

  ProductEcom({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
  });

  factory ProductEcom.fromJson(Map<String, dynamic> json) {
    return ProductEcom(
      id: json['id'],
      name: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
    );
  }
}
