import 'package:flutter/material.dart';

import 'package:minimal_store/widgets/widgets.dart';

import 'screens.dart';

import 'package:provider/provider.dart';

import '../providers/product_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Cargar los productos automáticamente cuando la pantalla se carga
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    productProvider.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const SearchBarHome()),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15),
            CategoryList(),
            ProductListScreen(),
          ],
        ),
      ),
    );
  }
}
