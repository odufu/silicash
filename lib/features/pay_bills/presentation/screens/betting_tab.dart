import 'package:flutter/material.dart';
import 'package:silicash_mobile/core/widgets/app_button.dart';
import 'package:silicash_mobile/features/pay_bills/presentation/widgets/betting_provider_selection.dart';
import '../../../../core/utils/helper_functions.dart';
import '../../../airtime/screens/proceed_to_topop.dart';
import '../../../airtime/widgets/ammount_input.dart';
import '../../../airtime/widgets/recent_activity_card.dart';
import '../../../airtime/widgets/top_up_option.dart';

class BettingTab extends StatefulWidget {
  final List<String> provider;
  final List<String> providerImage;
  final List<Color> providerColor;
  final int selectedProvider;
  final Function(int) onProviderSelected;

  const BettingTab({
    required this.provider,
    required this.providerColor,
    required this.selectedProvider,
    required this.onProviderSelected,
    required this.providerImage,
  });

  @override
  State<BettingTab> createState() => _BettingTabState();
}

class _BettingTabState extends State<BettingTab> {
  int? selectedPrice; // Store the currently selected price

  void handleTopUpSelection(int price) {
    setState(() {
      selectedPrice = price; // Update the selected price
    });
    print("Selected Price: $selectedPrice");
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recent Activity
          const Text(
            "Recent",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          RecentActivityCard(title: "Bet9ja"),
          const SizedBox(height: 20),

          // Choose Network
          // Choose Network
          Row(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * .9,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search Biller",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            width: 0.5,
                            color: Colors.grey), // Thinner bottom border
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: Theme.of(context)
                                .colorScheme
                                .primary), // Slightly thicker when focused
                      ),
                    ),
                  )),
            ],
          ),
          const SizedBox(height: 10),
          BettingProviderSelection(
            providers: widget.provider,
            providerColors: widget.providerColor,
            providerImages: widget.providerImage,
            selectedProvider: widget.selectedProvider,
            onProviderSelected: widget.onProviderSelected,
          ),
          const SizedBox(height: 20),
          const SizedBox(height: 10),
          Text(
            "User ID",
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: "enter id number"),
          ),
          const SizedBox(height: 20),
          // Top Up Options
          Text(
            "Select Ammount",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.black87,
                ),
          ),
          const SizedBox(height: 10),
          TopUpOptions(
            size: size,
            onSelectionChanged: handleTopUpSelection, // Pass the callback
          ),
          const SizedBox(height: 20),

          // Amount and Phone Number Inputs
          selectedPrice == null ? AmountInput() : SizedBox.shrink(),
          const SizedBox(height: 20),

          // Continue Button
          SizedBox(
            width: double.infinity,
            child: AppButton(
              buttonLabel: "Continue",
              onclick: () {
                HelperFunctions.routePushNormalTo(BuyAirtimePage(), context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
