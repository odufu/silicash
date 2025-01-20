import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;
  final String date;
  final String time;
  final Color iconBackgroundColor;
  final String image;

  TransactionCard({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
    required this.time,
    required this.iconBackgroundColor,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Container(
          color: Colors.white, // Set the background color to white
          margin: EdgeInsets.all(0), // No margin
          padding: EdgeInsets.symmetric(
              vertical: 4.0), // Optional: Add vertical padding for spacing
          child: ListTile(
            leading: Container(
              width: 32.0,
              height: 32.0,
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                image,
              ),
            ),
            title: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(width: 4.0),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: Text(
              amount,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                color: Colors.red,
              ),
            ),
          ),
        ));
  }
}

class TransactionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final transactions = [
      TransactionCard(
        title: 'Electricity',
        subtitle: 'EKEDC Prepaid (1234567890)',
        amount: '-₦1,000',
        date: 'Jul 27, 2022',
        time: '6:15PM',
        iconBackgroundColor: Colors.red[100]!,
        image: "assets/images/appAssets/bill.png",
      ),
      TransactionCard(
        title: 'Data Top-up',
        subtitle: 'Data Subscription (0801234...)',
        amount: '-₦2,000',
        date: 'Jul 27, 2022',
        time: '6:15PM',
        iconBackgroundColor: Colors.red[100]!,
        image: "assets/images/appAssets/data.png",
      ),
      // Add more TransactionCard instances as needed
    ];

    return ListView.builder(
      shrinkWrap: true, // Makes the ListView take only the required height
      physics: NeverScrollableScrollPhysics(), // Prevents nested scrolling
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        return transactions[index];
      },
    );
  }
}
