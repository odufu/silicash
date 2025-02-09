import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:silicash_mobile/core/utils/constants.dart';
import 'package:silicash_mobile/features/login/services/login_service.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../core/widgets/app_button.dart';
import '../../login/pages/login_page.dart';
import '../provider/registration_provider.dart';

class Step2PersonalInfo extends StatefulWidget {
  final VoidCallback onNext;

  const Step2PersonalInfo({required this.onNext, Key? key}) : super(key: key);

  @override
  _Step2PersonalInfoState createState() => _Step2PersonalInfoState();
}

class _Step2PersonalInfoState extends State<Step2PersonalInfo> {
  final _formKey = GlobalKey<FormState>();
  bool isFormValid = false;

  // Controllers to handle initial values
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _referralCodeController = TextEditingController();
  String? _selectedGender;
  String? _phoneNumber;
  String? _phoneCountryCode;

  @override
  void initState() {
    super.initState();
    final regProvider =
        Provider.of<RegistrationProvider>(context, listen: false);

    // Initialize fields with saved values
    _firstNameController.text = regProvider.firstName ?? "";
    _middleNameController.text = regProvider.middleName ?? "";
    _lastNameController.text = regProvider.lastName ?? "";
    _emailController.text = regProvider.email ?? "";
    _referralCodeController.text = regProvider.referralCode ?? "";
    _selectedGender = regProvider.gender; // Default to Nigeria
  }

  void validateForm() {
    setState(() {
      isFormValid = _formKey.currentState?.validate() ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final regProvider =
        Provider.of<RegistrationProvider>(context, listen: false);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Row(children: [
                Text("Personal Information",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold))
              ]),
              const SizedBox(height: 20),
              buildTextField("First Name", _firstNameController,
                  regProvider.setFirstName, true),
              buildTextField("Middle Name (Optional)", _middleNameController,
                  regProvider.setMiddleName, false),
              buildTextField("Last Name", _lastNameController,
                  regProvider.setLastName, true),
              buildDropdownField("Gender", ["male", "female", "other"],
                  _selectedGender, regProvider.setGender),
              buildTextField(
                  "Email Address", _emailController, regProvider.setEmail, true,
                  emailValidation: true),
              buildPhoneField(),
              buildTextField("Referral Code (Optional)",
                  _referralCodeController, regProvider.setReferralCode, false),
              const SizedBox(height: 60),
              AppButton(
                  buttonLabel: "Continue",
                  onclick: isFormValid ? widget.onNext : null),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      Function(String) onChanged, bool required,
      {bool emailValidation = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle()),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
              labelText: label, border: const OutlineInputBorder()),
          validator: (value) {
            if (required && (value == null || value.isEmpty))
              return '$label is required';
            if (emailValidation &&
                value != null &&
                !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
              return 'Enter a valid email address';
            }
            return null;
          },
          onChanged: (value) {
            onChanged(value);
            validateForm();
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget buildDropdownField(String label, List<String> options,
      String? selectedValue, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle()),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: selectedValue,
          items: options
              .map(
                  (value) => DropdownMenuItem(value: value, child: Text(value)))
              .toList(),
          decoration: const InputDecoration(border: OutlineInputBorder()),
          validator: (value) => value == null ? '$label is required' : null,
          onChanged: (value) {
            if (value != null) {
              setState(() => _selectedGender = value);
              onChanged(value);
              validateForm();
            }
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget buildPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Phone Number", style: TextStyle()),
        const SizedBox(height: 10),
        IntlPhoneField(
          decoration: InputDecoration(
            labelText: 'Phone Number',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
          initialCountryCode: _phoneCountryCode,
          initialValue: _phoneNumber,
          validator: (phone) => phone == null || phone.number.isEmpty
              ? 'Phone number is required'
              : null,
          onChanged: (phone) {
            Provider.of<RegistrationProvider>(context, listen: false)
                .setPhone(phone.completeNumber);
            validateForm();
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
