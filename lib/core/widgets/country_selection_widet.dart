import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For rootBundle
import 'package:provider/provider.dart';
import 'package:silicash_mobile/features/signup/provider/registration_provider.dart';

/// Model for a country loaded from JSON.
class MyCountry {
  final int id;
  final String name;
  final String iso2;
  final String phonecode;
  final String emoji;

  MyCountry({
    required this.id,
    required this.name,
    required this.iso2,
    required this.phonecode,
    required this.emoji,
  });

  factory MyCountry.fromJson(Map<String, dynamic> json) {
    return MyCountry(
      id: json['id'],
      name: json['name'],
      iso2: json['iso2'],
      phonecode: json['phonecode'],
      emoji: json['emoji'],
    );
  }
}

/// Reusable widget for country selection.
class CountrySelectionWidget extends StatefulWidget {
  final void Function(String)?
      onCountrySelected; // Callback for country name selection
  final String? initialCountryName; // Optional initial selected country name

  const CountrySelectionWidget({
    super.key,
    this.onCountrySelected,
    this.initialCountryName,
  });

  @override
  State<CountrySelectionWidget> createState() => _CountrySelectionWidgetState();
}

class _CountrySelectionWidgetState extends State<CountrySelectionWidget> {
  String? _selectedCountryName;
  List<MyCountry> _countries = [];
  bool _isLoading = true;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    _selectedCountryName = widget.initialCountryName;
    loadCountries();
  }

  Future<void> loadCountries() async {
    try {
      String jsonString = await rootBundle.loadString('assets/countries.json');
      final jsonResponse = json.decode(jsonString);
      if (jsonResponse['status'] == true) {
        final List<dynamic> data = jsonResponse['data'];
        setState(() {
          _countries = data.map((item) => MyCountry.fromJson(item)).toList();
          _isLoading = false;
          // Set initial country name if provided or from RegistrationProvider

          final provider =
              Provider.of<RegistrationProvider>(context, listen: false);
          if (widget.initialCountryName != null) {
            _selectedCountryName = widget.initialCountryName;
          } else if (provider.selectedCountry != null &&
              provider.selectedCountry!.isNotEmpty) {
            _selectedCountryName = provider.selectedCountry;
          }
        });
        print("Loaded ${_countries.length} countries");
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print("Error loading countries: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showCountrySelectionBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return CountrySelectionBottomSheet(
          countries: _countries,
          onSelected: (MyCountry country) {
            setState(() {
              _selectedCountryName = country.name;
            });
            Provider.of<RegistrationProvider>(context, listen: false)
                .setCountry(country.name); // Use country name instead of ID
            if (widget.onCountrySelected != null) {
              widget.onCountrySelected!(country.name);
            }
            Navigator.pop(context);
          },
          initialSearchQuery: searchQuery, // Pass current search query
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: TextEditingController(
                  text: _selectedCountryName != null
                      ? "${_findCountryByName(_selectedCountryName)?.emoji ?? ''} ${_selectedCountryName}"
                      : '',
                ),
                readOnly: true,
                onTap: _showCountrySelectionBottomSheet,
                decoration: InputDecoration(
                  labelText: "Country",
                  border: OutlineInputBorder(),
                  prefix: _selectedCountryName != null
                      ? Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            _findCountryByName(_selectedCountryName)?.emoji ??
                                '',
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      : null,
                  suffixIcon: Image.asset(
                      "assets/images/appAssets/arrowDown.png"), // Adjust path
                ),
              ),
              const SizedBox(height: 20), // Consistent spacing
            ],
          );
  }

  // Helper method to find a country by name and return MyCountry, with null handling for empty lists
  MyCountry? _findCountryByName(String? name) {
    if (name == null || name.isEmpty || _countries.isEmpty) return null;
    try {
      return _countries.firstWhere(
        (country) => country.name == name,
        orElse: () => _countries.first, // Default to first country if not found
      );
    } catch (e) {
      print("Error finding country by name: $e");
      return null; // Return null if no country is found or list is empty
    }
  }
}

/// Bottom sheet for country selection, reusable within CountrySelectionWidget.
class CountrySelectionBottomSheet extends StatefulWidget {
  final List<MyCountry> countries;
  final Function(MyCountry) onSelected;
  final String initialSearchQuery; // Optional initial search query

  const CountrySelectionBottomSheet({
    required this.countries,
    required this.onSelected,
    this.initialSearchQuery = "",
    Key? key,
  }) : super(key: key);

  @override
  _CountrySelectionBottomSheetState createState() =>
      _CountrySelectionBottomSheetState();
}

class _CountrySelectionBottomSheetState
    extends State<CountrySelectionBottomSheet> {
  late String searchQuery;

  @override
  void initState() {
    super.initState();
    searchQuery = widget.initialSearchQuery;
  }

  @override
  Widget build(BuildContext context) {
    final filteredCountries = widget.countries
        .where((country) =>
            country.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Search country",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              controller: TextEditingController(text: searchQuery),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: filteredCountries.isEmpty
                  ? Center(child: Text("No country found"))
                  : ListView.builder(
                      itemCount: filteredCountries.length,
                      itemBuilder: (context, index) {
                        final country = filteredCountries[index];
                        return ListTile(
                          leading: Text(
                            country.emoji,
                            style: TextStyle(fontSize: 20),
                          ),
                          title: Text(country.name),
                          onTap: () {
                            widget.onSelected(country);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
