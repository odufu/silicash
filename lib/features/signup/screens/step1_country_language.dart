import 'package:flutter/material.dart';
import 'package:silicash_mobile/core/widgets/app_button.dart';
import 'package:silicash_mobile/core/widgets/costum_text_button.dart';
import 'package:silicash_mobile/features/login/pages/login_page.dart';

import '../../../core/utils/helper_functions.dart';

class Step1CountryLanguage extends StatefulWidget {
  final VoidCallback onNext;

  Step1CountryLanguage({required this.onNext});

  @override
  _Step1CountryLanguageState createState() => _Step1CountryLanguageState();
}

class _Step1CountryLanguageState extends State<Step1CountryLanguage> {
  String? selectedCountry;
  String? selectedLanguage;

  // Function to check if both dropdowns are selected
  bool get isFormComplete =>
      selectedCountry != null && selectedLanguage != null;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "What country do you live in?",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              icon: Image.asset("assets/images/appAssets/arrowDown.png"),
              decoration: InputDecoration(
                labelText: "Country",
                border: OutlineInputBorder(),
              ),
              items: ["Nigeria", "USA", "Canada"]
                  .map((country) =>
                      DropdownMenuItem(value: country, child: Text(country)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCountry = value;
                });
              },
              value: selectedCountry,
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              icon: Image.asset("assets/images/appAssets/arrowDown.png"),
              decoration: InputDecoration(
                labelText: "Language",
                border: OutlineInputBorder(),
              ),
              items: ["English (UK)", "French", "Spanish"]
                  .map((lang) =>
                      DropdownMenuItem(value: lang, child: Text(lang)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedLanguage = value;
                });
              },
              value: selectedLanguage,
            ),
            Spacer(),
            AppButton(
              buttonLabel: "Continue",
              onclick: isFormComplete ? widget.onNext : null,
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  HelperFunctions.routePushTo(LoginPage(), context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account? ',
                        style: TextStyle(color: Colors.black)),
                    Text('Login',
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
