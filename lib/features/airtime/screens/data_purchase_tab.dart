import 'package:flutter/material.dart';

class DataPurchaseTab extends StatelessWidget {
  final List<String> networks;
  final List<Color> networkColors;
  final int selectedNetwork;

  const DataPurchaseTab({
    required this.networks,
    required this.networkColors,
    required this.selectedNetwork,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Data Purchase Tab is under construction!"),
    );
  }
}
