import 'package:Hisabi/Login-Screen/changePassword.dart';
import 'package:Hisabi/Login-Screen/loginScreen.dart';
import 'package:Hisabi/db/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class forgotPassword extends StatefulWidget {
  @override
  _forgotPassword createState() => _forgotPassword();
}

class _forgotPassword extends State<forgotPassword> {
  bool isHidden = true;
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  String? emailError;

  void submit() async {
    setState(() {
      emailError = null;
    });

    if (formKey.currentState?.validate() ?? false) {
      String email = emailController.text.trim();

      bool exists = await DatabaseHelper.isEmailExist(email);

      if (exists) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangePasswordScreen(email: email),
          ),
        );

      } else {
        setState(() {
          emailError = "No email found";
        });
      }
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
                            "Forgot Password?",
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
                                          r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$")
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
                              'Continue',
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
                                "Back to ",
                                style: TextStyle(
                                  color: Color(0xFF9E9E9E),
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Login",
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
