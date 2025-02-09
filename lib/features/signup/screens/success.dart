import 'package:flutter/material.dart';
import 'package:silicash_mobile/core/utils/helper_functions.dart';
import 'package:silicash_mobile/core/widgets/app_button.dart';
import 'package:silicash_mobile/features/login/pages/login_page.dart';

import '../../../core/pages/success_screen.dart';
import '../../../core/utils/constants.dart';
import '../../login/services/login_service.dart';

class Succee extends StatelessWidget {
  final String title;
  final String message;

  const Succee({
    super.key,
    required this.title,
    required this.message,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SuccessScreen(
        title: title,
        message: message,
        gifPath: "assets/images/appAssets/success2.gif",
        onButtonPressed: () {
          // Navigate to another screen
          HelperFunctions.routeReplacdTo(
              LoginPage(
                loginService: LoginService(Constants.baseUrl),
              ),
              context);
        },
      ),
    ));
  }
}
