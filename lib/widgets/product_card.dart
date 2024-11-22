import 'package:flutter/material.dart';
import '../models/product.dart';

// Listado de productos de ejemplo

// Pantalla principal que muestra los productos

// Widget para mostrar cada producto en el listado
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final discountedPrice = product.priceReal * (1 - product.discount);

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
                child: Container(
                  color: Colors.white,
                  child: Image.network(
                    product.image,
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: double.infinity,
                    fit: BoxFit.contain,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child; // Si ya terminó de cargar, muestra la imagen
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      }
                    },
                    errorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) {
                      return Image.network(
                          'https://st4.depositphotos.com/14953852/24787/v/450/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg'); // En caso de error, muestra un ícono de error
                    },
                  ),
                ),
              ),
              // Etiqueta de descuento
              if (product.discount > 0)
                Positioned(
                  top: 8.0,
                  right: 8.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      '${product.discount * 100}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '\$${discountedPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (product.discount > 0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '\$${product.priceReal.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ),
          const SizedBox(height: 4.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              product.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14.0),
            ),
          ),
        ],
      ),
    );
  }
}
