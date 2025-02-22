import 'package:flutter/material.dart';
import 'package:silicash_mobile/core/utils/helper_functions.dart';
import 'package:silicash_mobile/features/airtime/pages/mobile_top_up.dart';
import 'package:silicash_mobile/features/book_flight/presentation/pages/book_flight_page.dart';
import 'package:silicash_mobile/features/pay_bills/presentation/pages/pay_bills.dart';

import '../../../core/theme/app_theme_extension.dart';

class OtherServices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context)
                .extension<AppThemeExtension>()
                ?.cardColor(context),
            borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.count(
            crossAxisCount: 3, // Three items per row
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            shrinkWrap: true, // Ensures the grid takes only necessary space
            physics:
                const NeverScrollableScrollPhysics(), // Prevents independent scrolling
            children: [
              _buildCardWithTap(
                context: context,
                title: 'Mobile TopUp',
                imagePath: 'assets/images/appAssets/mobileTopup.png',
                backgroundColor: Colors.green[100],
                onTap: () {
                  HelperFunctions.routePushNormalTo(MobileTopUp(), context);
                },
              ),
              _buildCardWithTap(
                context: context,
                title: 'Pay Bills',
                imagePath: 'assets/images/appAssets/payBills.png',
                backgroundColor: Colors.red[100],
                onTap: () {
                  HelperFunctions.routePushNormalTo(PayBills(), context);
                },
              ),
              _buildCardWithTap(
                context: context,
                title: 'Book Flight',
                imagePath: 'assets/images/appAssets/bookFlight.png',
                backgroundColor: Colors.orange[100],
                onTap: () {
                  HelperFunctions.routePushTo(BookFlightPage(), context);
                },
              ),
              _buildCardWithTap(
                context: context,
                title: 'Convert',
                imagePath: 'assets/images/appAssets/convert.png',
                backgroundColor: Colors.blue[100],
                onTap: () {
                  print('Convert tapped');
                },
              ),
              _buildCardWithTap(
                context: context,
                title: 'Track Expenses',
                imagePath: 'assets/images/appAssets/expenses.png',
                backgroundColor: Colors.teal[100],
                onTap: () {
                  print('Track Expenses tapped');
                },
              ),
              _buildCardWithTap(
                context: context,
                title: 'Fund Account',
                imagePath: 'assets/images/appAssets/fundAccount.png',
                backgroundColor: Colors.purple[100],
                onTap: () {
                  print('Fund Account tapped');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardWithTap({
    required BuildContext context,
    required String title,
    required String imagePath,
    required Color? backgroundColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: (backgroundColor ?? Colors.grey).withOpacity(0.2),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(5)),
              child: Image.asset(
                imagePath,
                width: 40.0,
                height: 40.0,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
