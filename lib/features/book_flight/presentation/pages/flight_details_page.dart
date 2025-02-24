import 'package:flutter/material.dart';
import 'package:silicash_mobile/core/theme/app_theme_extension.dart';
import 'package:silicash_mobile/core/widgets/costum_app_bar.dart'; // Adjust import if needed
import 'package:silicash_mobile/core/widgets/app_button.dart';

import 'checkoout_page.dart'; // Adjust import if needed

class FlightDetailsPage extends StatelessWidget {
  final Map<String, dynamic> flight;

  const FlightDetailsPage({super.key, required this.flight});

  @override
  Widget build(BuildContext context) {
    // Safely access outbound time, duration, and route, with null checking
    final outbound = flight['outbound'] as Map<String, dynamic>? ?? {};
    final time = outbound['time'] as String? ?? 'Not available';
    final duration = outbound['duration'] as String? ?? 'Not available';
    final route = outbound['route'] as String? ?? 'Not available';
    final price =
        flight['price'] as String? ?? 'Not available'; // Safely handle price

    // Fallback for card color if theme extension is null
    final cardColor =
        Theme.of(context).extension<AppThemeExtension>()?.cardColor(context) ??
            Theme.of(context).colorScheme.surface;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: CustomAppBar(), // Using your custom app bar with static title
        body: Stack(
          children: [
            // Scrollable content
            SingleChildScrollView(
              // Ensure SingleChildScrollView has explicit constraints
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context)
                          .size
                          .height - // Adjust to fill available space
                      (AppBar().preferredSize.height +
                          MediaQuery.of(context).padding.top +
                          32.0), // Padding + AppBar height
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min, // Prevent infinite height
                    children: [
                      // Trip Summary (Static Subtitle)
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Your trip QUO-ABV',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Mar 15 - Mar 17 | 1 Passengers',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),

                      // Single Card for Main Details
                      Card(
                        elevation: 2,
                        margin: const EdgeInsets.only(bottom: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        color: cardColor, // Use fallback color
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Departure Section
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Departure: Wed, Mar 15 | Uyo - Abuja',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize
                                        .min, // Prevent infinite width
                                    children: [
                                      // Airline Logo with error handling and constraints
                                      ConstrainedBox(
                                        constraints: const BoxConstraints(
                                          maxWidth: 40,
                                          maxHeight: 40,
                                        ),
                                        child: Image.asset(
                                          flight['logo']!,
                                          width: 40,
                                          height: 40,
                                          fit: BoxFit
                                              .contain, // Ensure image fits within constraints
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return const Icon(Icons.flight,
                                                size: 40, color: Colors.grey);
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 8.0),
                                      Expanded(
                                        // Ensure text doesn’t overflow
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize
                                              .min, // Prevent infinite height
                                          children: [
                                            Text(
                                              '$time | $duration',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              route,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    'Airports (LOS) (Godswill Akpabio International Airport) - Abuja (ABV) (Nnamdi Azikiwe International Airport)',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    'Air Peace, 222, Class Z - Economy', // Static for now
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  TextButton(
                                      onPressed: () {},
                                      child: Text("Change Flight"))
                                ],
                              ),
                              const Divider(
                                color: Colors.grey,
                                thickness: 1.0,
                                height: 16.0,
                              ),

                              // Seats Section
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Seats',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    'Select your preferred seat and enhance your journey with personalized comfort and convenience.',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  TextButton(
                                    onPressed: () {
                                      // Implement seat selection logic here
                                      print("Choose seat(s) clicked");
                                    },
                                    child: const Text(
                                      'Choose seat(s)',
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                color: Colors.grey,
                                thickness: 1.0,
                                height: 16.0,
                              ),

                              // Luggage and Cancellation Section
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '12kg Hand Luggage & 70% cancellation fee',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    'No fee attached when you cancel within 24 hours of booking. ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    'Luggage fee change maybe based on size & weight restrictions, promotions or loyalty program. For any additional details, please refer to Air Peace',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Change Flight Button (Outside the card, as shown in the image)
                      Center(
                        child: TextButton(
                          onPressed: () {
                            // Implement change flight logic here
                            print("Change Flight clicked");
                          },
                          child: Text(
                            'Change Flight',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Sticky Trip Total Section at the bottom
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Card(
                elevation: 2,
                margin:
                    EdgeInsets.zero, // No margin to fit flush with screen edges
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0), // Rounded corners
                ),
                color: Theme.of(context)
                        .extension<AppThemeExtension>()
                        ?.cardColor(context) ??
                    Theme.of(context)
                        .colorScheme
                        .surface, // Match the card color for consistency
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 16.0,
                  ), // Adjusted padding to match image
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Trip total',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            flight['price'] as String? ??
                                'Not available', // Safely handle price
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 120, // Minimum width for the button
                              maxWidth:
                                  200, // Maximum width to prevent overflow
                            ),
                            child: AppButton(
                              buttonLabel: 'Checkout',
                              onclick: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CheckoutPage(
                                      flight: flight,
                                      departureDate:
                                          'Wed, Mar 15', // Static for now, can be dynamic
                                      route:
                                          'Uyo - Abuja', // Static for now, can be dynamic
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: TextButton(
                          onPressed: () {
                            // Implement view price details logic here
                            print("View price details clicked");
                          },
                          child: Text(
                            'View price details',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
