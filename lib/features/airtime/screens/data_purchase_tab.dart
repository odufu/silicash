import 'package:flutter/material.dart';
import 'package:silicash_mobile/core/utils/helper_functions.dart';
import 'package:silicash_mobile/core/widgets/app_button.dart';

import '../../../core/widgets/custom_checkbox.dart';
import '../pages/mobile_top_up.dart';
import '../widgets/ammount_input.dart';
import '../widgets/data_option.dart';
import '../widgets/network_selection.dart';
import '../widgets/phone_number_input.dart';
import '../widgets/recent_activity_card.dart';
import '../widgets/top_up_option.dart';
import 'proceed_to_topop.dart';

class DataPurchaseTab extends StatefulWidget {
  final List<String> networks;
  final List<String> networkImages;
  final List<Color> networkColors;
  final int selectedNetwork;
  final Function(int) onNetworkSelected;

  const DataPurchaseTab({
    required this.networks,
    required this.networkColors,
    required this.selectedNetwork,
    required this.onNetworkSelected,
    required this.networkImages,
  });

  @override
  State<DataPurchaseTab> createState() => _DataPurchaseTabState();
}

class _DataPurchaseTabState extends State<DataPurchaseTab> {
  int? selectedPrice; // Store the currently selected price
  bool _autoSubscription = false;

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
            title: "Data Subscription",
          ),
          const SizedBox(height: 20),

          // Choose Network
          Text(
            "Choose Network",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
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
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "HOT",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Daily",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Night",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Weekend",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Weekly",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Monthly",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          DataOption(
            size: MediaQuery.of(context).size,
            onSelectionChanged: (selectedPrice) {
              print("Selected price: $selectedPrice");
              // Handle the selected price in the parent widget
            },
          ),

          const SizedBox(height: 20),
          Text("Phone Number"),
          SizedBox(
            height: 12,
          ),
          PhoneNumberInput(),
          const SizedBox(height: 16),
          Row(
            children: [
              CustomCheckbox(
                value: _autoSubscription,
                onChanged: (value) {
                  setState(() {
                    _autoSubscription = value ?? false;
                  });
                },
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                "Auto-Subscribe",
                style: TextStyle(fontSize: 14),
              )
            ],
          ),
          const SizedBox(height: 79),

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
