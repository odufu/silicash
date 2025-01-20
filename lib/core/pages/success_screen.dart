import 'package:flutter/material.dart';
import 'package:silicash_mobile/core/widgets/app_button.dart';

class SuccessScreen extends StatelessWidget {
  final String title;
  final String message;
  final String gifPath;
  final VoidCallback? onButtonPressed;

  const SuccessScreen({
    Key? key,
    required this.title,
    required this.message,
    required this.gifPath,
    this.onButtonPressed,
  }) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                gifPath,
                width: 120,
                height: 120,
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                message,
                style: const TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              AppButton(
                buttonLabel: "Proceed",
                onclick: onButtonPressed ??
                    () {
                      Navigator.pop(context);
                    },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
