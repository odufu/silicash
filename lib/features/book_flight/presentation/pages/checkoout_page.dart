import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:silicash_mobile/core/theme/app_theme_extension.dart';
import 'package:silicash_mobile/core/widgets/app_button.dart'; // Adjust import if needed
import 'package:silicash_mobile/core/widgets/costum_app_bar.dart'; // Adjust import if needed
import 'package:silicash_mobile/features/airtime/widgets/phone_number_input.dart';
import '../../../../core/widgets/country_selection_widet.dart';
import '../../../signup/provider/registration_provider.dart';
import 'payment_confirmation_page.dart';

class CheckoutPage extends StatefulWidget {
  final Map<String, dynamic> flight; // Pass flight data from the previous page
  final String departureDate; // Pass departure date (e.g., "Wed, Mar 15")
  final String route; // Pass route (e.g., "Uyo - Abuja")

  const CheckoutPage({
    super.key,
    required this.flight,
    required this.departureDate,
    required this.route,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>(); // For form validation
  String? _title = 'Mr'; // Default title
  String? _surname = '';
  String? _firstName = '';
  String? _middleName = '';
  String? _nationality; // Use String for nationality to match selectedCountry
  String? _gender = 'Male'; // Default gender
  DateTime? _dateOfBirth;
  String? _email = 'benjoe@trippadi';
  String? _phoneNumber = '+234 089 987 6543'; // Default phone number
  String? _countryCode = '+234'; // Default country code

  // Lists for dropdowns
  final List<String> _titles = ['Mr', 'Mrs', 'Ms', 'Dr'];
  final List<String> _genders = ['Male', 'Female'];
  final List<String> _countryCodes = ['+234', '+233', '+27', '+254'];

  Future<void> _selectDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && mounted) {
      setState(() {
        _dateOfBirth = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Safely access flight data
    final airline = widget.flight['airline'] as String? ?? 'Not available';
    final time = (widget.flight['outbound'] as Map<String, dynamic>? ??
            {})['time'] as String? ??
        'Not available';
    final duration = (widget.flight['outbound'] as Map<String, dynamic>? ??
            {})['duration'] as String? ??
        'Not available';

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: CustomAppBar(), // Using your custom app bar with static title
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Trip Summary Card (Header)
              Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                color: Theme.of(context)
                        .extension<AppThemeExtension>()
                        ?.cardColor(context) ??
                    Colors.grey[100], // Light background as in image
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Depart ${widget.route} ${widget.departureDate}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            time
                                .split(' - ')
                                .first, // Only show the departure time (e.g., "01:15")
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Icon(
                            Icons
                                .expand_more, // Green chevron (down arrow) icon
                            color: Colors.green,
                            size: 24.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Secure Booking Section
              Text(
                'Secure booking',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                "Who's Traveling?",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'No worries, your personal data is secured!',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Icon(
                    Icons.lock, // Lock icon as shown
                    color: Colors.green,
                    size: 16,
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                'N/B: Ensure your name is exactly as they appear on your Passport/ID to avoid complications.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16.0),

              // Passenger Form
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Passenger 1: 1 Adult, primary contact',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 16.0),

                    // Surname
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Surname *',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                      ),
                      initialValue: _surname,
                      onChanged: (value) => _surname = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter surname';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8.0),

                    // Title (Dropdown) and First Name
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: DropdownButtonFormField<String>(
                            value: _title,
                            items: _titles.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _title = newValue;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Title',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              filled: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'First Name *',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              filled: true,
                            ),
                            initialValue: _firstName,
                            onChanged: (value) => _firstName = value,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter first name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),

                    // Middle Name
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Middle Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                      ),
                      initialValue: _middleName,
                      onChanged: (value) => _middleName = value,
                    ),
                    const SizedBox(height: 8.0),

                    // Nationality (Using CountrySelectionWidget)
                    CountrySelectionWidget(
                      onCountrySelected: (String countryName) {
                        setState(() {
                          _nationality = countryName;
                        });
                      },
                      initialCountryName: Provider.of<RegistrationProvider>(
                              context)
                          .selectedCountry, // Use selectedCountry instead of countryId
                    ),
                    const SizedBox(height: 8.0),

                    // Gender (Dropdown)
                    DropdownButtonFormField<String>(
                      value: _gender,
                      items: _genders.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _gender = newValue;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Gender *',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select gender';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8.0),

                    // Date of Birth
                    InkWell(
                      onTap: () => _selectDateOfBirth(context),
                      child: IgnorePointer(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Date of Birth *',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            filled: true,
                            suffixIcon: const Icon(Icons.calendar_today),
                          ),
                          controller: TextEditingController(
                            text: _dateOfBirth != null
                                ? '${_dateOfBirth!.day}/${_dateOfBirth!.month}/${_dateOfBirth!.year}'
                                : '',
                          ),
                          validator: (value) {
                            if (_dateOfBirth == null) {
                              return 'Please select date of birth';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),

                    // Confirmation Email
                    Text(
                      'Where should we send your confirmation?',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                      ),
                      initialValue: _email,
                      onChanged: (value) => _email = value,
                    ),
                    const SizedBox(height: 8.0),

                    // Phone Number
                    PhoneNumberInput()
                  ],
                ),
              ),
              const SizedBox(height: 16.0),

              // Pay Button
              Center(
                child: AppButton(
                  buttonLabel: 'Pay',
                  onclick: () {
                    if (_formKey.currentState!.validate()) {
                      // Implement payment logic here
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentConfirmationPage(
                            amount: widget.flight['price'] ??
                                '₦140,000', // Example price from flight data
                            balance:
                                '₦300,000', // Example balance (fetch from user data or state)
                            dateTime: DateTime.now()
                                .toString()
                                .split(' ')[0]
                                .replaceAll(
                                    '-', '/'), // Example format "14/02/25"
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
