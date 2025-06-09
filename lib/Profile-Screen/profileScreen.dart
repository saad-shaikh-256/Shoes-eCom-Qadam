import 'package:Hisabi/Login-Screen/loginScreen.dart';
import 'package:Hisabi/Product-Screen/cartScreen.dart';
import 'package:Hisabi/Profile-Screen/orderHistory.dart';
import 'package:Hisabi/db/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/user_model.dart';
import './editProfile.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  String fullName = "Loading...";
  String email = "Loading...";
  int orderCount = 5;
  UserModel? currentUser;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    UserModel? user = await DatabaseHelper().getCurrentUser();

    if (user != null) {
      int count = await DatabaseHelper().getOrderCountByUserId(user.id!);
      setState(() {
        currentUser = user;
        fullName = user.name ?? "No Name";
        email = user.email ?? "No Email";
        orderCount = count;
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
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            'My Profile',
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
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              children: [
                // Profile Card
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            AssetImage('assets/Images/Home/profile.png'),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fullName,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF616161),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            email,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF9E9E9E),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),

                // Profile Options
                Container(
                  height: 56,
                  margin: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () async {
                      final currentUser =
                          await DatabaseHelper().getCurrentUser();
                      if (currentUser != null) {
                        final updatedUser = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditProfileScreen(currentUser: currentUser),
                          ),
                        );

                        if (updatedUser != null && mounted) {
                          setState(() {
                            fullName = updatedUser.name;
                            email = updatedUser.email;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Profile updated successfully'),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to load user data'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/userIcon.svg',
                          width: 24,
                          color: Color(0xFFFF8D41),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF616161),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Color(0xFF9E9E9E),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 56,
                  margin: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CartScreen()),
                      );
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/cartIcon.svg',
                          width: 24,
                          color: Color(0xFFFF8D41),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            'Cart',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF616161),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Color(0xFF9E9E9E),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  height: 56,
                  margin: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              OrderHistoryScreen(userId: currentUser!.id!),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/orderIcon.svg',
                          width: 24,
                          color: Color(0xFFFF8D41),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            'Order History ($orderCount)',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF616161),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Color(0xFF9E9E9E),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _showDeleteDialog(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF8D41),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Color(0xFFFF8D41), width: 1),
                  ),
                ),
                child: Text(
                  'Delete Account',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
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

  Widget _buildProfileOption({
    required String icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                icon,
                width: 24,
                height: 24,
                color: Color(0xFFFF8D41),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF616161),
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Color(0xFF9E9E9E),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          'Delete Account',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'Are you sure you want to delete your account permanently?',
          style: TextStyle(
            fontFamily: 'Inter',
            color: Color(0xFF616161),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontFamily: 'Inter',
                color: Color(0xFF9E9E9E),
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);

              final currentUser = await DatabaseHelper().getCurrentUser();
              if (currentUser != null) {
                final result =
                    await DatabaseHelper().deleteUser(currentUser.id!);

                if (result > 0 && mounted) {
                  // Navigate to LoginScreen with message
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(
                        message: 'Account deleted successfully',
                      ),
                    ),
                    (route) => false,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to delete account'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            child: Text(
              'Delete',
              style: TextStyle(
                fontFamily: 'Inter',
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
