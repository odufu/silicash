import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For rootBundle
import 'package:flutter_localized_locales/flutter_localized_locales.dart'; // For localized language names
import 'package:provider/provider.dart';
import 'package:silicash_mobile/core/widgets/app_button.dart';
import 'package:silicash_mobile/core/widgets/costum_text_button.dart';
import 'package:silicash_mobile/features/login/pages/login_page.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/helper_functions.dart';
import '../../login/services/login_service.dart';
import '../provider/registration_provider.dart';

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

class Step1CountryLanguage extends StatefulWidget {
  final VoidCallback onNext;
  final void Function(MyCountry)? onCountrySelected;
  final void Function(String)? onLanguageSelected;

  Step1CountryLanguage({
    required this.onNext,
    this.onCountrySelected,
    this.onLanguageSelected,
    Key? key,
  }) : super(key: key);

  @override
  _Step1CountryLanguageState createState() => _Step1CountryLanguageState();
}

class _Step1CountryLanguageState extends State<Step1CountryLanguage> {
  MyCountry? _selectedCountry;
  String? _selectedLanguageCode;
  List<MyCountry> _countries = [];
  bool _isLoading = true;

  final List<String> supportedLanguageCodes = ["en", "fr", "es"];

  bool get isFormComplete =>
      _selectedCountry != null && _selectedLanguageCode != null;

  @override
  void initState() {
    super.initState();
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
              _selectedCountry = country;
            });
            Provider.of<RegistrationProvider>(context, listen: false)
                .setCountry(country.id.toString());
            print(
                "Provider updated with country: ${country.name}, id: ${country.id}");
            if (widget.onCountrySelected != null) {
              widget.onCountrySelected!(country);
            }
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void _pickLanguage() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return LanguageSelectionBottomSheet(
          supportedLanguageCodes: supportedLanguageCodes,
          onSelected: (String langCode) {
            setState(() {
              _selectedLanguageCode = langCode;
            });
            Provider.of<RegistrationProvider>(context, listen: false)
                .setLanguage(langCode);
            if (widget.onLanguageSelected != null) {
              widget.onLanguageSelected!(langCode);
            }
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final countryController = TextEditingController(
      text: _selectedCountry != null
          ? "${_selectedCountry!.emoji} ${_selectedCountry!.name}"
          : '',
    );
    final languageController = TextEditingController(
      text: _selectedLanguageCode != null
          ? (LocaleNames.of(context)?.nameOf(_selectedLanguageCode!) ??
              _selectedLanguageCode!)
          : '',
    );

    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "What country do you live in?",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: countryController,
                  readOnly: true,
                  onTap: _showCountrySelectionBottomSheet,
                  decoration: InputDecoration(
                    labelText: "Country",
                    border: OutlineInputBorder(),
                    prefix: _selectedCountry != null
                        ? Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              _selectedCountry!.emoji,
                              style: TextStyle(fontSize: 20),
                            ),
                          )
                        : null,
                    suffixIcon:
                        Image.asset("assets/images/appAssets/arrowDown.png"),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: languageController,
                  readOnly: true,
                  onTap: _pickLanguage,
                  decoration: InputDecoration(
                    labelText: "Language",
                    border: OutlineInputBorder(),
                    suffixIcon:
                        Image.asset("assets/images/appAssets/arrowDown.png"),
                  ),
                ),
                Spacer(),
                AppButton(
                  buttonLabel: "Continue",
                  onclick: isFormComplete ? widget.onNext : null,
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      HelperFunctions.routePushTo(LoginPage(loginService: LoginService(Constants.baseUrl),), context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account? ',
                            style: TextStyle(color: Colors.black)),
                        Text(
                          'Login',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

class CountrySelectionBottomSheet extends StatefulWidget {
  final List<MyCountry> countries;
  final Function(MyCountry) onSelected;

  const CountrySelectionBottomSheet({
    required this.countries,
    required this.onSelected,
    Key? key,
  }) : super(key: key);

  @override
  _CountrySelectionBottomSheetState createState() =>
      _CountrySelectionBottomSheetState();
}

class _CountrySelectionBottomSheetState
    extends State<CountrySelectionBottomSheet> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final filteredCountries = widget.countries
        .where((country) =>
            country.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
    // Access the RegistrationProvider to update and read personal info.
    final regProvider =
        Provider.of<RegistrationProvider>(context, listen: false);
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
            ),
            SizedBox(height: 10),
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

class LanguageSelectionBottomSheet extends StatelessWidget {
  final List<String> supportedLanguageCodes;
  final Function(String) onSelected;

  const LanguageSelectionBottomSheet({
    required this.supportedLanguageCodes,
    required this.onSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Search language",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onChanged: (value) {
              // Optionally implement search filtering.
            },
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: supportedLanguageCodes.map((langCode) {
                String languageName =
                    LocaleNames.of(context)?.nameOf(langCode) ?? langCode;
                return ListTile(
                  title: Text(languageName),
                  onTap: () {
                    onSelected(langCode);
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
