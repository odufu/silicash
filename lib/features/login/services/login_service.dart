import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {
  final String baseUrl;

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
        return {'success': true, 'data': data};
      } else {
        return {
          'success': false,
          'message': jsonDecode(response.body)['error'] ?? 'Login failed'
        };
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }
}
