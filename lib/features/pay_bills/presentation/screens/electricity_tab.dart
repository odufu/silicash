import 'package:flutter/material.dart';
import 'package:silicash_mobile/core/widgets/app_button.dart';
import 'package:silicash_mobile/core/widgets/custom_dropdown_field.dart';
import 'package:silicash_mobile/features/pay_bills/presentation/widgets/provider_selection.dart';
import 'package:silicash_mobile/features/pay_bills/presentation/widgets/recent_activity.dart';

import '../../../../core/utils/helper_functions.dart';
import '../../../airtime/screens/proceed_to_topop.dart';
import '../../../airtime/widgets/ammount_input.dart';
import '../../../airtime/widgets/network_selection.dart';
import '../../../airtime/widgets/phone_number_input.dart';
import '../../../airtime/widgets/recent_activity_card.dart';
import '../../../airtime/widgets/top_up_option.dart';

class ElectricityTab extends StatefulWidget {
  final List<String> providers;
  final List<String> providerImages;
  final List<Color> providerColors;
  final int selectedProvider;
  final Function(int) onProviderSelected;

  const ElectricityTab({
    required this.providers,
    required this.providerColors,
    required this.selectedProvider,
    required this.onProviderSelected,
    required this.providerImages,
  });

  @override
  State<ElectricityTab> createState() => _ElectricityTabState();
}

class _ElectricityTabState extends State<ElectricityTab> {
  String selectedPlan = "Pre-Paid"; // Store the currently selected plan
  String? meterNumber; // Store the currently selected plan
  String? ammount; // Store the currently selected plan

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
          RecentActivity(
            title: "Electricity",
          ),
          const SizedBox(height: 20),

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
          ProviderSelection(
            providers: widget.providers,
            providerColors: widget.providerColors,
            providerImages: widget.providerImages,
            selectedProvider: widget.selectedProvider,
            onProviderSelected: widget.onProviderSelected,
          ),
          const SizedBox(height: 20),

          CustomDropdownField(
              label: "Select Payment Type",
              options: ["Pre-Paid", "Post-Paid"],
              selectedValue: selectedPlan,
              onChanged: (value) {
                setState(() {
                  selectedPlan = value;
                });
              }),
          Text(
            "Enter Account/Meter Number",
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              hintText: "Enter account/meter",
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Ammount",
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Enter amount",
            ),
          ),
          const SizedBox(height: 20),
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
