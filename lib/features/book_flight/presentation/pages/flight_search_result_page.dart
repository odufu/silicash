import 'package:flutter/material.dart';
import 'package:silicash_mobile/core/theme/app_theme_extension.dart';
import 'package:silicash_mobile/core/widgets/app_button.dart'; // Adjust import if needed
import 'package:silicash_mobile/core/widgets/costum_app_bar.dart';

import 'flight_details_page.dart'; // Adjust import if needed

class FlightSearchResultsPage extends StatefulWidget {
  const FlightSearchResultsPage({super.key});

  @override
  State<FlightSearchResultsPage> createState() =>
      _FlightSearchResultsPageState();
}

class _FlightSearchResultsPageState extends State<FlightSearchResultsPage> {
  // Sample flight data based on the image (you can fetch this dynamically)
  final List<Map<String, dynamic>> flights = [
    {
      'airline': 'Air Peace',
      'logo': 'assets/images/appAssets/airPeace.png', // Updated asset path
      'outbound': {
        'time': '1:15pm - 2:30pm',
        'duration': '1h 10m',
        'stops': '0 stop',
        'route': 'Uyo (QUO) - Abuja (ABV)'
      },
      'return': {
        'time': '5:00pm - 6:20pm',
        'duration': '1h 20m',
        'stops': '0 stop',
        'route': 'Abuja (ABV) - Uyo (QUO)'
      },
      'price': '₦140,000',
    },
    {
      'airline': 'ValueJet',
      'logo': 'assets/images/appAssets/valueJet.png', // Updated asset path
      'outbound': {
        'time': '1:15pm - 2:30pm',
        'duration': '1h 10m',
        'stops': '0 stop',
        'route': 'Uyo (QUO) - Abuja (ABV)'
      },
      'return': {
        'time': '5:00pm - 6:20pm',
        'duration': '1h 20m',
        'stops': '0 stop',
        'route': 'Abuja (ABV) - Uyo (QUO)'
      },
      'price': '₦140,000',
    },
    {
      'airline': 'Dana Airlines',
      'logo': 'assets/images/appAssets/danaAirline.png', // Updated asset path
      'outbound': {
        'time': '1:15pm - 2:30pm',
        'duration': '1h 10m',
        'stops': '0 stop',
        'route': 'Uyo (QUO) - Abuja (ABV)'
      },
      'return': {
        'time': '5:00pm - 6:20pm',
        'duration': '1h 20m',
        'stops': '0 stop',
        'route': 'Abuja (ABV) - Uyo (QUO)'
      },
      'price': '₦140,000',
    },
  ];

  String? selectedFilter = 'Cheapest'; // Default filter as shown in the image

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: CustomAppBar(), // Using your custom app bar
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date and Price Range
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Mar 13 - Mar 14',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const Text(
                    'Mar 15 - Mar 17',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const Text(
                    'Mar 18 - Mar 20',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '₦180,000',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '₦140,000',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '₦180,000',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),

              // Filters
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'All Filter',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  DropdownButton<String>(
                    value: selectedFilter,
                    items: [
                      'Cheapest',
                      'Suggested',
                      'Fastest',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedFilter = newValue;
                      });
                    },
                    underline: Container(),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),

              // Flight Cards with Tap Navigation
              for (var flight in flights)
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FlightDetailsPage(flight: flight),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 0,
                    color: Theme.of(context)
                        .extension<AppThemeExtension>()
                        ?.cardColor(context),
                    margin: const EdgeInsets.only(bottom: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          12.0), // Rounded corners as in image
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                flight['logo']!,
                                width: 40,
                                height: 40,
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                flight['airline']!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          _buildFlightSegment(flight['outbound']),
                          const SizedBox(height: 8.0),
                          _buildFlightSegment(flight['return']),
                          const SizedBox(height: 16.0),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              flight['price']!,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              // Show All Flights CTA
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Implement navigation or logic to show all 20 flights
                        print("Show all 20 flights clicked");
                      },
                      child: const Text(
                        'Show all 20 flights',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Icon(Icons.arrow_forward, color: Colors.green),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFlightSegment(Map<String, dynamic> segment) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                segment['time']!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                segment['route']!,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              segment['duration']!,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              segment['stops']!,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
