import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../screens/payment_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        // Botón para retroceder
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Regresar a la pantalla anterior
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index) {
                final product = cartProvider.cartItems[index];
                final double discountedPrice =
                    product.priceReal * (1 - product.discount / 100);

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Imagen del producto
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  product.image,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              if (product.discount > 0)
                                Positioned(
                                  top: 5,
                                  left: 5,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 4.0),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Text(
                                      '${product.discount.toStringAsFixed(0)}%',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(width: 12.0),
                          // Detalles del producto
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6.0, vertical: 2.0),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  child: const Text(
                                    'Best price',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Row(
                                  children: [
                                    if (product.discount > 0)
                                      Text(
                                        '\$${product.priceReal.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.grey,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                    const SizedBox(width: 6.0),
                                    Text(
                                      '\$${discountedPrice.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  cartProvider.increaseQuantity(product);
                                },
                                icon: const Icon(Icons.add_circle_outline),
                              ),
                              Text(
                                '${cartProvider.getQuantity(product)}',
                                style: const TextStyle(fontSize: 16.0),
                              ),
                              IconButton(
                                onPressed: () {
                                  cartProvider.decreaseQuantity(product);
                                },
                                icon: const Icon(Icons.remove_circle_outline),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Total y botón de checkout
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Total: \$${cartProvider.totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PaymentScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: const Text(
                    'Go to Checkout',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
