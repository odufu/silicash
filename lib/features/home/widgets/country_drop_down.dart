import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Define a simple model for Country
class Country {
  final int id;
  final String name;
  final String emoji;

  Country({
    required this.id,
    required this.name,
    required this.emoji,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      name: json['name'],
      emoji: json['emoji'] ?? '', // fallback in case emoji is null
    );
  }
}



class CountryDropDown extends StatefulWidget {
  final Color? backgroundColor;
  final Color? borderColor;
  // Callback to return the selected country ID to the parent
  final Function(int)? onCountryChanged;

  CountryDropDown({
    this.backgroundColor,
    this.borderColor,
    this.onCountryChanged,
    Key? key,
  }) : super(key: key);

  @override
  _CountryDropDownState createState() => _CountryDropDownState();
}

class _CountryDropDownState extends State<CountryDropDown> {
  List<Country> _countries = [];
  Country? _selectedCountry;

  @override
  void initState() {
    super.initState();
    fetchCountries();
  }

  // Fetch countries from the API
  Future<void> fetchCountries() async {
    final url = 'https://prod-api.silicash.com/api/v1/general/countries';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == true) {
          final List<dynamic> data = jsonResponse['data'];
          setState(() {
            _countries = data.map((item) => Country.fromJson(item)).toList();
            // Optionally, select the first country by default
            if (_countries.isNotEmpty) {
              _selectedCountry = _countries[0];
              widget.onCountryChanged?.call(_selectedCountry!.id);
            }
          });
        } else {
          // Handle a valid response with error message from the API
          print('Error: ${jsonResponse['message']}');
        }
      } else {
        print('Failed to load countries. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching countries: $e');
    }
  }

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
          color: widget.borderColor ?? Colors.transparent,
          width: 1,
        ),
      ),
      child: _countries.isEmpty
          ? Center(child: CircularProgressIndicator())
          : DropdownButtonHideUnderline(
              child: DropdownButton<Country>(
                isExpanded: true,
                value: _selectedCountry,
                hint: Text('Select Country'),
                icon: Image.asset("assets/images/appAssets/arrowDown.png"),
                style: TextStyle(color: Colors.black, fontSize: 16),
                items: _countries.map((Country country) {
                  return DropdownMenuItem<Country>(
                    value: country,
                    child: Row(
                      children: [
                        Text(country.emoji, style: TextStyle(fontSize: 20)),
                        SizedBox(width: 8),
                        Text(country.name),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (Country? newCountry) {
                  setState(() {
                    _selectedCountry = newCountry;
                  });
                  // Return the selected country's ID to the parent widget
                  if (newCountry != null) {
                    widget.onCountryChanged?.call(newCountry.id);
                  }
                },
              ),
            ),
    );
  }
}
