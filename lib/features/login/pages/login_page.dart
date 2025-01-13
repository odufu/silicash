import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:silicash_mobile/core/widgets/app_button.dart';

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
        SnackBar(content: Text("Biometric Authentication Failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56), // Height of the custom AppBar
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              IconButton(
                icon: Image.asset("assets/images/brand/arrowLeft.png"),
                onPressed: () {
                  Navigator.pop(context); // Navigate back
                },
              ),
              Text(
                'Back',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
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
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: const TextStyle(fontSize: 16, color: Colors.black),
                hintText: 'Enter Pin (Four digits)',
                hintStyle: TextStyle(fontSize: 14, color: Colors.grey[500]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscured ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                ),
              ),
              obscureText: _isObscured,
              keyboardType: TextInputType.number,
              maxLength: 4,
            ),
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
                    icon: Image.asset("assets/images/appAssets/biometrics.png"),
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
                print("Clicked Login button");
              },
            ),
            const Spacer(),
            Center(
              child: TextButton(
                onPressed: () {
                  // Add create account functionality
                },
                child: const Text('Don’t have an account? Create Account',
                    style: TextStyle(color: Colors.green)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
