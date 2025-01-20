import 'package:flutter/material.dart';
import 'package:silicash_mobile/core/widgets/app_button.dart';
import 'package:silicash_mobile/features/signup/screens/success.dart';

import '../../../core/utils/helper_functions.dart';
import '../../../core/widgets/costum_password_input.dart';
import '../../login/pages/login_page.dart';

class Step5CreatePasswordScreen extends StatefulWidget {
  final VoidCallback onNext;

  Step5CreatePasswordScreen({required this.onNext});

  @override
  State<Step5CreatePasswordScreen> createState() =>
      _Step5CreatePasswordScreenState();
}

class _Step5CreatePasswordScreenState extends State<Step5CreatePasswordScreen> {
  bool _isObscured = false;
  bool _agreeUpdates = false;
  bool _acceptTerms = false;

  final _formKey = GlobalKey<FormState>();
  String? password;
  String? confirmPassword;

  // Function to check if all fields are filled
  bool get isFormComplete =>
      password != null &&
      password!.isNotEmpty &&
      confirmPassword != null &&
      confirmPassword!.isNotEmpty &&
      password == confirmPassword &&
      _acceptTerms != false &&
      _agreeUpdates != false;

  // Function to handle input changes
  void _onFieldChanged(String? value, Function(String?) updateField) {
    setState(() {
      updateField(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Create Your Password",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Make sure your password is strong and memorable.",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 40),

              // Password Input
              CostumPasswordInput(
                hint: "Enter at list 8 characters",
                onChanged: (value) =>
                    _onFieldChanged(value, (v) => password = v),
                label: "Enter a Password",
                isObscured: _isObscured,
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Confirm Password Input
              CostumPasswordInput(
                hint: "Enter the same password",
                label: "Confirm Password",
                onChanged: (value) =>
                    _onFieldChanged(value, (v) => confirmPassword = v),
                isObscured: _isObscured,
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Gradient Checkboxes Section
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _agreeUpdates,
                    onChanged: (value) {
                      setState(() {
                        _agreeUpdates = value ?? false;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    side: const BorderSide(color: Colors.grey),
                    checkColor: Colors.white,
                    activeColor: Colors.green,
                  ),
                  const Expanded(
                    child: Text(
                      "I agree to receive product updates, announcements, and exclusive offers via email.",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _acceptTerms,
                    onChanged: (value) {
                      setState(() {
                        _acceptTerms = value ?? false;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    side: const BorderSide(color: Colors.grey),
                    checkColor: Colors.white,
                    activeColor: Colors.green,
                  ),
                  Expanded(
                    child: RichText(
                      text: const TextSpan(
                        text: "I accept the ",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                        children: [
                          TextSpan(
                            text: "Terms of Use",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(
                            text: " and ",
                          ),
                          TextSpan(
                            text: "Privacy Policy.",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Continue Button
              AppButton(
                buttonLabel: "Continue",
                onclick: isFormComplete
                    ? () => HelperFunctions.routeReplacdTo(Succee(), context)
                    : null,
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
      ),
    );
  }
}
