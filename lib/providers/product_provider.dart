import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';

class ProductProvider with ChangeNotifier {
  final ProductService productService;
  List<Product> _products = [];
  bool _isLoading = false;

  ProductProvider({required this.productService});

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> fetchProducts() async {
    _isLoading = true;
    // Usamos addPostFrameCallback para retrasar el notifyListeners
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    try {
      _products = await productService.fetchProducts();
    } catch (error) {
      print('Error fetching products: $error');
    } finally {
      _isLoading = false;
      // Usamos addPostFrameCallback para retrasar el notifyListeners
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  Future<void> fetchProductsByCategory(String category) async {
    _isLoading = true;
    // Usamos addPostFrameCallback para retrasar el notifyListeners
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    try {
      _products = await productService.fetchProductsByCategory(category);
    } catch (error) {
      print('Error fetching products by category: $error');
    } finally {
      _isLoading = false;
      // Usamos addPostFrameCallback para retrasar el notifyListeners
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  // Realizar la búsqueda de productos
  Future<void> searchProducts(String name, String category) async {
    try {
      final products = await productService.searchProducts(name, category);
      _products = products;
      // Usamos addPostFrameCallback para retrasar el notifyListeners
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    } catch (error) {
      print('Error searching products: $error');
    }
  }
}
