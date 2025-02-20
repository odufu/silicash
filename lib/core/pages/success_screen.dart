import 'package:flutter/material.dart';
import 'package:silicash_mobile/core/widgets/app_button.dart';
import 'package:silicash_mobile/core/widgets/costum_app_bar.dart';

class SuccessScreen extends StatelessWidget {
  final String title;
  final String message;
  final String gifPath;
  final Widget child;
  final VoidCallback? onButtonPressed;

  const SuccessScreen({
    Key? key,
    required this.title,
    required this.child,
    required this.message,
    required this.gifPath,
    this.onButtonPressed,
  }) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  gifPath,
                  width: 200,
                  height: 200,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  message,
                  style: const TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                child,
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
      ),
    );
  }
}
