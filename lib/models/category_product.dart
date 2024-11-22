class CategoryProduct {
  final int categoryId;
  final int productId;

  CategoryProduct({required this.categoryId, required this.productId});

  factory CategoryProduct.fromJson(Map<String, dynamic> json) {
    return CategoryProduct(
      categoryId: json['id']['categoryId'],
      productId: json['id']['productId'],
    );
  }
}
