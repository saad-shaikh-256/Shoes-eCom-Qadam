import 'package:Hisabi/Login-Screen/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Signupscreen extends StatefulWidget {
  @override
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<Signupscreen> {
  bool isPasswordHidden = true;
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  void submit() {
    if (formKey.currentState?.validate() ?? false) {
      String name = nameController.text.trim();
      String email = emailController.text.trim();
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();
      print('Name: $name');
      print('Email: $email');
      print('Phone: $phone');
      print('Password: $password');
      // You can add your sign-up logic here
    } else {
      print("Data is Invalid");
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
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        "Create an Account",
                        style: TextStyle(
                          color: Color(0xFF9E9E9E),
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 56),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Container(
                              height: 52,
                              width: width,
                              child: TextFormField(
                                controller: nameController,
                                focusNode: nameFocusNode,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        color: Color(0x8BFF8D41), width: 1),
                                  ),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: SvgPicture.asset(
                                      'assets/icons/userIcon.svg',
                                      width: 20.0,
                                      height: 20.0,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFFAFAFA),
                                  hintText: 'Full Name',
                                  hintStyle: TextStyle(
                                    color: Color(0xff9E9E9E),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter your full name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              height: 52,
                              width: width,
                              child: TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                focusNode: emailFocusNode,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        color: Color(0x8BFF8D41), width: 1),
                                  ),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: SvgPicture.asset(
                                      'assets/icons/mailIcon.svg',
                                      width: 20.0,
                                      height: 20.0,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFFAFAFA),
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                    color: Color(0xff9E9E9E),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter your email';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              height: 52,
                              width: width,
                              child: TextFormField(
                                controller: phoneController,
                                keyboardType: TextInputType.phone,
                                focusNode: phoneFocusNode,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        color: Color(0x8BFF8D41), width: 1),
                                  ),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: SvgPicture.asset(
                                      'assets/icons/phoneIcon.svg',
                                      width: 20.0,
                                      height: 20.0,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFFAFAFA),
                                  hintText: 'Phone',
                                  hintStyle: TextStyle(
                                    color: Color(0xff9E9E9E),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter your phone number';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              height: 52,
                              width: width,
                              child: TextFormField(
                                controller: passwordController,
                                obscureText: isPasswordHidden,
                                focusNode: passwordFocusNode,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        color: Color(0x8BFF8D41), width: 1),
                                  ),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: SvgPicture.asset(
                                      'assets/icons/lockIcon.svg',
                                      width: 20.0,
                                      height: 20.0,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFFAFAFA),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                    color: Color(0xff9E9E9E),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isPasswordHidden = !isPasswordHidden;
                                      });
                                    },
                                    icon: isPasswordHidden
                                        ? SvgPicture.asset(
                                            'assets/icons/viewIcon.svg',
                                            width: 20.0,
                                            height: 20.0,
                                          )
                                        : SvgPicture.asset(
                                            'assets/icons/hideIcon.svg',
                                            width: 20.0,
                                            height: 20.0,
                                          ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter your password';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Bottom Button
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
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            onPressed: submit,
                            child: Text(
                              'Create Account',
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
                        Text(
                          "- OR -",
                          style: TextStyle(
                            color: Color(0xFFBDBDBD),
                            fontFamily: 'Inter',
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account ",
                                style: TextStyle(
                                  color: Color(0xFF9E9E9E),
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Sign in!!",
                                style: TextStyle(
                                  color: Color(0xFFFF8D41),
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
