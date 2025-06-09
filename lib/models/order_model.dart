class OrderModel {
  int? id;
  int userId;
  int productId;
  int quantity;
  String status;
  String orderDate;
  String address;

  String productName;
  String productImage;
  double price;

  OrderModel({
    this.id,
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.status,
    required this.orderDate,
    required this.address,
    required this.productName,
    required this.productImage,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'product_id': productId,
      'quantity': quantity,
      'status': status,
      'order_date': orderDate,
      'address': address,
    };
  }

  factory OrderModel.fromJoinedMap(Map<String, dynamic> map) {
    String priceString = map['price'].toString().replaceAll(RegExp(r'[^\d.]'), '');

    return OrderModel(
      id: map['id'],
      productName: map['name'],
      productImage: map['image'],
      price: double.tryParse(priceString) ?? 0.0,
      quantity: map['quantity'],
      status: map['status'],
      orderDate: map['order_date'],
      address: map['address'],
      userId: map['user_id'],
      productId: map['product_id'],
    );
  }
}
