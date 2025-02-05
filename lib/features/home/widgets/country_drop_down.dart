import 'package:flutter/material.dart';

class CountryDropDown extends StatefulWidget {
  String? selectedCountry;
  Color? backgroundColor;
  Color? borderColor;

  CountryDropDown({
    this.backgroundColor,
    this.borderColor,
    this.selectedCountry,
    super.key,
  });

  @override
  _CountryDropDownState createState() => _CountryDropDownState();
}

class _CountryDropDownState extends State<CountryDropDown> {
  // List of countries with flags and names
  final List<Map<String, String>> countries = [
    {'name': 'US USD', "flag": 'assets/images/countries/usa.png'},
    {'name': 'Congo CDF', "flag": 'assets/images/countries/congo.png'},
    {'name': 'Nigeria NGN', "flag": 'assets/images/countries/nigeria.jpg'},
    {'name': 'Ghanna GHS', "flag": 'assets/images/countries/ghana.png'},
    {'name': 'UK GBP', "flag": 'assets/images/countries/uk.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 41,
      width: 200,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          color: widget.backgroundColor ??
              Theme.of(context).colorScheme.secondary.withOpacity(.2),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
              color: widget.borderColor ?? Colors.transparent, width: 1)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: widget.selectedCountry,
          hint: Text('Select Currency'),
          icon: Image.asset("assets/images/appAssets/arrowDown.png"),
          style: TextStyle(color: Colors.black, fontSize: 16),
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
                  SizedBox(width: 8),
                  Text(country['name']!),
                  SizedBox(width: 8),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              widget.selectedCountry = value;
            });
          },
        ),
      ),
    );
  }
}
