import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:silicash_mobile/core/utils/helper_functions.dart';
import 'package:silicash_mobile/core/widgets/app_button.dart';
import 'package:silicash_mobile/features/signup/screens/success.dart';

import '../../../core/widgets/costum_app_bar.dart';

class BuyAirtimePage extends StatefulWidget {
  @override
  State<BuyAirtimePage> createState() => _BuyAirtimePageState();
}

class _BuyAirtimePageState extends State<BuyAirtimePage> {
  final List<String> otpValues = List.filled(4, ""); // Stores the OTP digits

  // Check if all OTP fields are filled
  bool get isOtpComplete => otpValues.every((value) => value.isNotEmpty);

  // Function to handle OTP input changes
  void _onOtpChanged(String value, int index) {
    setState(() {
      otpValues[index] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              "Verify Transaction",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTransactionRow("Biller:", "Dolphin Telecom, Ltd."),
                  _buildTransactionRow("Service Type:", "Airtime"),
                  _buildTransactionRow("Phone Number:", "1234567890"),
                  _buildTransactionRow("Amount:", "₦1,000.00"),
                  _buildTransactionRow("Fee:", "₦0.00"),
                ],
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: Text(
                "Enter your Pin",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(4, (index) {
                return SizedBox(
                  width: 40,
                  child: TextFormField(
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        FocusScope.of(context).nextFocus();
                      }
                      _onOtpChanged(value, index);
                    },
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      counterText: "",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              width: double.infinity,
              child: AppButton(
                buttonLabel: "Confirm",
                onclick: isOtpComplete
                    ? () {
                        HelperFunctions.routePushNormalTo(Succee(title: "Airtime Purchase Success", message: "You have succesfully purchased a credit of 100000 Naira",), context);
                      }
                    : null,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black.withOpacity(0.7),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
