import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Hisabi/db/db_helper.dart';
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

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    UserModel? user = await DatabaseHelper().getCurrentUser();
    if (user != null) {
      setState(() {
        fullName = user.name ?? "No Name";
        email = user.email ?? "No Email";
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
                        backgroundImage: AssetImage('assets/Images/Home/profile.png'),
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
                      final currentUser = await DatabaseHelper().getCurrentUser();
                      if (currentUser != null) {
                        final updatedUser = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfileScreen(currentUser: currentUser),
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
                _buildProfileOption(
                  icon: 'assets/icons/cartIcon.svg',
                  title: 'Cart',
                  onTap: () {},
                ),
                _buildProfileOption(
                  icon: 'assets/icons/orderIcon.svg',
                  title: 'Order History ($orderCount)',
                  onTap: () {},
                ),
              ],
            ),
          ),

          // Delete Account Button
          Container(
            padding: EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _showDeleteDialog(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Colors.red, width: 1),
                  ),
                ),
                child: Text(
                  'Delete Account',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
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
            onPressed: () {
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
