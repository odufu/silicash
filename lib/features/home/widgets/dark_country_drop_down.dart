import 'package:flutter/material.dart';

class DarkCountryDropDown extends StatefulWidget {
  @override
  _DarkCountryDropDownState createState() => _DarkCountryDropDownState();
}

class _DarkCountryDropDownState extends State<DarkCountryDropDown> {
  // List of countries with flags and names
  final List<Map<String, String>> countries = [
    {'name': 'US USD', "flag": 'assets/images/countries/usa.png'},
    {'name': 'Congo CDF', "flag": 'assets/images/countries/congo.png'},
    {'name': 'Nigeria NGN', "flag": 'assets/images/countries/nigeria.jpg'},
    {'name': 'Ghanna GHS', "flag": 'assets/images/countries/ghana.png'},
    {'name': 'UK GBP', "flag": 'assets/images/countries/uk.png'},
  ];

  String? selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 41,
      width: 200,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary.withOpacity(0),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.white)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: selectedCountry,
          dropdownColor: Theme.of(context).colorScheme.primary,
          hint: const Text(
            'Select a Country',
            style: TextStyle(color: Colors.white),
          ),
          icon: const Icon(Icons.arrow_drop_down),
          style: const TextStyle(color: Colors.white, fontSize: 16),
          items: countries.map((country) {
            return DropdownMenuItem<String>(
              value: country['name'],
              child: Row(
                children: [
                  Image.asset(
                    country['flag']!,
                    width: 16,
                    height: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(country['name']!),
                  const SizedBox(width: 8),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedCountry = value;
            });
          },
        ),
      ),
    );
  }
}
