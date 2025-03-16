import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class cartScreen extends StatelessWidget {
  // Sample product data
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Nike Tiempo Legend',
      'price': '₹ 4995.00',
      'image': 'assets/Images/Home/Shoes/Shoes1.png',
      'quantity': 1,
    },
    {
      'name': 'Nike Air-Max Dn Essential',
      'price': '₹ 14995.00',
      'quantity': 1,
      'image': 'assets/Images/Home/Shoes/Shoes2.png'
    },
    {
      'name': 'Nike Air-Max-2013',
      'price': '₹ 16995.00',
      'quantity': 1,
      'image': 'assets/Images/Home/Shoes/Shoes3.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5), // Set the entire background color
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(top: 20), //20px padding for icon
          child: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/backIcon.svg',
              width: 24,
              height: 24,
            ),
            onPressed: () {
              Navigator.pop(context); // Go back to the previous screen
            },
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 20), // 20px padding for title
          child: Text(
            'Cart Details',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF424242),
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFF5F5F5),
        toolbarHeight: 100, // Increase the toolbar height to fit padding
      ),
      body: Column(
        children: [
          // Product List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Image
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: AssetImage(products[index]['image']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 24),
                          // Product Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  products[index]['name'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF616161),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  products[index]['price'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF9E9E9E),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF5F5F5),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: IconButton(
                                        icon: Icon(Icons.remove,
                                            size: 14, color: Color(0xFF757575)),
                                        onPressed: () {},
                                        padding: EdgeInsets.zero,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      products[index]['quantity'].toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFF8D41),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.add,
                                          size: 14,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {},
                                        padding: EdgeInsets.zero,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.delete_outline_rounded,
                                size: 14,
                                color: Color(0xFF757575),
                              ),
                              onPressed: () {},
                              padding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                );
              },
            ),
          ),

          Container(
            padding: EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  print('Continue clicked!');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF8D41), // Button color
                  padding: EdgeInsets.symmetric(vertical: 16), // Button padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
