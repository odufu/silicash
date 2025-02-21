import 'package:flutter/material.dart';
import 'package:silicash_mobile/core/theme/app_theme_extension.dart';

class RecentActivityCard extends StatelessWidget {
  final String title;

  const RecentActivityCard({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor:
          Theme.of(context).extension<AppThemeExtension>()?.cardColor(context),
      contentPadding: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      leading: CircleAvatar(
        backgroundColor: Colors.red.withOpacity(0.2),
        child: Image.asset("assets/images/appAssets/data.png"),
      ),
      title: Text(title),
      subtitle: const Text("(080123456789)"),
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
