import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SignupScreen();
  }
}

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Sample Data Storage
  final Map<String, String> _formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Signup"),
        leading: _currentPage > 0
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  _pageController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                  setState(() {
                    _currentPage--;
                  });
                },
              )
            : null,
      ),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          _buildCountryAndLanguagePage(),
          _buildPersonalInfoPage(),
          _buildPhoneVerificationPage(),
        ],
      ),
    );
  }

  Widget _buildCountryAndLanguagePage() {
    String? selectedCountry = "Nigeria";
    String? selectedLanguage = "English (UK)";
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("What country do you live in?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: selectedCountry,
            items: ["Nigeria", "USA", "UK"]
                .map((country) =>
                    DropdownMenuItem(value: country, child: Text(country)))
                .toList(),
            onChanged: (value) {
              _formData["country"] = value!;
            },
            decoration: InputDecoration(labelText: "Country"),
          ),
          SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: selectedLanguage,
            items: ["English (UK)", "English (US)", "French"]
                .map((lang) => DropdownMenuItem(value: lang, child: Text(lang)))
                .toList(),
            onChanged: (value) {
              _formData["language"] = value!;
            },
            decoration: InputDecoration(labelText: "Language"),
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              _pageController.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.ease,
              );
              setState(() {
                _currentPage++;
              });
            },
            child: Text("Continue"),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoPage() {
    final _formKey = GlobalKey<FormState>();
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Personal Information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            TextFormField(
              decoration:
                  InputDecoration(labelText: "First Name (as seen on your ID)"),
              onSaved: (value) => _formData["first_name"] = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Middle Name (Optional)"),
              onSaved: (value) => _formData["middle_name"] = value ?? "",
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: "Surname Name (as seen on your ID)"),
              onSaved: (value) => _formData["surname"] = value!,
            ),
            DropdownButtonFormField<String>(
              value: "Male",
              items: ["Male", "Female"]
                  .map((gender) =>
                      DropdownMenuItem(value: gender, child: Text(gender)))
                  .toList(),
              onChanged: (value) {
                _formData["gender"] = value!;
              },
              decoration: InputDecoration(labelText: "Gender"),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Email Address"),
              onSaved: (value) => _formData["email"] = value!,
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Phone Number"),
              onSaved: (value) => _formData["phone"] = value!,
              keyboardType: TextInputType.phone,
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                  setState(() {
                    _currentPage++;
                  });
                }
              },
              child: Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneVerificationPage() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Verify Phone Number",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Text("Please provide the OTP sent to this phone number ******1234"),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              6,
              (index) => SizedBox(
                width: 40,
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          TextButton(onPressed: () {}, child: Text("Resend OTP")),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              // Finalize signup process
            },
            child: Text("Verify Phone"),
          ),
        ],
      ),
    );
  }
}
