import 'package:Hisabi/Login-Screen/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Startupscreen extends StatefulWidget {
  @override
  _Startupscreen createState() => _Startupscreen();
}

class _Startupscreen extends State<Startupscreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final double width = size.width;
    final double height = size.height;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(24, 60, 24, 35),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: SvgPicture.asset(
                    'assets/logo/Logo.svg',
                    height: 42,
                  ),
                ),
                Container(
                  width: width,
                  child: Column(
                    children: [
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/googleIcon.svg',
                              height: 45,
                            ),
                            SizedBox(width: 24),
                            SvgPicture.asset(
                              'assets/icons/facebookIcon.svg',
                              height: 45,
                            ),
                            SizedBox(width: 24),
                            SvgPicture.asset(
                              'assets/icons/appleIcon.svg',
                              height: 45,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                      Text(
                        "- OR -",
                        style: TextStyle(
                          color: Color(0xFFBDBDBD),
                          fontFamily: 'Inter',
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 24),
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            );
                          },
                          child: Text(
                            'Get Started',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
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
