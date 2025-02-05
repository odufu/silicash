import 'package:flutter/material.dart';
import 'package:silicash_mobile/core/widgets/app_button.dart';

import '../../../../core/utils/helper_functions.dart';
import '../../../airtime/screens/proceed_to_topop.dart';
import '../../../airtime/widgets/ammount_input.dart';
import '../../../airtime/widgets/network_selection.dart';
import '../../../airtime/widgets/phone_number_input.dart';
import '../../../airtime/widgets/recent_activity_card.dart';
import '../../../airtime/widgets/top_up_option.dart';


class ElectricityTab extends StatefulWidget {
  final List<String> networks;
  final List<String> networkImages;
  final List<Color> networkColors;
  final int selectedNetwork;
  final Function(int) onNetworkSelected;

  const ElectricityTab({
    required this.networks,
    required this.networkColors,
    required this.selectedNetwork,
    required this.onNetworkSelected,
    required this.networkImages,
  });

  @override
  State<ElectricityTab> createState() => _ElectricityTabState();
}

class _ElectricityTabState extends State<ElectricityTab> {
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
            title: "Electricity",
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
