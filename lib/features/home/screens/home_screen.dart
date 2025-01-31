import 'package:flutter/material.dart';
import 'package:silicash_mobile/features/home/pages/account_details_page.dart';
import 'package:silicash_mobile/features/home/widgets/country_drop_down.dart';
import 'package:silicash_mobile/features/home/widgets/other_services.dart';
import 'package:silicash_mobile/features/home/widgets/transaction_card.dart';

import '../../../core/methods/show_modal_bottom_sheet.dart';
import '../../../core/utils/helper_functions.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool accounIsVisible = false;

  void _showBottomModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading:
                    Image.asset("assets/images/appAssets/accountStatement.png"),
                title: Text('Account Statement'),
                onTap: () {
                  // Handle Account Statement action
                  Navigator.pop(context);
                  HelperFunctions.routePushNormalTo(
                      StatementOfAccountPage(), context);
                },
              ),
              ListTile(
                leading:
                    Image.asset("assets/images/appAssets/accountDetails.png"),
                title: Text('Account Details'),
                onTap: () {
                  // Handle Account Details action
                  Navigator.pop(context);
                  HelperFunctions.routePushNormalTo(
                      AccountDetailsPage(), context);
                },
              ),
              ListTile(
                leading:
                    Image.asset("assets/images/appAssets/cardStatement.png"),
                title: Text('Card Statement'),
                onTap: () {
                  // Handle Card Statement action
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Image.asset("assets/images/appAssets/deleteCard.png"),
                title: Text('Delete Virtual Card'),
                onTap: () {
                  // Handle Delete Virtual Card action
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFAFDEB),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(
                              'assets/images/appAssets/profile.png'), // Replace with your image asset
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Hello Joel',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Image.asset(
                                "assets/images/appAssets/notification.png")),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Balance Card
                Container(
                  width: size.width,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12.withOpacity(.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CountryDropDown(),
                          IconButton(
                            onPressed: () {},
                            icon: Image.asset(
                                "assets/images/appAssets/message.png"),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          AnimatedCrossFade(
                            duration: const Duration(milliseconds: 300),
                            firstChild: Text(
                              '₦42,453.00',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            secondChild: Text(
                              '***************',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            crossFadeState: accounIsVisible
                                ? CrossFadeState.showFirst
                                : CrossFadeState.showSecond,
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                accounIsVisible = !accounIsVisible;
                              });
                            },
                            icon: accounIsVisible
                                ? Image.asset(
                                    "assets/images/appAssets/visibility.png",
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  )
                                : Image.asset(
                                    "assets/images/appAssets/visibility-off.png",
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            '6*** 43459',
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[600]),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Image.asset(
                                  "assets/images/appAssets/copy.png"))
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: IconButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(.1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                              ),
                              icon: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: Image.asset(
                                        "assets/images/appAssets/send.png"),
                                  ),
                                  const Text(
                                    'Send Money',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: IconButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(.1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                              ),
                              icon: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: Image.asset(
                                        "assets/images/appAssets/fund.png"),
                                  ),
                                  const Text(
                                    'Fund Card',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            onPressed: _showBottomModal,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(.1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            icon: Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: Image.asset(
                                    "assets/images/appAssets/moreRounded.png",
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 21),

                // Other Services
                const Text(
                  'Other Services',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),

                OtherServices(),

                const SizedBox(height: 21),

                // Recent Activity
                const Text(
                  'Recent Activity',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Today',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),

                TransactionList()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
