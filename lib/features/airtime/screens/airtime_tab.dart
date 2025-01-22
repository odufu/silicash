import 'package:flutter/material.dart';
import 'package:silicash_mobile/core/widgets/app_button.dart';

import '../../../core/utils/helper_functions.dart';
import '../pages/mobile_top_up.dart';
import '../widgets/ammount_input.dart';
import '../widgets/network_selection.dart';
import '../widgets/phone_number_input.dart';
import '../widgets/recent_activity_card.dart';
import '../widgets/top_up_option.dart';
import 'proceed_to_topop.dart';

class AirtimeTab extends StatefulWidget {
  final List<String> networks;
  final List<String> networkImages;
  final List<Color> networkColors;
  final int selectedNetwork;
  final Function(int) onNetworkSelected;

  const AirtimeTab({
    required this.networks,
    required this.networkColors,
    required this.selectedNetwork,
    required this.onNetworkSelected,
    required this.networkImages,
  });

  @override
  State<AirtimeTab> createState() => _AirtimeTabState();
}

class _AirtimeTabState extends State<AirtimeTab> {
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
          RecentActivityCard(
            title: "Airtime Top-up",
          ),
          const SizedBox(height: 20),

          // Choose Network
          Row(
            children: [
              Text(
                "Choose Network",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          NetworkSelection(
            networks: widget.networks,
            networkColors: widget.networkColors,
            networkImages: widget.networkImages,
            selectedNetwork: widget.selectedNetwork,
            onNetworkSelected: widget.onNetworkSelected,
          ),
          const SizedBox(height: 20),

          // Top Up Options
          Text(
            "Top up",
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
          AmountInput(),
          const SizedBox(height: 20),
          PhoneNumberInput(),
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
