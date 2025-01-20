import 'package:flutter/material.dart';
import 'package:silicash_mobile/core/widgets/app_button.dart';

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
  String? firstName;
  String? middleName;
  String? lastName;
  String? gender;
  String? email;

  // Function to check if all fields are filled
  bool get isFormComplete =>
      firstName != null &&
      firstName!.isNotEmpty &&
      middleName != null &&
      middleName!.isNotEmpty &&
      lastName != null &&
      lastName!.isNotEmpty &&
      gender != null &&
      gender!.isNotEmpty &&
      email != null &&
      email!.isNotEmpty;

  // Function to handle input changes
  void _onFieldChanged(String? value, Function(String?) updateField) {
    setState(() {
      updateField(value);
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
                onChanged: (value) =>
                    _onFieldChanged(value, (v) => firstName = v),
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
                onChanged: (value) =>
                    _onFieldChanged(value, (v) => middleName = v),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text(
                    "Last Name",
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
                onChanged: (value) =>
                    _onFieldChanged(value, (v) => lastName = v),
              ),
              const SizedBox(height: 20),
              Row(
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
                onChanged: (value) => _onFieldChanged(value, (v) => gender = v),
              ),
              // const SizedBox(height: 20),
              // Row(
              //   children: [
              //     Expanded(
              //       flex: 2,
              //       child: TextFormField(
              //         decoration: const InputDecoration(
              //           labelText: "Country Code",
              //           border: OutlineInputBorder(),
              //         ),
              //         onChanged: (value) =>
              //             _onFieldChanged(value, (v) => countryCode = v),
              //       ),
              //     ),
              //     const SizedBox(width: 10),
              //     Expanded(
              //       flex: 5,
              //       child: TextFormField(
              //         decoration: const InputDecoration(
              //           labelText: "Phone Number",
              //           border: OutlineInputBorder(),
              //         ),
              //         onChanged: (value) =>
              //             _onFieldChanged(value, (v) => phoneNumber = v),
              //       ),
              //     ),
              //   ],
              // ),
              const SizedBox(height: 20),
              Row(
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
                onChanged: (value) => _onFieldChanged(value, (v) => email = v),
              ),
              const SizedBox(
                height: 60,
              ),
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
