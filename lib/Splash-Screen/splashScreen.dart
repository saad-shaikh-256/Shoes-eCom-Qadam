import 'package:flutter/material.dart';
import 'package:flutter_project/Splash-Screen/startupScreen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController with the duration for the animation
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    // Define the slide animation (from right to center)
    _slideAnimation = Tween<Offset>(
      begin: Offset(-1.5, 0),
      // Start from the right (1.5x the width of the screen)
      end: Offset(0, 0), // End at the center
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // Ease-in-out curve
    ));

    // Start the animation when the widget is built
    _controller.forward();

    // Add a listener to navigate to the StartUpScreen once the animation completes
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // After animation completes, navigate to the StartUpScreen with a fade transition
        Future.delayed(Duration(seconds: 1), () {
          Navigator.of(context).pushReplacement(_createFadePageRoute());
        });
      }
    });
  }

  // Custom PageRoute with Fade transition
  PageRouteBuilder _createFadePageRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Startupscreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Fade transition
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Colors.white,
        child: Center(
          child: SlideTransition(
            position: _slideAnimation, // Apply the sliding animation
            child: SvgPicture.asset(
              'assets/logo/Logo.svg',
              height: 50,
            ),
          ),
        ),
      ),
    );
  }
}
