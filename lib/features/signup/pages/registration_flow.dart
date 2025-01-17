import 'package:flutter/material.dart';
import '../../../core/widgets/costum_app_bar.dart';
import '../screens/step1_country_language.dart';
import '../screens/step2_personal_info.dart';
import '../screens/step3_otp_screen.dart';
import '../screens/step4_create_pin.dart';
import '../screens/step5_create_password.dart';
import '../screens/success.dart';
import '../widgets/annimated_circular_widget.dart';

class RegistrationFlow extends StatefulWidget {
  @override
  _RegistrationFlowState createState() => _RegistrationFlowState();
}

class _RegistrationFlowState extends State<RegistrationFlow> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < 5) {
      setState(() {
        _currentPage++;
      });
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          onBackButtonPressed: _previousPage,
          action: AnimatedCircularProgress(
            numerator: _currentPage,
            denominator: 5,
            startingColor: Theme.of(context).colorScheme.secondary,
            endingColor: Theme.of(context).colorScheme.primary,
          ),
        ),
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Step1CountryLanguage(onNext: _nextPage),
            Step2PersonalInfo(onNext: _nextPage),
            Step3OtpScreen(onNext: _nextPage),
            Step4CreatePinScreen(onNext: _nextPage),
            Step5CreatePasswordScreen(onNext: _nextPage),
          ],
        ),
      ),
    );
  }
}
