import 'package:flutter/material.dart';
import 'package:silicash_mobile/core/widgets/costum_app_bar.dart';

import '../screens/airtime_tab.dart';
import '../screens/data_purchase_tab.dart';

class MobileTopUp extends StatefulWidget {
  @override
  _MobileTopUpState createState() => _MobileTopUpState();
}

class _MobileTopUpState extends State<MobileTopUp>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedNetwork = 0;

  // Constants
  final List<String> networks = ['MTN', 'AIRTEL', 'GLO', 'ETISALAT'];
  final List<String> networkImages = [
    'assets/images/appAssets/mtn.png',
    'assets/images/appAssets/airtel.png',
    'assets/images/appAssets/glo.png',
    'assets/images/appAssets/etisalat.png'
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
    _tabController = TabController(length: 2, vsync: this);
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
                    Tab(text: 'Airtime'),
                    Tab(text: 'Data'),
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
                  AirtimeTab(
                    networks: networks,
                    networkColors: networkColors,
                    networkImages: networkImages,
                    onNetworkSelected: (index) {
                      setState(() {
                        selectedNetwork = index;
                      });
                    },
                    selectedNetwork: selectedNetwork, 
                  ),
                  DataPurchaseTab(
                    networks: networks,
                    networkColors: networkColors,
                    selectedNetwork: selectedNetwork,
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
