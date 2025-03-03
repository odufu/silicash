import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:silicash_mobile/core/utils/helper_functions.dart';
import 'package:silicash_mobile/core/widgets/app_button.dart';
import 'package:silicash_mobile/core/widgets/costum_password_input.dart';
import 'package:silicash_mobile/features/home/pages/home_page.dart';
import 'package:silicash_mobile/features/signup/pages/signup_page.dart';
import 'package:silicash_mobile/features/signup/widgets/annimated_circular_widget.dart';

import '../../../../core/widgets/costum_app_bar.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscured = true; // Controls visibility of the password field
  final LocalAuthentication auth =
      LocalAuthentication(); // For biometric authentication

  // Function to handle biometric authentication
  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Confirm fingerprint to continue',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      print("Error during biometric authentication: $e");
    }

    if (authenticated) {
      // Perform login or navigate to the next screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Biometric Authentication Successful")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Biometric Authentication Failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Login',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                const Row(
                  children: [
                    Text(
                      "Email Address",
                      style: TextStyle(),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const TextField(
                  autofillHints: [AutofillHints.email],
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Text(
                      "Password",
                      style: TextStyle(),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                CostumPasswordInput(
                    isObscured: _isObscured,
                    onPressed: () {
                      setState(() {
                        _isObscured = !_isObscured;
                      });
                    },
                    label: "Password",
                    hint: "Enter your Password"),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Add forgot password functionality
                    },
                    child: Text('Forgot Password?',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary)),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Column(
                    children: [
                      IconButton(
                        icon:
                            Image.asset("assets/images/appAssets/biometrics.png"),
                        onPressed: () async {
                          // Trigger biometric authentication
                          await _authenticateWithBiometrics();
                        },
                      ),
                      const Text('Use Biometric Login'),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                AppButton(
                  buttonLabel: "Login",
                  onclick: () {
                    HelperFunctions.routeReplacdTo(HomePage(), context);
                  },
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      HelperFunctions.routePushTo(SignupPage(), context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don’t have an account? ',
                            style: TextStyle(color: Colors.black)),
                        Text('Create Account',
                            style: TextStyle(
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
    );
  }
}
