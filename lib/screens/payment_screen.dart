import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Acceso al CartProvider
    final cartProvider = Provider.of<CartProvider>(context);

    // Datos del cliente (puedes modificar estos datos según el cliente)
    final String cardHolderName = "John Doe";
    final String cardNumber = "**** **** **** 1234";
    final String expiryDate = "12/25";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Mostrar la tarjeta de crédito
            Container(
              height: 200,
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(209, 0, 0, 0),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10.0,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Nombre del titular
                        Text(
                          cardHolderName,
                          style: const TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        // Número de la tarjeta
                        Text(
                          cardNumber,
                          style: const TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Mastercard-logo.svg/2560px-Mastercard-logo.svg.png',
                            width: 55,
                          ),
                        ),
                        Text(
                          expiryDate,
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  ]),
            ),
            const SizedBox(height: 20.0),

            const Text(
              'Choose Payment Method',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),

            // Métodos de pago
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.apple, size: 40),
                  onPressed: () {
                    // Acción para Apple Pay
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.credit_card, size: 40),
                  onPressed: () {
                    // Acción para tarjeta de crédito
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.payment, size: 40),
                  onPressed: () {
                    // Acción para otros métodos de pago
                  },
                ),
              ],
            ),
            const Spacer(),

            // Mostrar el precio total dinámico
            Text(
              'Total: \$${cartProvider.totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Lógica para procesar el pago
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Payment processing...')),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: const Text(
                'Make Payment',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
