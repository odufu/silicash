import 'dart:async';
import 'package:flutter/material.dart';
import 'package:silicash_mobile/core/widgets/app_button.dart';
import 'package:silicash_mobile/features/login/pages/login_page.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final List<Map<String, String>> _welcomeContent = [
    {
      "image":
          "assets/images/splash/welcome1.png", // Replace with your actual image paths
      "title": "Your Gateway to Seamless Financial Freedom",
      "subtitle":
          "Send money, manage expenses, and unlock endless possibilities with ease",
    },
    {
      "image": "assets/images/splash/welcome2.png",
      "title": "Send Money Anywhere, Anytime",
      "subtitle":
          "Whether local or international, transfer funds securely and in real time with competitive rates.",
    },
    {
      "image": "assets/images/splash/welcome3.png",
      "title": "Shop Online with Confidence",
      "subtitle":
          "Create virtual Naira and USD cards for secure and flexible online payments.",
    },
  ];

  @override
  void initState() {
    super.initState();
    // Start automatic sliding
    Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < _welcomeContent.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _welcomeContent.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      _welcomeContent[index]["image"]!,
                      height: 250,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _welcomeContent[index]["title"]!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _welcomeContent[index]["subtitle"]!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _welcomeContent.length,
              (index) => AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 5),
                height: 8,
                width: _currentPage == index ? 16 : 8,
                decoration: BoxDecoration(
                  color:
                      _currentPage == index ? Colors.green : Colors.grey[400],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                AppButton(buttonLabel: "Create Account"),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text(
                    "Login your account",
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
