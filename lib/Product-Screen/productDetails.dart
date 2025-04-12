// ProductDetail.dart

import 'package:Hisabi/Product-Screen/buyNow.dart';
import 'package:Hisabi/Product-Screen/cartScreen.dart';
import 'package:Hisabi/db/db_helper.dart';
import 'package:Hisabi/models/order_model.dart';
import 'package:Hisabi/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductDetail extends StatefulWidget {
  final int? productId;

  const ProductDetail({super.key, required this.productId});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  ProductModel? product;

  @override
  void initState() {
    super.initState();
    loadProduct();
  }

  // Load product details from the database
  Future<void> loadProduct() async {
    final fetchedProduct =
        await DatabaseHelper().getProductById(widget.productId!);
    if (fetchedProduct != null) {
      setState(() => product = fetchedProduct);
    } else {
      debugPrint("❌ Product not found with ID: ${widget.productId}");
    }
  }

  // Add the product to the cart
  Future<void> addToCart() async {
    if (product == null) return;

    final currentUser = await DatabaseHelper().getCurrentUser();
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User not found. Please log in again.")),
      );
      return;
    }

    final order = OrderModel(
      id: 0,
      // You can auto-generate this ID in the database or let SQLite handle it
      productName: product!.name,
      productImage: product!.image,
      price: double.parse(product!.price.replaceAll(RegExp(r'[^\d.]'), '')),
      quantity: 1,
      status: 'In Cart',
      orderDate: DateTime.now().toIso8601String(),
      address: '',
      // You can collect address later
      userId: currentUser.id!,
      productId: product!.id!, // Use the productId here
    );

    final result = await DatabaseHelper().insertOrder( userId: currentUser.id!,
      productId: product!.id!,);

    if (result > 0) {
      debugPrint("✅ Added to cart, navigating to cart screen.");
      // Using Flutter's Navigator.push() to navigate to CartScreen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CartScreen()),
      );
    } else {
      debugPrint("❌ Try again - insertOrder failed");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('❌ Failed to add to cart. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (product == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            color: const Color(0xFFF6F6F6),
            child: Center(
              child: Image.asset(
                product!.image,
                height: 398,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        product!.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF424242),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          for (int i = 0; i < 4; i++)
                            const Icon(Icons.star,
                                color: Color(0xFFE6A200), size: 14),
                          const Icon(Icons.star_half,
                              color: Color(0xFFE6A200), size: 14),
                          const SizedBox(width: 8),
                          const Text(
                            '(10)',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF757575),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        product!.description,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF757575),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            product!.price,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF424242),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '₹${(double.parse(product!.price.replaceAll(RegExp(r'[^\d.]'), '')) * 1.2).toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFFF4C51),
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            '-20%',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF43A047),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 35),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 52,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xFFFF8D41),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => buyNow(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Buy Now',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: addToCart,
                          child: Container(
                            height: 52,
                            width: 52,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xFFFF8D41),
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/icons/cartIcon.svg',
                                height: 26,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
