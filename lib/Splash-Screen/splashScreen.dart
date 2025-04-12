import 'package:Hisabi/Splash-Screen/startupScreen.dart'; // Import the target screen after splash
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // For displaying SVG assets

// Defines the stateful widget for the splash screen.
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

// Manages the state for the SplashScreen, including animations.
// Uses SingleTickerProviderStateMixin to provide a ticker for the animation controller.
class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller; // Manages the animation's lifecycle.
  late Animation<Offset> _slideAnimation; // Defines the position animation.

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller with a 2-second duration.
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    // Create a slide animation moving from left (-1.5 offset) to center (0,0 offset).
    _slideAnimation = Tween<Offset>(
      begin: Offset(-1.5, 0),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // Smooth ease-in-out curve for the slide.
    ));

    // Start the animation.
    _controller.forward();

    // Listen for animation completion to navigate to the next screen.
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Add a short delay after animation before navigating.
        Future.delayed(Duration(seconds: 1), () {
          // Navigate to StartUpScreen using pushReplacement to remove splash screen from stack.
          // Uses a custom fade transition.
          Navigator.of(context).pushReplacement(_createFadePageRoute());
        });
      }
    });
  }

  // Creates a custom PageRoute with a Fade transition for smoother navigation.
  PageRouteBuilder _createFadePageRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Startupscreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Apply a fade transition effect.
        return FadeTransition(opacity: animation, child: child);
      },
      // Optional: Define transition duration if needed (defaults are usually fine)
      // transitionDuration: Duration(milliseconds: 500),
    );
  }

  // Dispose the animation controller when the widget is removed from the tree
  // to prevent memory leaks.
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Builds the UI for the splash screen.
  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for layout.
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Colors.white,
        child: Center(
          // Apply the slide animation to the logo.
          child: SlideTransition(
            position: _slideAnimation,
            child: SvgPicture.asset(
              'assets/logo/Logo.svg', // Path to your SVG logo
              height: 50, // Logo height
            ),
          ),
        ),
      ),
    );
  }
}
