import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final String fullName = "Saad Shaikh";
  final String email = "saad.shaikh@example.com";

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: width,
          padding: EdgeInsetsDirectional.fromSTEB(24, 60, 24, 35),
          child: Column(
            children: [
              // Header with Back Button
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset(
                      'assets/icons/back_arrow.svg',
                      width: 24,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(
                    'My Profile',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),

              // Profile Card
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/Images/Home/profile.png'),
                    ),
                    SizedBox(height: 16),
                    Text(
                      fullName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      email,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF9E9E9E),
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),

              // Profile Options
              _buildOptionTile(
                icon: 'assets/icons/edit_profile.svg',
                title: 'Edit Profile',
                onTap: () {
                  // Navigate to edit profile
                },
              ),
              _buildOptionTile(
                icon: 'assets/icons/cart.svg',
                title: 'Cart',
                onTap: () {
                  // Navigate to cart
                },
              ),
              _buildOptionTile(
                icon: 'assets/icons/order_history.svg',
                title: 'Order History',
                onTap: () {
                  // Navigate to order history
                },
              ),
              SizedBox(height: 40),

              // Delete Account Button
              Container(
                height: 54,
                width: width,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.red, width: 1),
                    ),
                  ),
                  onPressed: _showDeleteConfirmation,
                  child: Text(
                    'Delete Account',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionTile({
    required String icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        Container(
          height: 56,
          child: ListTile(
            leading: SvgPicture.asset(
              icon,
              width: 24,
              color: Color(0xFFFF8D41),
            ),
            title: Text(
              title,
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            trailing: SvgPicture.asset(
              'assets/icons/forward_arrow.svg',
              width: 16,
              color: Color(0xFF9E9E9E),
            ),
            onTap: onTap,
          ),
        ),
        Divider(
          height: 1,
          color: Color(0xFFEEEEEE),
          thickness: 1,
        ),
      ],
    );
  }

  void _showDeleteConfirmation() {
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
          'This will permanently delete your account and all data.',
          style: TextStyle(
            fontFamily: 'Inter',
            color: Color(0xFF9E9E9E),
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
            onPressed: () {
              // Handle account deletion
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Account deleted successfully'),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
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