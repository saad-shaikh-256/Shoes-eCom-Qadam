import 'package:Hisabi/Product-Screen/confirmOrder.dart';
import 'package:Hisabi/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddressFormScreen extends StatefulWidget {
  final List<OrderModel> cartItems;

  const AddressFormScreen({Key? key, required this.cartItems})
      : super(key: key);

  @override
  _AddressFormScreenState createState() => _AddressFormScreenState();
}

class _AddressFormScreenState extends State<AddressFormScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController addressController = TextEditingController();
  String? addressError;

  void submit() {
    setState(() {
      addressError = null;
    });

    if (formKey.currentState?.validate() ?? false) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmOrderScreen(
            cartItems: widget.cartItems,
            address: addressController.text.trim(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final double width = size.width;
    final double height = size.height;

    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/backIcon.svg',
              width: 24,
              height: 24,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            'Delivery Address',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF424242),
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFFFFFFF),
        toolbarHeight: 100,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: width,
          height: 0.85 * height,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Container(
                            height: 120,
                            width: width,
                            child: TextFormField(
                              controller: addressController,
                              maxLines: 4,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Color(0xFFFAFAFA),
                                hintText: 'Street, City, Postal Code',
                                hintStyle: TextStyle(
                                  color: Color(0xFF9E9E9E),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    color: Color(0x8BFF8D41),
                                    width: 1,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your address';
                                } else if (value.length < 10) {
                                  return 'Address is too short';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  addressError = null;
                                });
                              },
                            ),
                          ),
                          if (addressError != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                addressError!,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: 'Inter',
                                  fontSize: 14,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 54,
                  width: width,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xFFFF8D41),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: submit,
                    child: Text(
                      'Next',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Next Screen")),
    );
  }
}
