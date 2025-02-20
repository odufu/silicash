import 'package:flutter/material.dart';
import 'package:silicash_mobile/core/widgets/costum_app_bar.dart';
import 'package:silicash_mobile/features/pay_bills/presentation/screens/electricity_tab.dart';

import '../../../airtime/screens/airtime_tab.dart';
import '../../../airtime/screens/data_purchase_tab.dart';

class PayBills extends StatefulWidget {
  @override
  _PayBillsState createState() => _PayBillsState();
}

class _PayBillsState extends State<PayBills>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedNetwork = 0;

  // Constants
  final List<String> providers = ['EEDC', 'EKEDC', 'AEDC', 'IBEDC'];
  final List<String> networkImages = [
    'assets/images/appAssets/eedc.png',
    'assets/images/appAssets/EKEDC.png',
    'assets/images/appAssets/AEDC.png',
    'assets/images/appAssets/IBEDC.png'
  ];
  final List<Color> networkColors = [
    Colors.yellow,
    Colors.red,
    Colors.green,
    Colors.blue
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFDEB),
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Buy Airtime & Data",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                TextButton(
                  onPressed: () {},
                  child: Text("History",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context).colorScheme.primary)),
                )
              ],
            ),
            SizedBox(
              height: 24,
            ),
            // Tab Bar
            Theme(
              data: Theme.of(context).copyWith(
                dividerColor:
                    Colors.transparent, // Removes the black bottom border
              ),
              child: SizedBox(
                height: 30,
                child: TabBar(
                  indicatorWeight: 1,
                  dividerColor: Colors.transparent,
                  controller: _tabController,
                  indicator: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary
                    ]),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.green,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: const [
                    Tab(text: 'Electricity'),
                    Tab(text: 'Subscriptions'),
                    Tab(text: 'Betting'),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Tab Views
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ElectricityTab(
                    providers: providers,
                    providerColors: networkColors,
                    providerImages: networkImages,
                    onProviderSelected: (index) {
                      setState(() {
                        selectedNetwork = index;
                      });
                    },
                    selectedProvider: selectedNetwork,
                  ),
                  ElectricityTab(
                    providers: providers,
                    providerColors: networkColors,
                    providerImages: networkImages,
                    onProviderSelected: (index) {
                      setState(() {
                        selectedNetwork = index;
                      });
                    },
                    selectedProvider: selectedNetwork,
                  ),
                  ElectricityTab(
                    providers: providers,
                    providerColors: networkColors,
                    providerImages: networkImages,
                    onProviderSelected: (index) {
                      setState(() {
                        selectedNetwork = index;
                      });
                    },
                    selectedProvider: selectedNetwork,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
