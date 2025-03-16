import 'package:Hisabi/Product-Screen/cartScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class productDetail extends StatefulWidget {
  const productDetail({super.key});

  @override
  State<productDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<productDetail> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Image Section
          Center(
            child: Image.asset(
              'assets/Images/Home/Shoes/Shoes2.png',
              height: 398,
            ),
          ),

          // Content Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Content
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        'Nike Air Max Dn Essential',
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
                          Icon(Icons.star_half,
                              color: Color(0xFFE6A200), size: 14),
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
                        "The Air Max Dn features our Dynamic Air unit system of dual-pressure tubes, creating a responsive sensation with every step. This results in a futuristic design that's comfortable enough to wear from day to night. Go ahead Feel The Unreal",
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF757575),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            '₹ 14995.00',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF424242),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '₹ 14995.00',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFFF4C51),
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Button Section
                  Padding(
                    padding: const EdgeInsets.only(bottom: 35),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 52,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Color(0xFFFF8D41),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () {},
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
