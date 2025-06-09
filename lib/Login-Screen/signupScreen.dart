import 'package:Hisabi/Login-Screen/loginScreen.dart';
import 'package:Hisabi/db/db_helper.dart';
import 'package:Hisabi/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Signupscreen extends StatefulWidget {
  @override
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<Signupscreen> {
  bool isPasswordHidden = true;
  final formKey = GlobalKey<FormState>();
  final DatabaseHelper dbHelper = DatabaseHelper();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  String? emailError;

  void submit() async {
    setState(() {
      emailError = null;
    });

    if (formKey.currentState?.validate() ?? false) {
      String name = nameController.text.trim();
      String email = emailController.text.trim();
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();

      print(
          "👉 Name: $name, Email: $email, Phone: $phone, Password: $password");

      UserModel? existingUser = await dbHelper.getUserByEmail(email);
      if (existingUser != null) {
        setState(() {
          emailError = "User already registered with this email";
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❗ Email already exists')),
        );
        return;
      }

      UserModel newUser = UserModel(
        name: name,
        email: email,
        phone: phone,
        password: password,
      );

      await dbHelper.insertUser(newUser);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('✅ Account created! Please log in.')),
      );

      await Future.delayed(Duration(seconds: 1));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Form is invalid.')),
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
                          // Name
                          buildTextField(
                            controller: nameController,
                            focusNode: nameFocusNode,
                            hintText: 'Full Name',
                            iconPath: 'assets/icons/userIcon.svg',
                            validator: (value) =>
                                value!.isEmpty ? 'Enter your full name' : null,
                          ),
                          SizedBox(height: 20),

                          buildTextField(
                            controller: emailController,
                            focusNode: emailFocusNode,
                            hintText: 'Email',
                            iconPath: 'assets/icons/mailIcon.svg',
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) return 'Enter your email';
                              if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]{2,4}")
                                  .hasMatch(value)) {
                                return 'Enter a valid email';
                              }
                              return null;
                            },
                            onChanged: (_) => setState(() {
                              emailError = null;
                            }),
                          ),
                          if (emailError != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                emailError!,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ),
                          SizedBox(height: 20),

                          buildTextField(
                            controller: phoneController,
                            focusNode: phoneFocusNode,
                            hintText: 'Phone',
                            iconPath: 'assets/icons/phoneIcon.svg',
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value!.isEmpty) return 'Enter your phone';
                              if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                                return 'Phone number must be 10 digits';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),

                          buildTextField(
                            controller: passwordController,
                            focusNode: passwordFocusNode,
                            hintText: 'Password',
                            iconPath: 'assets/icons/lockIcon.svg',
                            obscureText: isPasswordHidden,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isPasswordHidden = !isPasswordHidden;
                                });
                              },
                              icon: isPasswordHidden
                                  ? SvgPicture.asset(
                                      'assets/icons/viewIcon.svg',
                                      width: 20,
                                    )
                                  : SvgPicture.asset(
                                      'assets/icons/hideIcon.svg',
                                      width: 20,
                                    ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) return 'Enter your password';
                              if (value.length < 6)
                                return 'Password must be 6+ characters';
                              if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)')
                                  .hasMatch(value)) {
                                return 'Must include upper, lower & number';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Column(
                  children: [
                    SizedBox(height: 40),
                    SizedBox(
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
                    Text("- OR -",
                        style: TextStyle(
                          color: Color(0xFFBDBDBD),
                          fontSize: 14,
                        )),
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
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "Sign in!!",
                            style: TextStyle(
                              color: Color(0xFFFF8D41),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hintText,
    required String iconPath,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    bool obscureText = false,
    void Function(String)? onChanged,
    Widget? suffixIcon,
  }) {
    return Container(
      height: 52,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: onChanged,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Color(0x8BFF8D41), width: 1),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SvgPicture.asset(iconPath, width: 20, height: 20),
          ),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Color(0xFFFAFAFA),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Color(0xff9E9E9E),
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        validator: validator,
      ),
    );
  }
}
