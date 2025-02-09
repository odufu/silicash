import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:silicash_mobile/core/widgets/app_button.dart';
import 'package:silicash_mobile/core/widgets/costum_password_input.dart';
import '../../../core/widgets/costum_app_bar.dart';
import '../../home/pages/home_page.dart';
import '../../signup/provider/registration_provider.dart';
import '../services/login_service.dart';

class LoginPage extends StatefulWidget {
  final LoginService loginService;

  const LoginPage({required this.loginService});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscured = true; // Controls visibility of the password field

  bool _isLoading = false;
  final LocalAuthentication auth =
      LocalAuthentication(); // For biometric authentication

  @override
  void initState() {
    super.initState();

    // Access RegistrationProvider to prepopulate email and password
    final registrationProvider =
        Provider.of<RegistrationProvider>(context, listen: false);
    if (registrationProvider.email != null) {
      _emailController.text = registrationProvider.email!;
    }
    if (registrationProvider.password != null) {
      _passwordController.text = registrationProvider.password!;
    }
  }

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

  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
    });

    // Call the login service
    final result = await widget.loginService.login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (result['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login successful!")),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'] ?? "Login failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
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
              passwordController: _passwordController,
              isObscured: _isObscured,
              label: "Password",
              hint: "Enter your password",
              onPressed: () {
                setState(() {
                  _isObscured = !_isObscured;
                  _passwordController.text = _passwordController.text.isEmpty
                      ? " "
                      : _passwordController.text;
                });
              },
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
              buttonLabel: _isLoading ? "Logging in..." : "Login",
              onclick: _isLoading ? null : _handleLogin,
            ),
          ],
        ),
      ),
    );
  }
}
