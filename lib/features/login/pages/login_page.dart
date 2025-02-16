import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:silicash_mobile/core/widgets/app_button.dart';
import 'package:silicash_mobile/core/widgets/costum_password_input.dart';
import 'package:silicash_mobile/features/signup/pages/registration_flow.dart';
import 'package:silicash_mobile/features/signup/pages/signup_page.dart';
import 'package:silicash_mobile/features/signup/screens/step3_otp_screen.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../core/widgets/costum_app_bar.dart';
import '../../home/pages/home_page.dart';
import '../../signup/provider/registration_provider.dart';
import '../services/login_service.dart';

class LoginPage extends StatefulWidget {
  final LoginService loginService;

  const LoginPage({required this.loginService, Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final LocalAuthentication _auth = LocalAuthentication();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  bool _isObscured = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    // Prepopulate email and password if available from the provider.
    // (For initial login you might also prepopulate from secure storage if desired.)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final registrationProvider =
          Provider.of<RegistrationProvider>(context, listen: false);
      _emailController.text = registrationProvider.email ?? '';
      _passwordController.text = registrationProvider.password ?? '';
    });
  }

  /// Stores the email and password securely.
  Future<void> _storeCredentials() async {
    await _secureStorage.write(
        key: 'email', value: _emailController.text.trim());
    await _secureStorage.write(
        key: 'password', value: _passwordController.text);
  }

  /// Retrieves stored credentials and sets the text controllers.
  /// Returns true if both values were found.
  Future<bool> _retrieveCredentials() async {
    String? email = await _secureStorage.read(key: 'email');
    String? password = await _secureStorage.read(key: 'password');
    if (email != null && password != null) {
      _emailController.text = email;
      _passwordController.text = password;
      return true;
    }
    return false;
  }

  /// Authenticates the user with biometrics and then automatically logs in using saved credentials.
  Future<void> _authenticateWithBiometrics() async {
    try {
      final isAuthenticated = await _auth.authenticate(
        localizedReason: 'Use your biometrics to log in',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );

      if (isAuthenticated) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Biometric Authentication Successful")),
        );
        // Retrieve credentials from secure storage.
        bool credentialsRetrieved = await _retrieveCredentials();
        if (credentialsRetrieved &&
            _emailController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty) {
          await _handleLogin();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("No stored credentials. Please login manually.")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Biometric Authentication Failed")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error during biometric authentication: $e")),
      );
    }
  }

  /// Handles login using email and password.
  /// On success, credentials are saved securely for future biometric login.
  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final result = await widget.loginService.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (result['success']) {
        // Save the credentials in secure storage so that biometric login can use them later.
        await _storeCredentials();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login successful!")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['message'] ?? "Login failed")),
        );

        if (result['message'] ==
            "Email is not verified, kindly verify your email to proceed.") {
          HelperFunctions.routePushNormalTo(
              RegistrationFlow(
                initialPageIndex: 3,
              ),
              context);
        }
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
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
            const Text(
              "Email Address",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                Provider.of<RegistrationProvider>(context, listen: false)
                    .setEmail(value);
              },
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            const Text(
              "Password",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            CostumPasswordInput(
              passwordController: _passwordController,
              isObscured: _isObscured,
              onChanged: (p0) {
                Provider.of<RegistrationProvider>(context, listen: false)
                    .setEmail(p0);
              },
              label: "Password",
              hint: "Enter your password",
              onPressed: () {
                setState(() {
                  _isObscured = !_isObscured;
                });
              },
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // TODO: Add forgot password functionality
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  IconButton(
                    icon: Image.asset("assets/images/appAssets/biometrics.png"),
                    onPressed: _authenticateWithBiometrics,
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
            Center(
              child: TextButton(
                onPressed: () {
                  HelperFunctions.routePushTo(const SignupPage(), context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don’t have an account? ',
                        style: TextStyle(color: Colors.black)),
                    Text('Create Account',
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
