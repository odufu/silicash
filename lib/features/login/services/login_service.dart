import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginService {
  final String baseUrl;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  LoginService(this.baseUrl);

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      // Build the form-data body
      final request = http.MultipartRequest(
        'POST',
        Uri.parse("$baseUrl/auth/sign-in"),
      );
      request.fields['email'] = email;
      request.fields['password'] = password;

      // Send the request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Extract important details
        final String token = data['token'];
        final String refreshToken = data['user_details']['refresh_token'];
        final String userId = data['user_details']['uuid'];
        final String email = data['user_details']['email'];
        final String phone = data['user_details']['phone'];
        final String firstName = data['user_details']['profile']['first_name'];
        final String fullName = data['user_details']['profile']['full_name'];
        final int expiresIn = data['expires_in'];

        // Store securely
        await secureStorage.write(key: 'token', value: token);
        await secureStorage.write(key: 'refreshToken', value: refreshToken);
        await secureStorage.write(key: 'userId', value: userId);
        await secureStorage.write(key: 'email', value: email);
        await secureStorage.write(key: 'phone', value: phone);
        await secureStorage.write(key: 'fullName', value: fullName);
        await secureStorage.write(key: 'firstName', value: firstName);
        await secureStorage.write(
            key: 'expiresIn', value: expiresIn.toString());

        return {'success': true, 'data': data};
      } else {
        return {
          'success': false,
          'message': jsonDecode(response.body)['message'] ?? 'Login failed'
        };
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // Retrieve stored credentials
  Future<Map<String, String?>> getStoredCredentials() async {
    final token = await secureStorage.read(key: 'token');
    final refreshToken = await secureStorage.read(key: 'refreshToken');
    final userId = await secureStorage.read(key: 'userId');
    final email = await secureStorage.read(key: 'email');
    final phone = await secureStorage.read(key: 'phone');
    final fullName = await secureStorage.read(key: 'fullName');

    return {
      'token': token,
      'refreshToken': refreshToken,
      'userId': userId,
      'email': email,
      'phone': phone,
      'fullName': fullName,
    };
  }

  Future<void> logout() async {
    await secureStorage.deleteAll();
  }
}
