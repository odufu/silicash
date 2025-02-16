import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:silicash_mobile/core/utils/helper_functions.dart';
import 'package:silicash_mobile/features/home/pages/statement_page.dart';
import 'package:silicash_mobile/features/home/widgets/country_drop_down.dart';
import 'package:silicash_mobile/features/home/widgets/dark_country_drop_down.dart';
import 'package:silicash_mobile/features/home/widgets/other_services.dart';
import 'package:silicash_mobile/features/home/widgets/transaction_card.dart';

import '../pages/account_details_page.dart';

class HomeScreen2 extends StatefulWidget {
  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  bool accounIsVisible = false;

  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  String firstName = "User"; // Default value

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    String? storedName = await secureStorage.read(key: "firstName");
    if (storedName != null) {
      setState(() {
        firstName = storedName;
      });
    }
  }

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
    return Scaffold(
      floatingActionButton: IconButton(
          onPressed: () {},
          icon: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(.4), blurRadius: 10)
                ]),
            child: Image.asset("assets/images/appAssets/message.png"),
          )),
      body: SafeArea(
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
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(
                                'assets/images/appAssets/dp.jpg'), // Replace with your image asset
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Hello $firstName',
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
                      gradient: LinearGradient(colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary
                      ]),
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
                            DarkCountryDropDown(),
                            IconButton(
                              onPressed: _showBottomModal,
                              icon: Image.asset(
                                  "assets/images/appAssets/moreRounded.png"),
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            AnimatedCrossFade(
                              duration: const Duration(milliseconds: 300),
                              firstChild: const Text(
                                '₦42,453.00',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              secondChild: const Text(
                                '***************',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
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
                                      color: Colors.white,
                                    )
                                  : Image.asset(
                                      "assets/images/appAssets/visibility-off.png",
                                      color: Colors.white,
                                    ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              '6*** 43459',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Image.asset(
                                  "assets/images/appAssets/copy.png",
                                  color: Colors.white,
                                ))
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: IconButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
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
                                        "assets/images/appAssets/send.png",
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                    const Text(
                                      'Send',
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
                                  backgroundColor: Colors.white,
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
                            Expanded(
                              child: IconButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
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
                                          "assets/images/appAssets/convert2.png"),
                                    ),
                                    const Text(
                                      'Convert',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
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
      ),
    );
  }
}
