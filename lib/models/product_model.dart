class ProductModel {
  final int? id;
  final String name;
  final String price;
  final String description;
  final String image;
  final String category;

  ProductModel({
    this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'image': image,
      'category': category,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      description: map['description'],
      image: map['image'],
      category: map['category'],
    );
  }
}