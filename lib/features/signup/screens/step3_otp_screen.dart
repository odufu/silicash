import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:silicash_mobile/core/widgets/app_button.dart';

import '../../../core/utils/helper_functions.dart';
import '../../login/pages/login_page.dart';

class Step3OtpScreen extends StatefulWidget {
  final VoidCallback onNext;

  Step3OtpScreen({required this.onNext});

  @override
  _Step3OtpScreenState createState() => _Step3OtpScreenState();
}

class _Step3OtpScreenState extends State<Step3OtpScreen> {
  final List<String> otpValues = List.filled(6, ""); // Stores the OTP digits

  // Check if all OTP fields are filled
  bool get isOtpComplete => otpValues.every((value) => value.isNotEmpty);

  // Function to handle OTP input changes
  void _onOtpChanged(String value, int index) {
    setState(() {
      otpValues[index] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                const Text(
                  "Verify Email",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              "Please provide the OTP sent to this email  Otuekongd*******@gmail.com",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 40),

            // OTP Fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 40,
                  child: TextFormField(
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        FocusScope.of(context).nextFocus();
                      }
                      _onOtpChanged(value, index);
                    },
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      counterText: "",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),

            // Resend OTP Button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    // Resend OTP Logic
                  },
                  child: Text(
                    "Resend OTP",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Continue Button
            AppButton(
              buttonLabel: "Continue",
              onclick: isOtpComplete ? widget.onNext : null,
            ),
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
          ],
        ),
      ),
    );
  }
}
