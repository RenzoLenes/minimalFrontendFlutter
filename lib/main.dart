import 'package:flutter/material.dart';
import 'package:minimal_store/providers/cart_provider.dart';
import 'package:minimal_store/providers/category_provider.dart';
import 'package:minimal_store/providers/product_provider.dart';
import 'package:minimal_store/screens/cart_screen.dart';
import 'package:minimal_store/services/product_service.dart';
import 'package:provider/provider.dart';

import 'screens/screens.dart';
import 'services/category_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductProvider(
            productService: ProductService(
                baseUrl: 'http://taytabackend.eastus2.cloudapp.azure.com:8082'),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryProvider(
            categoryService: CategoryService(
                baseUrl: 'http://taytabackend.eastus2.cloudapp.azure.com:8082'),
          ),
        ),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Minimal Store',
        initialRoute: 'home',
        routes: {
          'home': (_) => const HomeScreen(),
          'cart': (_) => const CartScreen(),
        },
      ),
    );
  }
}
