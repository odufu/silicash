import 'package:flutter/material.dart';
import 'package:silicash_mobile/core/widgets/costum_app_bar.dart';
import 'package:silicash_mobile/features/book_flight/presentation/screens/round_trip_tab.dart';

class BookFlightPage extends StatefulWidget {
  @override
  _BookFlightPageState createState() => _BookFlightPageState();
}

class _BookFlightPageState extends State<BookFlightPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedNetwork = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Book flight",
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
                      Tab(text: 'Round Trip'),
                      Tab(text: 'One Way'),
                      Tab(text: 'Multi City'),
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
                    RoundTripTab(),
                    Center(
                      child: Text("One Way"),
                    ),
                    Center(
                      child: Text("Multi City"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
