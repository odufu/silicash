import 'package:flutter/material.dart';

import '../../../core/utils/helper_functions.dart';
import '../../welcome/pages/welcome_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true); // Loop the animation

    // Define the scale animation
    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 1.3).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Navigate to the WelcomePage after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      if (!_isNavigating) {
        _isNavigating = true; // Prevent multiple navigations
        _animationController.stop(); // Stop animation before navigating
        _animationController.dispose(); // Dispose the animation controller
        HelperFunctions.routeReplacdTo(WelcomePage(), context);
      }
    });
  }

  @override
  void dispose() {
    if (!_isNavigating) {
      _animationController.dispose(); // Ensure safe disposal
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: child,
                    );
                  },
                  child: Image.asset(
                    "assets/images/brand/logoWhite.png",
                    width: 139,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  '', // Optional: Add app name or slogan
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
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
