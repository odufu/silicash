import 'package:flutter/material.dart';
import 'package:silicash_mobile/core/utils/helper_functions.dart';
import 'package:silicash_mobile/core/widgets/app_button.dart';
import 'package:silicash_mobile/features/login/pages/login_page.dart';

import '../../../core/pages/success_screen.dart';

class Succee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SuccessScreen(
      title: "Success!",
      message: "Your operation was completed successfully.",
      gifPath: "assets/images/appAssets/success2.gif",
      onButtonPressed: () {
        // Navigate to another screen
        HelperFunctions.routeReplacdTo(LoginPage(), context);
      },
    ));
  }
}
