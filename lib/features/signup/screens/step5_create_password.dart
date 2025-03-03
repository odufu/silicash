import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:silicash_mobile/core/utils/constants.dart';
import 'package:silicash_mobile/core/widgets/app_button.dart';
import 'package:silicash_mobile/core/utils/helper_functions.dart';
import 'package:silicash_mobile/core/widgets/costum_password_input.dart';
import 'package:silicash_mobile/core/widgets/custom_checkbox.dart';
import '../../login/presentation/pages/login_page.dart';
import '../../login/data/services/login_service.dart';
import '../pages/registration_flow.dart';
import '../pages/signup_page.dart';
import '../provider/registration_provider.dart';
import '../services/registration_service.dart'; // Make sure to import your service

class Step5CreatePasswordScreen extends StatefulWidget {
  final VoidCallback onNext;

  const Step5CreatePasswordScreen({Key? key, required this.onNext})
      : super(key: key);

  @override
  State<Step5CreatePasswordScreen> createState() =>
      _Step5CreatePasswordScreenState();
}

class _Step5CreatePasswordScreenState extends State<Step5CreatePasswordScreen>
    with SingleTickerProviderStateMixin {
  bool _isObscured = false;
  bool _agreeUpdates = false;
  bool _acceptTerms = false;
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  String? password;
  String? confirmPassword;
  String? passwordError;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Validate the password meets:
  /// - Minimum 8 characters,
  /// - Mixed case,
  /// - At least one number and one symbol.
  bool isPasswordValid(String password) {
    final passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$',
    );
    return passwordRegex.hasMatch(password);
  }

  bool get isFormComplete {
    return password != null &&
        confirmPassword != null &&
        password!.isNotEmpty &&
        confirmPassword!.isNotEmpty &&
        password == confirmPassword &&
        isPasswordValid(password!) &&
        _agreeUpdates &&
        _acceptTerms;
  }

  // Update password in local state and provider
  void _onPasswordChanged(String value) {
    setState(() {
      password = value;
      if (password!.isNotEmpty && !isPasswordValid(password!)) {
        passwordError =
            "Password must be at least 8 characters, include mixed case, a number, and a symbol.";
      } else {
        passwordError = null;
      }
    });
    Provider.of<RegistrationProvider>(context, listen: false)
        .setPassword(value);
  }

  void _onConfirmPasswordChanged(String value) {
    setState(() {
      confirmPassword = value;
    });
  }

  /// This function is called when the Continue button is pressed.
  /// It submits all registration details via the RegistrationService.
  Future<void> _onContinue() async {

    
    if (isFormComplete) {
      // Retrieve your registration provider instance.
      final registrationProvider =
          Provider.of<RegistrationProvider>(context, listen: false);

      // Instantiate the service with your base URL.
      // Replace 'https://your.api.url' with your actual base URL.
      final registrationService =
          RegistrationService(baseUrl: Constants.baseUrl);

      try {
        // Submit registration data as form data.
        final result =
            await registrationService.submitRegistration(registrationProvider);

        if (result["success"]) {
          // If successful, show a success message and move to OTP stage.
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration successful!')),
          );
          widget.onNext();
        } else {
          if (result['message'] == "Email already registerd") {
            HelperFunctions.routePushNormalTo(
                LoginPage(loginService: LoginService(Constants.baseUrl)),
                context);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Email Already Exists Please Login")),
            );
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result['message'] ?? "Registration failed")),
          );
        }
        // Navigate to the OTP verification step.
      } catch (error) {
        // On failure, display an error message.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
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
                  hint:
                      "At least 8 characters, mixed case, one number, and one symbol",
                  onChanged: _onPasswordChanged,
                  label: "Enter a Password",
                  isObscured: _isObscured,
                  onPressed: () {
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                ),
                // Display password error if exists
                if (passwordError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      passwordError!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                const SizedBox(height: 20),
                // Confirm Password Input
                CostumPasswordInput(
                  hint: "Enter the same password",
                  label: "Confirm Password",
                  onChanged: _onConfirmPasswordChanged,
                  isObscured: _isObscured,
                  onPressed: () {
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                ),
                const SizedBox(height: 20),
                // Checkboxes Section
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomCheckbox(
                      value: _agreeUpdates,
                      onChanged: (value) {
                        setState(() {
                          _agreeUpdates = value ?? false;
                        });
                      },
                    ),
                    SizedBox(
                      width: 12,
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
                    CustomCheckbox(
                      value: _acceptTerms,
                      onChanged: (value) {
                        setState(() {
                          _acceptTerms = value ?? false;
                        });
                      },
                    ),
                    SizedBox(
                      width: 12,
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
                  onclick: isFormComplete ? _onContinue : null,
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      HelperFunctions.routePushTo(const SignupPage(), context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account? ',
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onSurface)),
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
      ),
      if (_isLoading)
        Center(
          child: Container(
            color: Colors.black54,
            child: Center(
              child: RotationTransition(
                turns: _controller,
                child: Image.asset('assets/images/appAssets/Loader.png',
                    width: 50, height: 50),
              ),
            ),
          ),
        ),
    ]);
  }
}
