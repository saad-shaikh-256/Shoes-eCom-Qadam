import 'package:Hisabi/Product-Screen/buyNow.dart';
import 'package:Hisabi/db/db_helper.dart';
import 'package:Hisabi/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<OrderModel> cartItems = [];

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    final currentUser = await DatabaseHelper().getCurrentUser();

    if (currentUser != null) {
      final items = await DatabaseHelper().getOrdersByUser(currentUser.id!);
      setState(() {
        cartItems = items;
      });
    }
  }

  Future<void> _increaseQuantity(int orderId) async {
    final order = cartItems.firstWhere((item) => item.id == orderId);
    if (order.quantity < 10) {
      order.quantity++;
      final result =
          await DatabaseHelper().updateOrderQuantity(order.id!, order.quantity);
      if (result > 0) {
        _loadCartItems();
      }
    }
  }

  Future<void> _decreaseQuantity(int orderId) async {
    final order = cartItems.firstWhere((item) => item.id == orderId);
    if (order.quantity > 1) {
      order.quantity--;
      final result =
          await DatabaseHelper().updateOrderQuantity(order.id!, order.quantity);
      if (result > 0) {
        _loadCartItems();
      }
    }
  }

  Future<void> _removeItem(int orderId) async {
    final result = await DatabaseHelper().deleteOrder(orderId);
    if (result > 0) {
      _loadCartItems();
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
        toolbarHeight: 100,
      ),
      body: cartItems.isEmpty
          ? Center(child: Text('Your cart is empty!'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final order = cartItems[index];
                      return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
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
                                      image: AssetImage(order.productImage),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 24),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        order.productName,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF616161),
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        '₹ ${order.price.toStringAsFixed(2)}',
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
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.remove,
                                                size: 14,
                                                color: Color(0xFF757575),
                                              ),
                                              padding: EdgeInsets.zero,
                                              onPressed: () =>
                                                  _decreaseQuantity(order.id!),
                                            ),
                                          ),
                                          SizedBox(width: 12),
                                          Text(
                                            order.quantity.toString(),
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          SizedBox(width: 12),
                                          Container(
                                            width: 24,
                                            height: 24,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFFF8D41),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.add,
                                                size: 14,
                                                color: Colors.white,
                                              ),
                                              padding: EdgeInsets.zero,
                                              onPressed: () =>
                                                  _increaseQuantity(order.id!),
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
                                    padding: EdgeInsets.zero,
                                    onPressed: () => _removeItem(order.id!),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BuyNowScreen(cartItems: cartItems),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFF8D41),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Proceed to Checkout',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
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
