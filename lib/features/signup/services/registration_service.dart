import 'dart:convert';
import 'package:http/http.dart' as http;
import '../provider/registration_provider.dart';

class RegistrationService {
  final String baseUrl;

  RegistrationService({required this.baseUrl});

  /// Submits all registration details as form data to the sign-up endpoint.
  Future<Map<String, dynamic>> submitRegistration(
      RegistrationProvider provider) async {
    final url = Uri.parse('$baseUrl/auth/sign-up');

    // Build the form-data payload from provider details.
    final Map<String, String> formData = {
      // Use the numeric ID of the selected country, converted to string.
      'country_id': provider.selectedCountry.toString() ?? '',
      'language': provider.selectedLanguage ?? '', // Uncomment if needed
      'first_name': provider.firstName ?? '',
      'middle_name': provider.middleName ?? '',
      'last_name': provider.lastName ?? '',
      'gender': provider.gender ?? '',
      'email': provider.email ?? '',
      'phone_number': provider.phone ?? '',
      'referral_id': '', // Adjust if you use referral codes.
      'password': provider.password ?? '',
    };

    try {
      // Sending a POST request with a Map body automatically encodes it as
      // application/x-www-form-urlencoded.
      print(formData);
      final response = await http.post(url, body: formData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return {'success': true, 'data': data};
      } else {
        // Handle server errors.
        print('Registration failed: ${response.statusCode} - ${response.body}');
        return {
          'success': false,
          'message':
              jsonDecode(response.body)['message'] ?? 'Registration failed'
        };
      }
    } catch (error) {
      // Catch and rethrow or handle the error appropriately.
      print('Error during registration: $error');
      return {'success': false, 'message': error.toString()};
    }
  }
}
