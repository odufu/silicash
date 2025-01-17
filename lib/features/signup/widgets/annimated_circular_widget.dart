import 'package:flutter/material.dart';
import 'dart:math';

class AnimatedCircularProgress extends StatefulWidget {
  final int numerator;
  final int denominator;
  final Color startingColor;
  final Color endingColor;

  const AnimatedCircularProgress({
    super.key,
    required this.numerator,
    required this.denominator,
    required this.startingColor,
    required this.endingColor,
  });

  @override
  _AnimatedCircularProgressState createState() =>
      _AnimatedCircularProgressState();
}

class _AnimatedCircularProgressState extends State<AnimatedCircularProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Initialize with default progress
    _animation = Tween<double>(begin: 0.0, end: widget.numerator / widget.denominator).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant AnimatedCircularProgress oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Check if numerator or denominator has changed
    if (widget.numerator != oldWidget.numerator ||
        widget.denominator != oldWidget.denominator) {
      _updateAnimation();
    }
  }

  void _updateAnimation() {
    double progress = widget.numerator / widget.denominator;

    // Update animation with new progress
    _animation = Tween<double>(
      begin: _animation.value, // Start from current progress
      end: progress,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward(from: 0); // Restart animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          size: const Size(32, 32), // Set size for the custom widget
          painter: _CircularProgressPainter(
            progress: _animation.value,
            numerator: widget.numerator,
            denominator: widget.denominator,
            startingColor: widget.startingColor,
            endingColor: widget.endingColor,
          ),
        );
      },
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double progress;
  final int numerator;
  final Color startingColor;
  final Color endingColor;
  final int denominator;

  _CircularProgressPainter({
    required this.startingColor,
    required this.endingColor,
    required this.progress,
    required this.numerator,
    required this.denominator,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 5.0;
    double radius = (size.width - strokeWidth) / 2;
    Offset center = Offset(size.width / 2, size.height / 2);

    Paint backgroundPaint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    Paint progressPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          startingColor,
          endingColor,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Draw background circle
    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw progress arc
    double sweepAngle = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );

    // Draw text
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: '$numerator/$denominator',
        style: const TextStyle(
          color: Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    Offset textOffset = Offset(
      center.dx - textPainter.width / 2,
      center.dy - textPainter.height / 2,
    );
    textPainter.paint(canvas, textOffset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
