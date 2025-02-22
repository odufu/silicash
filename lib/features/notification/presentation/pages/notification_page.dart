import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:silicash_mobile/core/widgets/costum_app_bar.dart';
import 'package:silicash_mobile/core/theme/app_theme_extension.dart'; // Ensure this path is correct

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<NotificationItem> notifications = [
    NotificationItem(
      id: '1', // Unique ID for each notification
      title: 'Your withdrawal was Successful!',
      subtitle:
          'Withdrawal of NGN 50,000 to John Kuta, Moniepoint Bank was successful.',
      date: DateTime(2025, 2, 22, 9, 41), // Today (Feb 22, 2025)
      isRead: false,
    ),
    NotificationItem(
      id: '2', // Unique ID for each notification
      title: 'Your withdrawal was Successful!',
      subtitle:
          'Withdrawal of NGN 50,000 to John Kuta, Moniepoint Bank was successful.',
      date: DateTime(2025, 2, 21, 14, 30), // Yesterday (Feb 21, 2025)
      isRead: false,
    ),
    NotificationItem(
      id: '3', // Unique ID for each notification
      title: 'Your withdrawal was Successful!',
      subtitle:
          'Withdrawal of NGN 50,000 to John Kuta, Moniepoint Bank was successful.',
      date: DateTime(2025, 2, 20, 10, 15), // 2 days ago (Feb 20, 2025)
      isRead: false,
    ),
    NotificationItem(
      id: '4', // Unique ID for each notification
      title: 'Your withdrawal was Successful!',
      subtitle:
          'Withdrawal of NGN 50,000 to John Kuta, Moniepoint Bank was successful.',
      date: DateTime(2025, 2, 15, 8, 45), // Older (Feb 15, 2025)
      isRead: false,
    ),
  ];

  void _deleteNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
    // Show a snackbar to confirm deletion
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Notification deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              notifications.insert(index, notifications[index]);
            });
          },
        ),
      ),
    );
  }

  void _clearAllNotifications() {
    setState(() {
      notifications.clear();
    });
    // Show a snackbar to confirm clearing all notifications
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All notifications cleared'),
      ),
    );
  }

  String _getRelativeDateString(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else if (difference <= 7) {
      return '$difference days ago';
    } else {
      return DateFormat('MMM dd, yyyy').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Sort notifications by date (newest first)
    final sortedNotifications = notifications.toList()
      ..sort((a, b) => b.date.compareTo(a.date));

    // Group notifications by relative date
    final groupedNotifications = <String, List<NotificationItem>>{};
    for (var notification in sortedNotifications) {
      final dateLabel = _getRelativeDateString(notification.date);
      groupedNotifications.putIfAbsent(dateLabel, () => []).add(notification);
    }

    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor:
          Theme.of(context).colorScheme.surface, // Use theme-aware background
      body: groupedNotifications.isEmpty
          ? const Center(child: Text('No notifications'))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Notifications',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      TextButton(
                        onPressed: _clearAllNotifications,
                        child: Text(
                          'Clear',
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context)
                                .colorScheme
                                .error, // Use error color for contrast
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: groupedNotifications.length,
                    itemBuilder: (context, index) {
                      final dateLabel =
                          groupedNotifications.keys.toList()[index];
                      final dateNotifications =
                          groupedNotifications[dateLabel]!;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              dateLabel,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          ...dateNotifications.map((notification) {
                            final notificationIndex =
                                sortedNotifications.indexOf(notification);
                            return Dismissible(
                              key: Key(
                                  notification.id), // Use unique ID as the key
                              direction: DismissDirection
                                  .endToStart, // Allow swipe from right to left
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 16.0),
                                child: const Icon(Icons.delete,
                                    color: Colors.white),
                              ),
                              onDismissed: (direction) {
                                _deleteNotification(notificationIndex);
                              },
                              child: NotificationCard(
                                notification: notification,
                                onTap: () {
                                  setState(() {
                                    notification.isRead = true;
                                  });
                                },
                              ),
                            );
                          }),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

class NotificationItem {
  final String id; // Unique ID field
  final String title;
  final String subtitle;
  final DateTime date;
  bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.date,
    this.isRead = false,
  });
}

class NotificationCard extends StatelessWidget {
  final NotificationItem notification;
  final VoidCallback onTap;

  const NotificationCard({
    super.key,
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppThemeExtension>();
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      elevation: 0, // Flat design, no shadow
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      color: appTheme?.cardColor(context) ??
          Colors.white, // Use dynamic card color based on theme
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green[100],
          child: Image.asset(
            "assets/images/brand/logoColored.png", // Ensure this path is correct
            fit: BoxFit
                .contain, // Ensures the image fits well in the CircleAvatar
            errorBuilder: (context, error, stackTrace) {
              // Fallback if the image fails to load
              return const Icon(Icons.error, color: Colors.red);
            },
          ),
        ),
        title: Text(
          notification.title,
          style: TextStyle(
            // Restored GoogleFonts for consistency
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: notification.isRead ? Colors.grey : Colors.black,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.subtitle,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat('MMM dd, yyyy hh:mm a').format(notification.date),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
