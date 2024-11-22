import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class CategoryService {
  final String baseUrl;

  CategoryService({required this.baseUrl});

  Future<List<Category>> fetchCategories() async {
    final url = Uri.parse('$baseUrl/category');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch categories');
    }
  }
}
