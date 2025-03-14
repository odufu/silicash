import 'package:flutter/material.dart';
import 'package:silicash_mobile/core/utils/helper_functions.dart';
import 'package:silicash_mobile/core/widgets/app_button.dart';
import 'package:silicash_mobile/core/widgets/custom_dropdown_field.dart';
import 'package:silicash_mobile/features/book_flight/presentation/pages/flight_search_result_page.dart';
import 'package:silicash_mobile/features/book_flight/presentation/widgets/class_carbin_selector.dart';
import '../widgets/date_selector.dart';
import '../widgets/passenger_selector.dart';

class RoundTripTab extends StatefulWidget {
  const RoundTripTab({super.key});

  @override
  State<RoundTripTab> createState() => _RoundTripTabState();
}

class _RoundTripTabState extends State<RoundTripTab> {
  String? leavingFrom;
  String? goingTo;
  int _adultCount = 1; // Default values managed by parent
  int _childCount = 0;
  DateTime? departureDate;
  DateTime? returnDate;

  void _handleDatesSelected(DateTime? departure, DateTime? returnDate) {
    setState(() {
      this.departureDate = departure;
      this.returnDate = returnDate;
    });
    print("Selected Dates: Departure: $departure, Return: $returnDate");
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
            // Use the new PassengerSelectorWidget
            PassengerSelectorWidget(
              initialAdultCount: _adultCount,
              initialChildCount: _childCount,
              onPassengersSelected: _handlePassengersSelected,
            ),
            const SizedBox(height: 16.0),
            DateSelectorWidget(
              onDatesSelected: _handleDatesSelected,
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
                      const FlightSearchResultsPage(), context);
                  print("Departure: $departureDate, Return: $returnDate");
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
