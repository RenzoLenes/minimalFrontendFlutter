import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class CategoryProductService {
  final String baseUrl;

  CategoryProductService({required this.baseUrl});

  Future<List<CategoryProduct>> fetchCategoryProducts() async {
    final url = Uri.parse('$baseUrl/categoryproduct');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => CategoryProduct.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch category products');
    }
  }
}
