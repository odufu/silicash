import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:silicash_mobile/features/signup/provider/registration_provider.dart';

class ResendOtpService {
  final String baseUrl;

  ResendOtpService({required this.baseUrl});

  Future<void> resendOtp(RegistrationProvider provider) async {
    final url = Uri.parse('$baseUrl/auth/email/get-otp');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'email': provider.email,
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == true) {
          // OTP sent successfully
          return;
        } else {
          throw Exception(responseData['message']);
        }
      } else {
        throw Exception('Failed to resend OTP: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}
