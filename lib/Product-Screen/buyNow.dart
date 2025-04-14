import 'package:Hisabi/Product-Screen/addressDetails.dart';
import 'package:Hisabi/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BuyNowScreen extends StatefulWidget {
  final List<OrderModel> cartItems;

  const BuyNowScreen({Key? key, required this.cartItems}) : super(key: key);

  @override
  _BuyNowScreenState createState() => _BuyNowScreenState();
}

class _BuyNowScreenState extends State<BuyNowScreen> {
  double discount = 0.0;
  String couponCode = '';

  double get subtotal {
    double total = 0.0;
    for (var order in widget.cartItems) {
      total += order.price * order.quantity;
    }
    return total;
  }

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
          padding: const EdgeInsets.only(top: 20),
          child: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/backIcon.svg',
              width: 24,
              height: 24,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
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
        toolbarHeight: 100,
      ),
      body: widget.cartItems.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(16),
                    children: widget.cartItems
                        .map((order) => productCard(order))
                        .toList(),
                  ),
                ),
                billableAmountSection(),
                buyNowButton(),
              ],
            ),
    );
  }

  Widget productCard(OrderModel order) => Container(
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
                  image: AssetImage(order.productImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(order.productName,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  SizedBox(height: 8),
                  Text('₹ ${order.price.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 16, color: Color(0xFF9E9E9E))),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      quantityButton(Icons.remove, () {
                        setState(() {
                          if (order.quantity > 1) order.quantity--;
                        });
                      }),
                      SizedBox(width: 8),
                      Text('${order.quantity}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      SizedBox(width: 8),
                      quantityButton(Icons.add, () {
                        setState(() {
                          if (order.quantity < 10) order.quantity++;
                        });
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
            onPressed: () {
              print('Buy Now clicked');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddressFormScreen(cartItems: widget.cartItems),
                ),
              );
            },
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
