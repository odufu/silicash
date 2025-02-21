import 'package:flutter/material.dart';
import 'package:silicash_mobile/core/theme/app_theme_extension.dart';

class RecentActivity extends StatelessWidget {
  final String title;
  final String provider;
  final String userId;
  final String date;

  const RecentActivity({
    super.key,
    required this.title,
    required this.provider,
    required this.date,
    required this.userId,
  });
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
      subtitle: Text("($provider Prepaid ($userId))"),
      trailing: Column(
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
          Text(date, style: TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}
