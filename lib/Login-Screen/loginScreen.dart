import 'package:Hisabi/Home-Screen/homeScreen.dart';
import 'package:Hisabi/Login-Screen/forgotPassword.dart';
import 'package:Hisabi/Login-Screen/signupScreen.dart';
import 'package:Hisabi/db/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  final String? message;

  const LoginScreen({Key? key, this.message}) : super(key: key);

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  bool isHidden = true;
  bool isLoading = false;
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.message != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.message!),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      });
    }
  }

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  String? emailError;
  String? passwordError;

  void submit() async {
    setState(() {
      isLoading = true;
    });
    setState(() { 
      emailError = null;
      passwordError = null;
    });

    if (formKey.currentState?.validate() ?? false) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      final dbHelper = DatabaseHelper();
      final user = await dbHelper.getUserByEmail(email);

      if (user != null && user.password == password) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => homeScreen()),
        );
      } else {
        setState(() {
          passwordError = "Invalid email or password";
        });
      }
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
                            "Login your Account",
                            style: TextStyle(
                              color: Color(0xFF9E9E9E),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ],
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
                                focusNode: emailFocusNode,
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
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
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        color: Color(0x8BFF8D41), width: 1),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    emailError = null;
                                  });
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter your email';
                                  } else if (!RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value)) {
                                    return 'Enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            if (emailError != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  emailError!,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            SizedBox(height: 20),
                            Container(
                              height: 52,
                              width: width,
                              child: TextFormField(
                                focusNode: passwordFocusNode,
                                controller: passwordController,
                                obscureText: isHidden,
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
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isHidden = !isHidden;
                                      });
                                    },
                                    icon: isHidden
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
                                  hintStyle: TextStyle(
                                    color: Color(0xff9E9E9E),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    passwordError = null;
                                  });
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter your password';
                                  } else if (value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            if (passwordError != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  passwordError!,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            SizedBox(height: 8),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => forgotPassword()),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                      color: Color(0xFFFF8D41),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
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
                            onPressed: submit,
                            child: Text(
                              'Sign in',
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
                                  builder: (context) => Signupscreen()),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: TextStyle(
                                  color: Color(0xFF9E9E9E),
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Sign up",
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
      ),
    );
  }
}
