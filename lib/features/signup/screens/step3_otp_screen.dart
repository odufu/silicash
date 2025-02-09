import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:silicash_mobile/features/login/services/login_service.dart';
import '../../../core/utils/constants.dart';
import '../../../core/widgets/app_button.dart';
import '../../login/pages/login_page.dart';
import '../provider/registration_provider.dart';
import '../services/email_verification_service.dart';
import '../services/resend_otp_service.dart';

class Step3OtpScreen extends StatefulWidget {
  final VoidCallback onNext;

  const Step3OtpScreen({Key? key, required this.onNext}) : super(key: key);

  @override
  _Step3OtpScreenState createState() => _Step3OtpScreenState();
}

class _Step3OtpScreenState extends State<Step3OtpScreen> {
  final List<String> otpValues = List.filled(6, ""); // Stores OTP input.
  bool _isLoading = false;
  int _secondsRemaining = 30; // Countdown timer duration.
  Timer? _timer;

  bool get isOtpComplete => otpValues.every((value) => value.isNotEmpty);

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    setState(() {
      _secondsRemaining = 30;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _onOtpChanged(String value, int index) {
    setState(() {
      otpValues[index] = value;
    });
  }

  void _clearOtpFields() {
    setState(() {
      otpValues.fillRange(0, otpValues.length, "");
    });
  }

  Future<void> _verifyOtp() async {
    if (!isOtpComplete) return;

    setState(() {
      _isLoading = true;
    });

    final otpCode = otpValues.join();
    final registrationProvider =
        Provider.of<RegistrationProvider>(context, listen: false);
    final emailVerificationService =
        EmailVerificationService(baseUrl: Constants.baseUrl);

    try {
      await emailVerificationService.verifyEmail(registrationProvider, otpCode);
      widget.onNext();
    } on EmailVerificationException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error ${e.statusCode}: ${e.message}"),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Unexpected error: $error"),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final registrationProvider =
        Provider.of<RegistrationProvider>(context, listen: false);
    final emailDisplay = registrationProvider.email ?? "your email";

    return WillPopScope(
      onWillPop: () async => false, // Disable back navigation.
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Verify Email"),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(
                  "Please provide the OTP sent to this email:",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Text(
                  emailDisplay,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "OTP expires in $_secondsRemaining seconds",
                  style: const TextStyle(fontSize: 16, color: Colors.red),
                ),
                const SizedBox(height: 20),
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
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _secondsRemaining == 0
                          ? () async {
                              try {
                                final resendOtpService = ResendOtpService(
                                    baseUrl: Constants.baseUrl);
                                await resendOtpService.resendOtp(
                                    registrationProvider); // Pass the email
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "OTP has been resent successfully!")),
                                );
                                _clearOtpFields();
                                _startCountdown(); // Restart the countdown after resending OTP
                              } catch (error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Error resending OTP: $error")),
                                );
                              }
                            }
                          : null,
                      child: Text(
                        "Resend OTP",
                        style: TextStyle(
                          color: _secondsRemaining == 0
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                AppButton(
                  buttonLabel: _isLoading ? "Verifying..." : "Continue",
                  onclick: isOtpComplete && !_isLoading ? _verifyOtp : null,
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => LoginPage(
                            loginService: LoginService(Constants.baseUrl),
                          ),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account? ',
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
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
