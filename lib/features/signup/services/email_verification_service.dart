import 'dart:convert';
import 'package:http/http.dart' as http;

import '../provider/registration_provider.dart';

class EmailVerificationException implements Exception {
  final String message;
  final int statusCode;

  EmailVerificationException(this.message, this.statusCode);

  @override
  String toString() =>
      "EmailVerificationException: $message (Code: $statusCode)";
}

class EmailVerificationService {
  final String baseUrl;

  EmailVerificationService({required this.baseUrl});

  Future<void> verifyEmail(
      RegistrationProvider provider, String otpCode) async {
    final email = provider.email;
    if (email == null) {
      throw EmailVerificationException("Email not provided", 400);
    }

    final uri = Uri.parse('$baseUrl/auth/email/verify');
    final headers = {'Content-Type': 'multipart/form-data'};
    final request = http.MultipartRequest('POST', uri)
      ..fields['email'] = email
      ..fields['code'] = otpCode;

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        // Parse success response if needed
        final data = json.decode(response.body);
        if (data['status'] == true) {
          print(data);
          return;
        } else {
          print(data["message"]);
          throw EmailVerificationException(
              data['message'] ?? 'Verification failed', response.statusCode);
        }
      } else {
        final errorData = json.decode(response.body);
        print(errorData);

        throw EmailVerificationException(
            errorData['message'] ?? 'Unexpected error', response.statusCode);
      }
    } catch (error) {
      print(error.toString());

      throw EmailVerificationException(error.toString(), 500);
    }
  }
}
