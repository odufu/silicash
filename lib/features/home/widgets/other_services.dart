import 'package:flutter/material.dart';
import 'package:silicash_mobile/core/utils/helper_functions.dart';
import 'package:silicash_mobile/features/airtime/pages/mobile_top_up.dart';

class OtherServices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        color: Colors.white,
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
                title: 'Mobile TopUp',
                imagePath: 'assets/images/appAssets/mobileTopup.png',
                backgroundColor: Colors.green[100],
                onTap: () {
                  HelperFunctions.routePushNormalTo(MobileTopUp(), context);
                },
              ),
              _buildCardWithTap(
                title: 'Pay Bills',
                imagePath: 'assets/images/appAssets/payBills.png',
                backgroundColor: Colors.red[100],
                onTap: () {
                  print('Pay Bills tapped');
                },
              ),
              _buildCardWithTap(
                title: 'Book Flight',
                imagePath: 'assets/images/appAssets/bookFlight.png',
                backgroundColor: Colors.orange[100],
                onTap: () {
                  print('Book Flight tapped');
                },
              ),
              _buildCardWithTap(
                title: 'Convert',
                imagePath: 'assets/images/appAssets/convert.png',
                backgroundColor: Colors.blue[100],
                onTap: () {
                  print('Convert tapped');
                },
              ),
              _buildCardWithTap(
                title: 'Track Expenses',
                imagePath: 'assets/images/appAssets/expenses.png',
                backgroundColor: Colors.teal[100],
                onTap: () {
                  print('Track Expenses tapped');
                },
              ),
              _buildCardWithTap(
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
            Image.asset(
              imagePath,
              width: 40.0,
              height: 40.0,
              fit: BoxFit.contain,
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
