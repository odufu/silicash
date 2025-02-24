import 'package:flutter/material.dart';
import 'package:silicash_mobile/core/theme/app_theme_extension.dart';
import 'package:silicash_mobile/core/widgets/app_button.dart'; // Adjust import if needed
import 'package:silicash_mobile/core/widgets/costum_app_bar.dart';
import 'package:silicash_mobile/features/home/pages/home_page.dart';
import 'package:silicash_mobile/features/signup/screens/success.dart'; // Adjust import if needed

class PaymentConfirmationPage extends StatelessWidget {
  final String amount; // Amount to be debited (e.g., "₦140,000")
  final String balance; // Current balance (e.g., "₦300,000")
  final String dateTime; // Date and time of transaction (e.g., "14/02/25")

  const PaymentConfirmationPage({
    super.key,
    required this.amount,
    required this.balance,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: CustomAppBar(), // Using your custom app bar with static title
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Text
              Text(
                'Complete your flight payment',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16.0),

              // Payment Details Card
              Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                color: Theme.of(context)
                        .extension<AppThemeExtension>()
                        ?.cardColor(context) ??
                    Colors.grey[100], // Light background as in image
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Amount to Debit
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Amount to debited',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'NGN ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                amount,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1.0,
                        height: 16.0,
                      ),

                      // Balance
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Bal.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            balance,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1.0,
                        height: 16.0,
                      ),

                      // Date & Time
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Date & Time',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            dateTime,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1.0,
                        height: 16.0,
                      ),

                      // Transaction Type
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Transaction type',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            'Debit',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1.0,
                        height: 16.0,
                      ),

                      // Payment For
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Payment for',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            'Flight',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1.0,
                        height: 16.0,
                      ),

                      // Fee
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'fee',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            '0.00',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Confirm Button
              Center(
                child: AppButton(
                  buttonLabel: 'Confirm',
                  onclick: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Succee(
                                title: "Flight booked successfully",
                                nextPage: HomePage(),
                                child: Text("data"),
                                message:
                                    "check your email for the booking confirmation details.")));
                    // Implement payment confirmation logic here
                    print("Payment confirmed for amount: $amount");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
