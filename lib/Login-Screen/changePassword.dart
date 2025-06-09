import 'package:Hisabi/Login-Screen/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String email;

  const ChangePasswordScreen({Key? key, required this.email}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;

  void resetPassword() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('✅ Password updated successfully!'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final double width = size.width;
    final double height = size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: width,
          height: height,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(24, 60, 24, 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Column(
                      children: [
                        Center(
                          child: SvgPicture.asset(
                            'assets/logo/Logo.svg',
                            height: 42,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          "Reset Your Password",
                          style: TextStyle(
                            color: Color(0xFF9E9E9E),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'for ${widget.email}',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            color: Color(0xFF9E9E9E),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 56),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // New Password Field
                          Container(
                            height: 52,
                            width: width,
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: isPasswordHidden,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    color: Color(0x8BFF8D41),
                                    width: 1,
                                  ),
                                ),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SvgPicture.asset(
                                    'assets/icons/lockIcon.svg',
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: SvgPicture.asset(
                                    isPasswordHidden
                                        ? 'assets/icons/viewIcon.svg'
                                        : 'assets/icons/hideIcon.svg',
                                    width: 20,
                                    height: 20,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isPasswordHidden = !isPasswordHidden;
                                    });
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Color(0xFFFAFAFA),
                                hintText: 'New Password',
                                hintStyle: TextStyle(
                                  color: Color(0xFF9E9E9E),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty)
                                  return 'Enter your password';
                                if (value.length < 6)
                                  return 'Minimum 6 characters';
                                if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)')
                                    .hasMatch(value)) {
                                  return 'Must include upper, lower & number';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          // Confirm Password Field
                          Container(
                            height: 52,
                            width: width,
                            child: TextFormField(
                              controller: confirmPasswordController,
                              obscureText: isConfirmPasswordHidden,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    color: Color(0x8BFF8D41),
                                    width: 1,
                                  ),
                                ),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SvgPicture.asset(
                                    'assets/icons/lockIcon.svg',
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: SvgPicture.asset(
                                    isConfirmPasswordHidden
                                        ? 'assets/icons/viewIcon.svg'
                                        : 'assets/icons/hideIcon.svg',
                                    width: 20,
                                    height: 20,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isConfirmPasswordHidden =
                                          !isConfirmPasswordHidden;
                                    });
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Color(0xFFFAFAFA),
                                hintText: 'Confirm Password',
                                hintStyle: TextStyle(
                                  color: Color(0xFF9E9E9E),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              validator: (value) {
                                if (value != passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  width: width,
                  child: Column(
                    children: [
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
                          onPressed: resetPassword,
                          child: Text(
                            'Update Password',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                            (Route<dynamic> route) => false,
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Remember your password? ",
                              style: TextStyle(
                                color: Color(0xFF9E9E9E),
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "Sign in",
                              style: TextStyle(
                                color: Color(0xFFFF8D41),
                                fontFamily: 'Inter',
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
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