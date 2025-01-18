import 'package:flutter/material.dart';
import 'package:silicash_mobile/core/widgets/app_button.dart';
import 'package:silicash_mobile/core/widgets/costum_password_input.dart';

import '../../../core/utils/helper_functions.dart';
import '../../login/pages/login_page.dart';

class Step4CreatePinScreen extends StatefulWidget {
  final VoidCallback onNext;

  Step4CreatePinScreen({required this.onNext});

  @override
  State<Step4CreatePinScreen> createState() => _Step4CreatePinScreenState();
}

class _Step4CreatePinScreenState extends State<Step4CreatePinScreen> {
  bool _isObscure = true;
  final pinController = TextEditingController();
  final confirmPinController = TextEditingController();
  bool get isComplet =>
      pinController.text == confirmPinController.text &&
      pinController.text.length == 4;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Text(
            "Create Your PIN",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            "This PIN will be used to secure your account.",
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 40),

          // PIN Input
          CostumPasswordInput(
            confirmPasswordController: pinController,
            isObscured: _isObscure,
            label: "Enter Pin",
            hint: "Enter a 4 digit Pin",
            keyboardType: TextInputType.number,
            maxLength: 4,
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
          ),
          SizedBox(height: 20),

          // Confirm PIN Input
          CostumPasswordInput(
            hint: "Enter Same Pin",
            label: "Confirm Pin",
            onChanged: (value){
              setState(() {
                
              });
            },
            keyboardType: TextInputType.number,
            maxLength: 4,
            confirmPasswordController: confirmPinController,
            isObscured: _isObscure,
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
          ),
          SizedBox(height: 40),

          AppButton(
              buttonLabel: "Continue",
              onclick: isComplet
                  ? () {
                      widget.onNext();
                    }
                  : null),
          Center(
            child: TextButton(
              onPressed: () {
                HelperFunctions.routePushTo(LoginPage(), context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account? ',
                      style: TextStyle(color: Colors.black)),
                  Text('Login',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary)),
                ],
              ),
            ),
          ),
          // // Continue Button
          // ElevatedButton(
          //   onPressed: () {
          //     // Add validation logic for PINs here
          //     if (pinController.text == confirmPinController.text &&
          //         pinController.text.length == 4) {
          //       widget.onNext();
          //     } else {
          //       // Show validation error
          //       ScaffoldMessenger.of(context).showSnackBar(
          //         SnackBar(
          //           content: Text("PINs do not match or are invalid."),
          //         ),
          //       );
          //     }
          //   },
          //   child: Text("Continue"),
          //   style: ElevatedButton.styleFrom(
          //     minimumSize: Size(double.infinity, 50),
          //   ),
          // ),
        ],
      ),
    );
  }
}
