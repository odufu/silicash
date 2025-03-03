import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:silicash_mobile/features/login/data/services/login_service.dart';

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

  Future<void> verifyEmail(RegistrationProvider provider,
      LoginService loginService, String otpCode) async {
    final email = provider.email;
    final password = provider.password;
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

          // login
          final loginResult =
              await loginService.login(email: email, password: password ?? "");
          final token = loginResult["data"]["token"];
          //save token to secured storage
          print(token);

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
