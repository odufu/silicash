import 'package:flutter/material.dart';

class ReceiptCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(.1)),
                child: Image.asset("assets/images/appAssets/recciepticon.png")),
          ),
          SizedBox(height: 16),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildColumn("Narration", "Airtime"),
                _buildColumn("Channel", "MTN Airtime"),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildColumn("Phone Number", "0912345678"),
                _buildColumn("Debit/Credit", "Credit"),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildColumn("Currency", "Naira (₦)"),
                _buildColumn("Amount", "₦5,100"),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildColumn("Date", "Jul 27, 2022"),
                _buildColumn("Time", "06:15:22 PM"),
              ],
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildIconTextButton(
                  "assets/images/appAssets/share.png", "Share"),
              _buildIconTextButton(
                  "assets/images/appAssets/documentdownload.png", "Download"),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildColumn(String label, String value,
      {bool isHighlighted = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.grey[700]),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconTextButton(String icon, String label) {
    return TextButton.icon(
      onPressed: () {},
      icon: Image.asset(icon),
      label: Text(
        label,
        style: TextStyle(color: Colors.green),
      ),
    );
  }
}
