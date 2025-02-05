import 'package:flutter/material.dart';
import 'package:silicash_mobile/core/widgets/app_button.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../core/utils/helper_functions.dart';
import '../../login/pages/login_page.dart';

class Step2PersonalInfo extends StatefulWidget {
  final VoidCallback onNext;

  const Step2PersonalInfo({required this.onNext});

  @override
  _Step2PersonalInfoState createState() => _Step2PersonalInfoState();
}

class _Step2PersonalInfoState extends State<Step2PersonalInfo> {
  final _formKey = GlobalKey<FormState>();
  bool isFormValid = false;

  // Function to validate the entire form
  void validateForm() {
    setState(() {
      isFormValid = _formKey.currentState?.validate() ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Row(
                children: [
                  Text(
                    "Personal Information",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text(
                    "First Name (as seen on your ID)",
                    style: TextStyle(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextFormField(
                autofillHints: [AutofillHints.givenName],
                decoration: const InputDecoration(
                  labelText: "First Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'First Name is required';
                  }
                  return null;
                },
                onChanged: (value) => validateForm(),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text(
                    "Middle Name (Optional)",
                    style: TextStyle(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextFormField(
                autofillHints: [AutofillHints.middleName],
                decoration: const InputDecoration(
                  labelText: "Middle Name",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => validateForm(),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text(
                    "Last Name (as seen on your ID)",
                    style: TextStyle(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextFormField(
                autofillHints: [AutofillHints.familyName],
                decoration: const InputDecoration(
                  labelText: "Last Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Last Name is required';
                  }
                  return null;
                },
                onChanged: (value) => validateForm(),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text(
                    "Gender",
                    style: TextStyle(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                icon: Image.asset("assets/images/appAssets/arrowDown.png"),
                decoration: const InputDecoration(
                  labelText: "Gender",
                  border: OutlineInputBorder(),
                ),
                items: ["Male", "Female", "Other"]
                    .map((genderOption) => DropdownMenuItem(
                        value: genderOption, child: Text(genderOption)))
                    .toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Gender is required';
                  }
                  return null;
                },
                onChanged: (value) => validateForm(),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text(
                    "Email Address",
                    style: TextStyle(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextFormField(
                autofillHints: [AutofillHints.email],
                decoration: const InputDecoration(
                  labelText: "Email Address",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
                onChanged: (value) => validateForm(),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text(
                    "Phone Number",
                    style: TextStyle(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              IntlPhoneField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(),
                  ),
                ),
                initialCountryCode: 'NG', // Nigeria as the default country
                validator: (phone) {
                  if (phone == null || phone == "") {
                    return 'Phone number is required';
                  }
                  return null;
                },
                onChanged: (phone) {
                  validateForm();
                },
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text(
                    "Referral Code (Optional)",
                    style: TextStyle(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Referral code",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => validateForm(),
              ),
              const SizedBox(
                height: 60,
              ),
              AppButton(
                buttonLabel: "Continue",
                onclick: isFormValid ? widget.onNext : null,
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
                              decorationStyle: TextDecorationStyle.solid,
                              decoration: TextDecoration.underline,
                              color: Theme.of(context).colorScheme.primary)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
