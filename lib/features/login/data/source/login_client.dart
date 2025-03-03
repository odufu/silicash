import 'dart:convert';

import 'package:silicash_mobile/features/login/repository/login_contract.dart';
import 'package:http/http.dart' as http;

class LoginClient implements LoginContract {
  final String baseUrl;

  LoginClient(this.baseUrl);

  @override
  Future<dynamic> login(String email, String password) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse("$baseUrl/auth/sign-in"),
    );
    request.fields['email'] = email;
    request.fields['password'] = password;

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }
}
