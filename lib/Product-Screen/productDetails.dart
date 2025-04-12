import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Hisabi/Product-Screen/buyNow.dart';
import 'package:Hisabi/Product-Screen/cartScreen.dart';
import 'package:Hisabi/db/db_helper.dart';
import 'package:Hisabi/models/product_model.dart';

class productDetail extends StatefulWidget {
  final int productId;

  const productDetail({super.key, required this.productId});

  @override
  State<productDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<productDetail> {
  ProductModel? product;

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  void loadProducts() async {
    final fetchedProduct =
    await DatabaseHelper().getProductById(widget.productId);

    if (fetchedProduct != null) {
      setState(() {
        product = fetchedProduct;
      });
    } else {
      print("❌ Product not found with ID: ${widget.productId}");
    }
  }



  @override
  Widget build(BuildContext context) {
    if (product == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            color: Color(0xFFF6F6F6),
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
                          Icon(Icons.star, color: Color(0xFFE6A200), size: 14),
                          Icon(Icons.star, color: Color(0xFFE6A200), size: 14),
                          Icon(Icons.star, color: Color(0xFFE6A200), size: 14),
                          Icon(Icons.star, color: Color(0xFFE6A200), size: 14),
                          Icon(Icons.star_half, color: Color(0xFFE6A200), size: 14),
                          const SizedBox(width: 8),
                          Text(
                            '(10)',
                            style: const TextStyle(
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
                          // Actual Price
                          Text(
                            product!.price,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF424242),
                            ),
                          ),
                          const SizedBox(width: 8),

                          // Inflated Price (strike-through)
                          Text(
                            '₹${(double.parse(product!.price.replaceAll('₹', '')) * 1.2).toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFFF4C51),
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),

                          const SizedBox(width: 8),

                          // Discount Percentage
                          Text(
                            '-20%',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF43A047), // Green color for discount
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
                                backgroundColor: Color(0xFFFF8D41),
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
                              child: Text(
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
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => cartScreen(),
                              ),
                            );
                          },
                          child: Container(
                            height: 52,
                            width: 52,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFFFFF),
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
