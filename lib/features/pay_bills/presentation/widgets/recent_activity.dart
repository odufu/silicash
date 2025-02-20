import 'package:flutter/material.dart';

class RecentActivity extends StatelessWidget {
  final String title;

  const RecentActivity({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      contentPadding: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      leading: CircleAvatar(
        backgroundColor: Colors.red.withOpacity(0.2),
        child: Image.asset("assets/images/appAssets/data.png"),
      ),
      title: Text(title),
      subtitle: const Text("(EKEDC Prepaid (1234567890))"),
      trailing: const Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "-\u20a62,000",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text("Jul 27, 2022 6:15PM",
              style: TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}
