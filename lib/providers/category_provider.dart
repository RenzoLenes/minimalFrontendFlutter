import 'package:flutter/material.dart';
import '../models/category.dart';
import '../services/category_service.dart';

class CategoryProvider with ChangeNotifier {
  final CategoryService categoryService;
  List<Category> _categories = [];
  bool _isLoading = false;
  Category? _selectedCategory; // Categoría actualmente seleccionada

  CategoryProvider({required this.categoryService});

  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;
  Category? get selectedCategory => _selectedCategory;

  /// Carga las categorías desde el servicio
  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();

    try {
      _categories = await categoryService.fetchCategories();
    } catch (error) {
      print('Error fetching categories: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Selecciona una categoría específica
  void selectCategory(Category category) {
    if (_selectedCategory == category) {
      _selectedCategory = null; // Deselecciona si ya estaba seleccionada
    } else {
      _selectedCategory = category; // Selecciona la nueva categoría
    }
    notifyListeners();
  }

  /// Deselecciona cualquier categoría seleccionada
  void clearSelectedCategory() {
    _selectedCategory = null;
    notifyListeners();
  }
}

