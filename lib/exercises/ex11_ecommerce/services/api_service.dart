import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com/products';

  static Future<List<ProductEcom>> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((json) => ProductEcom.fromJson(json)).toList();
    } else {
      throw Exception('Không thể tải dữ liệu sản phẩm');
    }
  }
}
