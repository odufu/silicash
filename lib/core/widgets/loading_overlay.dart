import 'package:flutter/material.dart';
import 'dart:math' as math;

class LoadingOverlay extends StatefulWidget {
  final bool isLoading;
  final Widget child;

  const LoadingOverlay({
    Key? key,
    required this.isLoading,
    required this.child,
  }) : super(key: key);

  @override
  _LoadingOverlayState createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;
  bool _isVisible = false; // Controls fade-in and fade-out

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    // Start with hidden overlay
    _isVisible = widget.isLoading;
  }

  @override
  void didUpdateWidget(covariant LoadingOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading != oldWidget.isLoading) {
      setState(() {
        _isVisible = widget.isLoading;
      });
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,

        /// **Fade in/out animation**
        AnimatedOpacity(
          duration: const Duration(milliseconds: 300), // Smooth transition
          opacity: _isVisible ? 1.0 : 0.0,
          curve: Curves.easeInOut,
          child: _isVisible
              ? Container(
                  color: Colors.black.withOpacity(0.3),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedBuilder(
                          animation: _rotationController,
                          builder: (_, child) {
                            return Transform.rotate(
                              angle: _rotationController.value * 2 * math.pi,
                              child: child,
                            );
                          },
                          child: Image.asset(
                            "assets/loading.png", // Your loading image
                            width: 50,
                            height: 50,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Enter your Pin",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : const SizedBox(), // Keeps space empty when hidden
        ),
      ],
    );
  }
}
