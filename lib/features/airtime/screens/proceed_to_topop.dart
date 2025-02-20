import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:silicash_mobile/core/utils/helper_functions.dart';
import 'package:silicash_mobile/core/widgets/app_button.dart';
import 'package:silicash_mobile/features/airtime/widgets/reciept_card.dart';
import 'package:silicash_mobile/features/home/pages/home_page.dart';
import 'package:silicash_mobile/features/signup/screens/success.dart';
import '../../../core/widgets/costum_app_bar.dart';

/// Reusable Loading State Widget
class CustomLoadingState extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const CustomLoadingState({
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}

class BuyAirtimePage extends StatefulWidget {
  @override
  State<BuyAirtimePage> createState() => _BuyAirtimePageState();
}

class _BuyAirtimePageState extends State<BuyAirtimePage> {
  final List<String> otpValues = List.filled(4, ""); // Stores the OTP digits
  bool isLoading = false; // Loading state

  // Check if all OTP fields are filled
  bool get isOtpComplete => otpValues.every((value) => value.isNotEmpty);

  // Function to handle OTP input changes
  void _onOtpChanged(String value, int index) {
    setState(() {
      otpValues[index] = value;
    });
  }

  void _confirmTransaction() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2)); // Simulate network delay

    setState(() {
      isLoading = false;
    });

    HelperFunctions.routePushNormalTo(
      Succee(
        title: "Successfully",
        child: ReceiptCard(),
        message: "Your MTN recharge of ₦1000 was successful. ",
        nextPage: HomePage(),
      ),
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: CustomLoadingState(
        isLoading: isLoading,
        child: Padding(
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
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(.3),
                        blurRadius: 5,
                      )
                    ]),
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
                    width: 56,
                    height: 56,
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
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ), // Set text size and weight
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
                  onclick: isOtpComplete ? _confirmTransaction : null,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
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
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black.withOpacity(0.7),
            ),
          ),
          ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary
                ], // Replace with your gradient colors
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds);
            },
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors
                    .white, // This must be white to allow the gradient to show
              ),
            ),
          )
        ],
      ),
    );
  }
}
