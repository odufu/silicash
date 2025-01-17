import 'package:flutter/material.dart';
import 'package:silicash_mobile/core/widgets/costum_password_input.dart';

class Step4CreatePinScreen extends StatefulWidget {
  final VoidCallback onNext;

  Step4CreatePinScreen({required this.onNext});

  @override
  State<Step4CreatePinScreen> createState() => _Step4CreatePinScreenState();
}

class _Step4CreatePinScreenState extends State<Step4CreatePinScreen> {
  @override
  Widget build(BuildContext context) {
    final pinController = TextEditingController();
    final confirmPinController = TextEditingController();
    bool _isObscured = true;
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Text(
            "Create Your PIN",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            "This PIN will be used to secure your account.",
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 40),

          // PIN Input
          CostumPasswordInput(
            confirmPasswordController: pinController,
            isObscured: true,
            label: "Enter Pin",
            hint: "Enter a 4 digit Pin",
            onPressed: () {
              setState(() {
                _isObscured = !_isObscured;
              });
            },
          ),
          SizedBox(height: 20),

          // Confirm PIN Input
          CostumPasswordInput(
            hint: "Enter Same Pin",
            label: "Confirm Pin",
            confirmPasswordController: confirmPinController,
            isObscured: _isObscured,
            onPressed: () {
              setState(() {
                _isObscured = !_isObscured;
              });
            },
          ),
          SizedBox(height: 40),

          // Continue Button
          ElevatedButton(
            onPressed: () {
              // Add validation logic for PINs here
              if (pinController.text == confirmPinController.text &&
                  pinController.text.length == 4) {
                widget.onNext();
              } else {
                // Show validation error
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("PINs do not match or are invalid."),
                  ),
                );
              }
            },
            child: Text("Continue"),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
            ),
          ),
        ],
      ),
    );
  }
}
