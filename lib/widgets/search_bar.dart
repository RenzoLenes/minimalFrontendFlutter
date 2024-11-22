import 'package:flutter/material.dart';
import 'package:minimal_store/providers/category_provider.dart';
import 'package:minimal_store/providers/product_provider.dart';
import 'package:provider/provider.dart';

class SearchBarHome extends StatelessWidget {
  const SearchBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController =
        TextEditingController(); // Controlador para el texto de búsqueda

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search products...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onChanged: (value) {
                  // Cuando cambia el texto, se busca automáticamente
                  final productProvider =
                      Provider.of<ProductProvider>(context, listen: false);
                  final categoryProvider =
                      Provider.of<CategoryProvider>(context, listen: false);
                  // Llama al método de búsqueda, pasando el texto y la categoría actual
                  productProvider.searchProducts(
                      value, categoryProvider.selectedCategory?.name ?? '');
                },
              ),
            ),
            const SizedBox(width: 8.0), // Espaciado entre el campo y el botón
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8.0), // Bordes redondeados
                ),
              ),
              onPressed: () {
                // Quitar filtros de productos y deseleccionar categoría
                final productProvider =
                    Provider.of<ProductProvider>(context, listen: false);
                final categoryProvider =
                    Provider.of<CategoryProvider>(context, listen: false);

                productProvider.fetchProducts(); // Sin filtros
                categoryProvider
                    .clearSelectedCategory(); // Deselecciona categoría
                searchController.clear(); // Limpiar la barra de búsqueda
              },
              child: const Icon(
                Icons.filter_list,
                size: 35,
                color: Colors.white,
              ), // Ícono de filtro
            ),
            const SizedBox(
                width: 8.0), // Espaciado entre el botón de filtro y el carrito
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8.0), // Bordes redondeados
                ),
              ),
              onPressed: () {
                // Navegar a la pantalla del carrito
                Navigator.pushNamed(
                    context, 'cart'); // Asegúrate de tener esta ruta en tu app
              },
              child: const Icon(
                Icons.shopping_cart,
                size: 35,
                color: Colors.white,
              ), // Ícono de carrito
            ),
          ],
        ),
      ),
    );
  }
}
