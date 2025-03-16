import 'package:Hisabi/Product-Screen/productDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  homeScreenState createState() => homeScreenState();
}

class homeScreenState extends State<homeScreen> {
  final List<String> categories = [
    'All',
    'Boots',
    'Formal Shoes',
    'Sports & Athletic Shoes'
  ];
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Nike Tiempo Legend',
      'price': '₹ 4995.00',
      'image': 'assets/Images/Home/Shoes/Shoes1.png'
    },
    {
      'name': 'Nike Air-Max Dn Essential',
      'price': '₹ 14995.00',
      'image': 'assets/Images/Home/Shoes/Shoes2.png'
    },
    {
      'name': 'Nike Air-Max-2013',
      'price': '₹ 16995.00',
      'image': 'assets/Images/Home/Shoes/Shoes3.png'
    },
    {
      'name': 'Nike Air Zoom-Upturn-SC',
      'price': '₹ 7895.00',
      'image': 'assets/Images/Home/Shoes/Shoes4.png'
    },
    {
      'name': 'Nike Elevate 3',
      'price': '₹ 7095.00',
      'image': 'assets/Images/Home/Shoes/Shoes5.png'
    },
    {
      'name': 'Nike SB Dunk Low Pro',
      'price': '₹ 9695.00',
      'image': 'assets/Images/Home/Shoes/Shoes6.png'
    },
    {
      'name': 'Nike Tiempo Legend',
      'price': '₹ 4995.00',
      'image': 'assets/Images/Home/Shoes/Shoes1.png'
    },
    {
      'name': 'Nike Air-Max Dn Essential',
      'price': '₹ 14995.00',
      'image': 'assets/Images/Home/Shoes/Shoes2.png'
    },
    {
      'name': 'Nike Air-Max-2013',
      'price': '₹ 16995.00',
      'image': 'assets/Images/Home/Shoes/Shoes3.png'
    },
    {
      'name': 'Nike Air Zoom-Upturn-SC',
      'price': '₹ 7895.00',
      'image': 'assets/Images/Home/Shoes/Shoes4.png'
    },
    {
      'name': 'Nike Elevate 3',
      'price': '₹ 7095.00',
      'image': 'assets/Images/Home/Shoes/Shoes5.png'
    },
    {
      'name': 'Nike SB Dunk Low Pro',
      'price': '₹ 9695.00',
      'image': 'assets/Images/Home/Shoes/Shoes6.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(24, 60, 24, 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi Saad Shaikh!!',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Good Morning',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage(
                        'assets/Images/Home/profile.png'), // Replace with actual profile image
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 52,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Color(0xFFEEEEEE),
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Color(0xFFEEEEEE), // Inactive border color
                              width: 1,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Search Men\'s Shoes',
                          hintStyle: TextStyle(
                            color: Color(0xFF9E9E9E),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Color(0xFFFF8D41),
                              width: 1,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 16.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      print("Search button clicked!");
                    },
                    child: Container(
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        color: Color(0xFFFF8D41),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/icons/searchIcon.svg',
                          height: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Chip(
                        label: Text(categories[index]),
                        backgroundColor:
                            index == 0 ? Color(0xFFFF8D41) : Colors.white,
                        labelStyle: TextStyle(
                          color: index == 0 ? Colors.white : Color(0xFF9E9E9E),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          // Rounded corners
                          side: BorderSide(
                            color: index == 0
                                ? Colors.orange
                                : Color(0xFFE0E0E0), // Border color
                            width: 1, // Border width
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio:
                        0.6, // Adjusted aspect ratio for more height
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigate to the productDetail screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => productDetail(),
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.transparent, // Remove background color
                        elevation: 0, // Optional: Remove elevation if desired
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 180,
                              // Fixed height
                              width: double.infinity,
                              // Ensure full width of the card
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                                child: Image.asset(
                                  products[index]['image'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    products[index]['name'],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF9e9e9e),
                                    ),
                                    maxLines: 1, // Limit text to a single line
                                    overflow: TextOverflow
                                        .ellipsis, // Truncate overflow
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    products[index]['price'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF424242),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    // Limit price text to a single line
                                    overflow: TextOverflow
                                        .ellipsis, // Truncate overflow
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
