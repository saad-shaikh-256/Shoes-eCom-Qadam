import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class buyNow extends StatefulWidget {
  @override
  _BuyNowCartScreenState createState() => _BuyNowCartScreenState();
}

class _BuyNowCartScreenState extends State<buyNow> {
  List<Map<String, dynamic>> products = [
    {
      'name': 'Nike Tiempo Legend',
      'price': 4995.00,
      'image': 'assets/Images/Home/Shoes/Shoes1.png',
      'quantity': 1,
    },
    {
      'name': 'Nike Air-Max Dn Essential',
      'price': 14995.00,
      'image': 'assets/Images/Home/Shoes/Shoes2.png',
      'quantity': 1,
    },
    {
      'name': 'Nike Air-Max-2013',
      'price': 16995.00,
      'image': 'assets/Images/Home/Shoes/Shoes3.png',
      'quantity': 1,
    },
  ];

  String couponCode = '';
  double discount = 0.0;

  double get subtotal =>
      products.fold(0, (sum, item) => sum + (item['price'] * item['quantity']));

  double get total => subtotal - discount;

  void applyCoupon(String code) {
    if (code == 'giveMeDiscount' || code == 'pleaseBrother') {
      setState(() {
        discount = subtotal * 0.10;
      });
    } else {
      setState(() {
        discount = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
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
            'Buy Now',
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
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return productCard(products[index]);
              },
            ),
          ),
          billableAmountSection(),
          buyNowButton(),
        ],
      ),
    );
  }

  Widget productCard(Map<String, dynamic> product) => Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(product['image']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product['name'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  SizedBox(height: 8),
                  Text('₹ ${product['price']}',
                      style: TextStyle(fontSize: 16, color: Color(0xFF9E9E9E))),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      quantityButton(Icons.remove, () {
                        setState(() {
                          if (product['quantity'] > 1) product['quantity']--;
                        });
                      }),
                      SizedBox(width: 8),
                      Text('${product['quantity']}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      SizedBox(width: 8),
                      quantityButton(Icons.add, () {
                        setState(() => product['quantity']++);
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget quantityButton(IconData icon, VoidCallback onPressed) => Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: icon == Icons.add ? Color(0xFFFF8D41) : Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: IconButton(
          icon: Icon(icon,
              size: 16,
              color: icon == Icons.add ? Colors.white : Color(0xFF757575)),
          onPressed: onPressed,
          padding: EdgeInsets.zero,
        ),
      );


  Widget billableAmountSection() => Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            billRow('Item Total', '₹ ${subtotal.toStringAsFixed(2)}'),
            SizedBox(height: 8),
            billRow('Discount', '- ₹ ${discount.toStringAsFixed(2)}'),
            SizedBox(height: 8),
            Divider(thickness: 1),
            SizedBox(height: 8),
            billRow('To Pay', '₹ ${total.toStringAsFixed(2)}', isTotal: true),
          ],
        ),
      );

  Widget billRow(String title, String amount, {bool isTotal = false}) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  color: Color(0xFF424242),
                  fontSize: isTotal ? 16 : 14,
                  fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal)),
          Text(amount,
              style: TextStyle(
                  color: Color(0xFF424242),
                  fontSize: isTotal ? 16 : 14,
                  fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal)),
        ],
      );

  Widget buyNowButton() => Padding(
        padding: EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => print('Buy Now clicked!'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFF8D41),
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
            child: Text('Buy Now',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)),
          ),
        ),
      );
}
