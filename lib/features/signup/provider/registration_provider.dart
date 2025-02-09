import 'package:flutter/material.dart';

import '../screens/step1_country_language.dart';
// Import your custom model (adjust the path as needed)

class RegistrationProvider extends ChangeNotifier {
  // From step 1 (country/language)
  String? selectedCountry;
  String? selectedLanguage;

  // From step 2 (personal info)
  String? firstName;
  String? middleName;
  String? lastName;
  String? gender;
  String? email;
  String? phone;
  String? referralCode;

  // STEP 3 Password
  String? password;

  // Setters for each field that call notifyListeners()
  void setCountry(String country) {
    selectedCountry = country;
    notifyListeners();
  }

  void setLanguage(String language) {
    selectedLanguage = language;
    notifyListeners();
  }

  void setFirstName(String value) {
    firstName = value;
    notifyListeners();
  }

  void setMiddleName(String value) {
    middleName = value;
    notifyListeners();
  }

  void setLastName(String value) {
    lastName = value;
    notifyListeners();
  }

  void setGender(String value) {
    gender = value;
    notifyListeners();
  }

  void setEmail(String value) {
    email = value;
    notifyListeners();
  }

  void setPhone(String value) {
    phone = value;
    notifyListeners();
  }

  void setReferralCode(String value) {
    referralCode = value;
    notifyListeners();
  }

  void setPassword(String value) {
    password = value;
    notifyListeners();
  }
}
