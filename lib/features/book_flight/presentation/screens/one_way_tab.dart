import 'package:flutter/material.dart';
import 'package:silicash_mobile/core/utils/helper_functions.dart';
import 'package:silicash_mobile/core/widgets/app_button.dart';
import 'package:silicash_mobile/core/widgets/custom_dropdown_field.dart';
import 'package:silicash_mobile/features/book_flight/presentation/pages/flight_search_result_page.dart';
import 'package:silicash_mobile/features/book_flight/presentation/widgets/class_carbin_selector.dart';
import '../widgets/departure_date_selector.dart'; // New widget
import '../widgets/passenger_selector.dart'; // Adjust the import path as needed

class OneWayTab extends StatefulWidget {
  const OneWayTab({super.key});

  @override
  State<OneWayTab> createState() => _OneWayTabState();
}

class _OneWayTabState extends State<OneWayTab> {
  String? leavingFrom;
  String? goingTo;
  int _adultCount = 1; // Default to 1 adult
  int _childCount = 0; // Default to 0 children
  DateTime? departureDate; // Only need departure date for one-way

  void _handleDateSelected(DateTime? departure) {
    setState(() {
      departureDate = departure; // Only store departure date for one-way
    });
    print("Selected Departure Date: $departure");
  }

  void _handlePassengersSelected(int adultCount, int childCount) {
    setState(() {
      _adultCount = adultCount;
      _childCount = childCount;
    });
    print("Selected Passengers: Adults: $adultCount, Children: $childCount");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomDropdownField(
              label: "Leaving From",
              options: ["Uyo", "Abuja", "Port Harcourt"],
              selectedValue: leavingFrom,
              onChanged: (value) {
                if (mounted) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      leavingFrom = value;
                    });
                  });
                }
              },
            ),
            const SizedBox(height: 16.0),
            CustomDropdownField(
              label: "Going To",
              options: ["Uyo", "Abuja", "Port Harcourt"],
              selectedValue: goingTo,
              onChanged: (value) {
                if (mounted) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      goingTo = value;
                    });
                  });
                }
              },
            ),
            const SizedBox(height: 16.0),
            PassengerSelectorWidget(
              initialAdultCount: _adultCount,
              initialChildCount: _childCount,
              onPassengersSelected: _handlePassengersSelected,
            ),
            const SizedBox(height: 16.0),
            // Use the new DepartureDateSelectorWidget for one-way
            DepartureDateSelectorWidget(
              onDateSelected: _handleDateSelected,
            ),
            const SizedBox(height: 16.0),
            ClassCabinSelector(onChanged: (value) {}),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: AppButton(
                buttonLabel: "Search Flight",
                onclick: () {
                  HelperFunctions.routePushTo(
                      FlightSearchResultsPage(), context);
                  print("Departure: $departureDate");
                  print("Adults: $_adultCount, Children: $_childCount");
                  print("Implement Search Flight");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
