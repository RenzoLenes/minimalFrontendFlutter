// product.dart
class Product {
  final int id;
  final String name;
  final double priceReal;
  final double discount;
  final String description;
  final String image;

  Product({
    required this.id,
    required this.name,
    required this.priceReal,
    required this.discount,
    required this.description,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['product_id'],
      name: json['name'],
      priceReal: json['priceReal'],
      discount: json['discount'],
      description: json['description'],
      image: json['image'],
    );
  }
}
