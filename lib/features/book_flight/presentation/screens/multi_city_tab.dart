import 'package:flutter/material.dart';
import 'package:silicash_mobile/core/theme/app_theme_extension.dart';
import 'package:silicash_mobile/core/utils/helper_functions.dart';
import 'package:silicash_mobile/core/widgets/app_button.dart';
import 'package:silicash_mobile/core/widgets/custom_dropdown_field.dart';
import 'package:silicash_mobile/features/book_flight/presentation/pages/flight_search_result_page.dart';
import 'package:silicash_mobile/features/book_flight/presentation/widgets/class_carbin_selector.dart';
import '../widgets/departure_date_selector.dart'; // Adjust the import path as needed
import '../widgets/passenger_selector.dart'; // Adjust the import path as needed

class MultiCityTab extends StatefulWidget {
  const MultiCityTab({super.key});

  @override
  State<MultiCityTab> createState() => _MultiCityTabState();
}

class _MultiCityTabState extends State<MultiCityTab> {
  int _adultCount = 1; // Default to 1 adult
  int _childCount = 0; // Default to 0 children
  String? cabinClass; // Shared cabin class selection

  // List to store multiple segments (each with leavingFrom, goingTo, and departureDate)
  List<Map<String, dynamic>> segments = [
    {
      'leavingFrom': null,
      'goingTo': null,
      'departureDate': null
    }, // Start with one segment
  ];

  void _handleDateSelected(DateTime? departure, int segmentIndex) {
    setState(() {
      segments[segmentIndex]['departureDate'] = departure;
    });
    print("Selected Departure Date for Segment $segmentIndex: $departure");
  }

  void _handlePassengersSelected(int adultCount, int childCount) {
    setState(() {
      _adultCount = adultCount;
      _childCount = childCount;
    });
    print("Selected Passengers: Adults: $adultCount, Children: $childCount");
  }

  void _updateSegment(String? leaving, String? going, int segmentIndex) {
    setState(() {
      segments[segmentIndex]['leavingFrom'] = leaving;
      segments[segmentIndex]['goingTo'] = going;
    });
  }

  void _updateCabinClass(String? value) {
    setState(() {
      cabinClass = value;
    });
    print("Selected Cabin Class: $value");
  }

  void _addNewSegment() {
    setState(() {
      segments
          .add({'leavingFrom': null, 'goingTo': null, 'departureDate': null});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dynamic segments wrapped in Card widgets
            for (int i = 0; i < segments.length; i++)
              Card(
                color: Theme.of(context)
                    .extension<AppThemeExtension>()
                    ?.cardColor(context),
                elevation: 2, // Slight elevation for visual distinction
                margin: const EdgeInsets.only(
                    bottom: 16.0), // Spacing between cards
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Route ${i + 1}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      CustomDropdownField(
                        label: "Leaving From",
                        options: ["Uyo", "Abuja", "Port Harcourt"],
                        selectedValue: segments[i]['leavingFrom'] as String?,
                        onChanged: (value) {
                          if (mounted) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              _updateSegment(
                                value,
                                segments[i]['goingTo'] as String?,
                                i,
                              );
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 16.0),
                      CustomDropdownField(
                        label: "Going To",
                        options: ["Uyo", "Abuja", "Port Harcourt"],
                        selectedValue: segments[i]['goingTo'] as String?,
                        onChanged: (value) {
                          if (mounted) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              _updateSegment(
                                segments[i]['leavingFrom'] as String?,
                                value,
                                i,
                              );
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 16.0),
                      DepartureDateSelectorWidget(
                        onDateSelected: (departure) =>
                            _handleDateSelected(departure, i),
                      ),
                    ],
                  ),
                ),
              ),

            // Add Another Route CTA
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: TextButton(
                onPressed: _addNewSegment,
                child: const Text(
                  'Add Another Route',
                  style: TextStyle(color: Colors.green, fontSize: 16),
                ),
              ),
            ),

            // Passengers (shared across all segments)
            PassengerSelectorWidget(
              initialAdultCount: _adultCount,
              initialChildCount: _childCount,
              onPassengersSelected: _handlePassengersSelected,
            ),
            const SizedBox(height: 16.0),

            // Class/Cabin (shared across all segments)
            ClassCabinSelector(
              onChanged: _updateCabinClass,
            ),
            const SizedBox(height: 16.0),

            // Search Flight Button
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: AppButton(
                buttonLabel: "Search Flight",
                onclick: () {
                  HelperFunctions.routePushTo(
                      FlightSearchResultsPage(), context);
                  print("Segments: $segments");
                  print("Cabin Class: $cabinClass");
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
