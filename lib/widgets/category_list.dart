import 'package:flutter/material.dart';
import 'package:minimal_store/providers/product_provider.dart';
import 'package:provider/provider.dart';
import '../providers/category_provider.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  void initState() {
    super.initState();
    // Cargar las categorías al iniciar el widget
    Future.microtask(() {
      Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final categories = categoryProvider.categories;
    final selectedCategory = categoryProvider.selectedCategory;

    return categoryProvider.isLoading
        ? const Center(child: CircularProgressIndicator())
        : Container(
            height: 100.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategory == category;

                return GestureDetector(
                  onTap: () {
                    // Manejar selección/deselección de la categoría
                    categoryProvider.selectCategory(category);
                    if (categoryProvider.selectedCategory == null) {
                      // Si no hay categoría seleccionada, se buscan todos los productos
                      productProvider.fetchProducts(); // Sin filtro
                    } else {
                      // Si hay categoría seleccionada, se buscan productos por categoría
                      productProvider.searchProducts(
                        '', // No aplicar filtro por nombre
                        category.name, // Filtro por categoría
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: isSelected
                                ? const LinearGradient(
                                    colors: [
                                      Colors.red,
                                      Colors.red,
                                      Colors.orange,
                                      Colors.red,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                : null,
                            border: isSelected
                                ? Border.all(
                                    color: Colors.transparent, width: 0.2)
                                : Border.all(color: Colors.grey, width: 1),
                          ),
                          padding: const EdgeInsets.all(3),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey.shade200,
                            backgroundImage: category.image != null
                                ? NetworkImage(category.image!)
                                : null,
                            child: category.image == null
                                ? const Icon(Icons.category)
                                : null,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          category.name,
                          style: TextStyle(
                            color: isSelected ? Colors.orange : Colors.grey,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }
}
