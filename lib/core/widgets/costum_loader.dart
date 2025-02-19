import 'package:flutter/material.dart';
import 'dart:math';

class LoadingOverlay extends StatefulWidget {
  final bool isLoading;

  const LoadingOverlay({Key? key, required this.isLoading}) : super(key: key);

  @override
  _LoadingOverlayState createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(); // Rotates infinitely
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isLoading
        ? Stack(
            children: [
              // Background Overlay
              Container(
                color: Colors.black.withOpacity(0.5),
              ),
              // Rotating Image
              Center(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _controller.value * 2 * pi, // Full rotation
                      child: Image.asset("assets/images/appAssets/Loader.png",
                          width: 60, height: 60),
                    );
                  },
                ),
              ),
            ],
          )
        : const SizedBox.shrink(); // If not loading, return an empty widget
  }
}
