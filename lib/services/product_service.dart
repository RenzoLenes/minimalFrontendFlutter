import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class ProductService {
  final String baseUrl;

  ProductService({required this.baseUrl});

  Future<List<Product>> fetchProducts() async {
    final url = Uri.parse('$baseUrl/product');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  Future<List<Product>> fetchProductsByCategory(String category) async {
    final encodedCategory = Uri.encodeComponent(category);
    final url =
        Uri.parse('$baseUrl/product/findByCategory?category=$encodedCategory');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((data) => Product.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load products by category');
    }
  }

  Future<List<Product>> searchProducts(String name, String category) async {
    // Crear la URL con los parámetros de búsqueda
    String url = '$baseUrl/product/searchByNameCategory?name=$name';

    if (category.isNotEmpty) {
      url += '&category=${Uri.encodeComponent(category)}';
    } else {
      url += '&category=';
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search products');
    }
  }
}
