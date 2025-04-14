import 'package:Hisabi/db/db_helper.dart';
import 'package:Hisabi/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel currentUser;

  const EditProfileScreen({Key? key, required this.currentUser})
      : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final formKey = GlobalKey<FormState>();
  final DatabaseHelper dbHelper = DatabaseHelper();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;

  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  String? emailError;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.currentUser.name);
    emailController = TextEditingController(text: widget.currentUser.email);
    phoneController = TextEditingController(text: widget.currentUser.phone);
    passwordController =
        TextEditingController(text: widget.currentUser.password);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void submit() async {
    setState(() {
      emailError = null;
    });

    if (formKey.currentState?.validate() ?? false) {
      final updatedUser = UserModel(
        id: widget.currentUser.id,
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        password: widget.currentUser.password,
      );

      await dbHelper.updateUser(updatedUser);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('✅ Profile updated successfully!'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );

      Navigator.pop(context, updatedUser);
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
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: SvgPicture.asset(
                            'assets/icons/backIcon.svg',
                            width: 24,
                            height: 24,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Edit Profile",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF424242),
                            ),
                          ),
                        ),
                        SizedBox(width: 24),
                      ],
                    ),
                    SizedBox(height: 32),
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage('assets/Images/Home/profile.png'),
                        ),
                      ],
                    ),
                    SizedBox(height: 32),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
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
                            obscureText: true,
                            enabled: false,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
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
                          'Save Changes',
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
    bool enabled = true,
  }) {
    return Container(
      height: 52,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: onChanged,
        enabled: enabled,
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
