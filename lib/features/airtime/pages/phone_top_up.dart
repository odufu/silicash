import 'package:flutter/material.dart';

class PhoneTopUpPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _PhoneTopUpPageState createState() => _PhoneTopUpPageState();
}

class _PhoneTopUpPageState extends State<PhoneTopUpPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Buy Airtime & Data"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          elevation: 0,
        ),
        body: Column(
          children: [
            // Tabs for Airtime and Data
            Container(
              color: Colors.grey.shade200,
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                labelColor: Colors.green,
                unselectedLabelColor: Colors.black54,
                tabs: const [
                  Tab(text: "Airtime"),
                  Tab(text: "Data"),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Airtime Tab
                  AirtimeTab(),
                  // Data Tab
                  DataTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AirtimeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Recent", style: TextStyle(fontWeight: FontWeight.bold)),
          const ListTile(
            leading: Icon(Icons.phone_android, color: Colors.red),
            title: Text("Airtime Top-up"),
            subtitle: Text("08023439465"),
            trailing: Text("-₦2000"),
          ),
          const SizedBox(height: 16),
          const Text("Choose Network",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NetworkButton(label: "MTN"),
              NetworkButton(label: "AIRTEL"),
              NetworkButton(label: "GLO"),
              NetworkButton(label: "ETISALAT"),
            ],
          ),
          const SizedBox(height: 16),
          Text("Top Up",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold)),
          const Wrap(
            spacing: 8,
            children: [
              AmountButton(amount: "₦100"),
              AmountButton(amount: "₦200"),
              AmountButton(amount: "₦500"),
              AmountButton(amount: "₦1000"),
              AmountButton(amount: "₦2000"),
              AmountButton(amount: "₦5000"),
            ],
          ),
          const SizedBox(height: 16),
          const TextField(
            decoration: InputDecoration(
              labelText: "Amount",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          const TextField(
            decoration: InputDecoration(
              labelText: "Phone Number",
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.contact_phone),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }
}

class DataTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Recent", style: TextStyle(fontWeight: FontWeight.bold)),
          const ListTile(
            leading: Icon(Icons.data_usage, color: Colors.red),
            title: Text("Data subscription"),
            subtitle: Text("08023439465"),
            trailing: Text("-₦2000"),
          ),
          const SizedBox(height: 16),
          const Text("Choose Network",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NetworkButton(label: "MTN"),
              NetworkButton(label: "AIRTEL"),
              NetworkButton(label: "GLO"),
              NetworkButton(label: "ETISALAT"),
            ],
          ),
          const SizedBox(height: 16),
          const Text("Data Plan",
              style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 2,
              children: const [
                DataPlanButton(label: "500MB 1 Day"),
                DataPlanButton(label: "1GB 2 Days"),
                DataPlanButton(label: "2GB 7 Days"),
                DataPlanButton(label: "5GB 30 Days"),
                DataPlanButton(label: "10GB 30 Days"),
                DataPlanButton(label: "Unlimited"),
              ],
            ),
          ),
          const TextField(
            decoration: InputDecoration(
              labelText: "Phone Number",
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.contact_phone),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Checkbox(value: false, onChanged: (val) {}),
              const Text("Auto-Subscribe"),
            ],
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }
}

class NetworkButton extends StatelessWidget {
  final String label;

  const NetworkButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.surface,
        backgroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      child: Text(label),
    );
  }
}

class AmountButton extends StatelessWidget {
  final String amount;

  const AmountButton({required this.amount});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.surface,
        backgroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      child: Text(amount),
    );
  }
}

class DataPlanButton extends StatelessWidget {
  final String label;

  const DataPlanButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.surface,
        backgroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      child: Text(label, textAlign: TextAlign.center),
    );
  }
}
