import 'package:flutter/material.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  final Map<Product, int> _cartItems = {};

  // Getter para obtener los productos del carrito
  List<Product> get cartItems => _cartItems.keys.toList();

  // Precio total del carrito
  double get totalPrice {
    return _cartItems.entries.fold(
      0.0,
      (sum, entry) => sum +
          (entry.key.priceReal * (1 - entry.key.discount / 100) * entry.value),
    );
  }

  // Agregar un producto al carrito
  void addToCart(Product product) {
    if (_cartItems.containsKey(product)) {
      _cartItems[product] = _cartItems[product]! + 1;
    } else {
      _cartItems[product] = 1;
    }
    notifyListeners();
  }

  // Incrementar la cantidad de un producto
  void increaseQuantity(Product product) {
    if (_cartItems.containsKey(product)) {
      _cartItems[product] = _cartItems[product]! + 1;
      notifyListeners();
    }
  }

  // Reducir la cantidad de un producto
  void decreaseQuantity(Product product) {
    if (_cartItems.containsKey(product) && _cartItems[product]! > 1) {
      _cartItems[product] = _cartItems[product]! - 1;
    } else if (_cartItems.containsKey(product) && _cartItems[product]! == 1) {
      _cartItems.remove(product);
    }
    notifyListeners();
  }

  // Eliminar un producto completamente del carrito
  void removeFromCart(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  // Vaciar el carrito
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  // Obtener la cantidad de un producto específico
  int getQuantity(Product product) {
    return _cartItems[product] ?? 0;
  }
}
