import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:provider/provider.dart';
import 'package:silicash_mobile/core/widgets/app_button.dart';
import 'package:silicash_mobile/core/widgets/costum_text_button.dart';
import 'package:silicash_mobile/features/login/pages/login_page.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../core/widgets/country_selection_widet.dart';
import '../../login/services/login_service.dart';
import '../provider/registration_provider.dart';

class Step1CountryLanguage extends StatefulWidget {
  final VoidCallback onNext;
  final void Function(String)? onLanguageSelected;

  const Step1CountryLanguage({
    required this.onNext,
    this.onLanguageSelected,
    Key? key,
  }) : super(key: key);

  @override
  _Step1CountryLanguageState createState() => _Step1CountryLanguageState();
}

class _Step1CountryLanguageState extends State<Step1CountryLanguage> {
  String? _selectedLanguageCode;
  final List<String> supportedLanguageCodes = ["English", "French", "Espaniol"];

  bool get isFormComplete => _selectedLanguageCode != null;

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
    final languageController = TextEditingController(
      text: _selectedLanguageCode != null
          ? (LocaleNames.of(context)?.nameOf(_selectedLanguageCode!) ??
              _selectedLanguageCode!)
          : '',
    );

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What country do you live in?",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          CountrySelectionWidget(
            onCountrySelected: (String countryName) {
              // Optional: Handle country selection if needed in this context
              Provider.of<RegistrationProvider>(context, listen: false)
                  .setCountry(countryName);
            },
            initialCountryName: Provider.of<RegistrationProvider>(context)
                .selectedCountry, // Use selectedCountry instead of countryId
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: languageController,
            readOnly: true,
            onTap: _pickLanguage,
            decoration: InputDecoration(
              labelText: "Language",
              border: OutlineInputBorder(),
              suffixIcon: Image.asset(
                  "assets/images/appAssets/arrowDown.png"), // Adjust path
            ),
          ),
          const Spacer(),
          AppButton(
            buttonLabel: "Continue",
            onclick: isFormComplete ? widget.onNext : null,
          ),
          Center(
            child: TextButton(
              onPressed: () {
                HelperFunctions.routePushTo(
                  LoginPage(
                    loginService: LoginService(Constants.baseUrl),
                  ),
                  context,
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                  Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
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

// Keep LanguageSelectionBottomSheet if needed elsewhere, but it’s not part of this update
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
          const SizedBox(height: 10),
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
