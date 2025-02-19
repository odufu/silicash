import 'package:flutter/material.dart';
import 'package:silicash_mobile/core/widgets/app_button.dart';
import 'package:silicash_mobile/core/widgets/costum_password_input.dart';
import 'package:silicash_mobile/features/signup/screens/success.dart';

import '../../../core/utils/constants.dart';
import '../../../core/utils/helper_functions.dart';
import '../../login/pages/login_page.dart';
import '../../login/services/login_service.dart';

class Step4CreatePinScreen extends StatefulWidget {
  final VoidCallback onNext;

  Step4CreatePinScreen({required this.onNext});

  @override
  State<Step4CreatePinScreen> createState() => _Step4CreatePinScreenState();
}

class _Step4CreatePinScreenState extends State<Step4CreatePinScreen> {
  final _formKey = GlobalKey<FormState>();
  String? pin;
  String? confirmPin;

  // Function to check if all fields are filled
  bool get isFormComplete =>
      pin != null &&
      pin!.isNotEmpty &&
      confirmPin != null &&
      confirmPin!.isNotEmpty &&
      pin == confirmPin;

  // Function to handle input changes
  void _onFieldChanged(String? value, Function(String?) updateField) {
    setState(() {
      updateField(value);
    });
  }

  bool _isObscure = true;

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
                isObscured: _isObscure,
                label: "Enter Pin",
                hint: "Enter a 4 digit Pin",
                keyboardType: TextInputType.number,
                maxLength: 4,
                onChanged: (value) => _onFieldChanged(value, (v) => pin = v),
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
                onChanged: (value) =>
                    _onFieldChanged(value, (v) => confirmPin = v),
                keyboardType: TextInputType.number,
                maxLength: 4,
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
                  onclick: isFormComplete
                      ? () => HelperFunctions.routeReplacdTo(
                          Succee(
                            title: "Account Successfully Created",
                            message:
                                "Your account has been successfully created.",
                          ),
                          context)
                      : null),
              Center(
                child: TextButton(
                  onPressed: () {
                    HelperFunctions.routePushTo(
                        LoginPage(
                          loginService: LoginService(Constants.baseUrl),
                        ),
                        context);
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
        ),
      ),
    );
  }
}
