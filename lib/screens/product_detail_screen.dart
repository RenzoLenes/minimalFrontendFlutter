import 'package:flutter/material.dart';
import 'package:minimal_store/providers/cart_provider.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final discountedPrice = product.priceReal * (1 - product.discount / 100);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del producto (60% de la pantalla)
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: NetworkImage(product.image),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // Nombre del producto
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                product.name,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8.0),

            // Descripción del producto
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                product.description,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // Row para los precios
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Column con los precios
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Precio sin descuento
                      Text(
                        '\$${product.priceReal.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const SizedBox(height: 8.0),

                      // Precio con descuento
                      Text(
                        '\$${discountedPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 220,
                    child: ElevatedButton(
                      onPressed: () {
                        final cartProvider =
                            Provider.of<CartProvider>(context, listen: false);
                        cartProvider.addToCart(product);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(milliseconds: 500),
                            content: Text('${product.name} added to cart!'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // Color rojo
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            // Botón "Add to Cart"
          ],
        ),
      ),
    );
  }
}
