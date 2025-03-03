import 'package:flutter/material.dart';
import 'package:silicash_mobile/core/theme/app_theme_extension.dart';
import 'package:silicash_mobile/core/utils/helper_functions.dart';
import 'package:silicash_mobile/core/widgets/app_button.dart';
import 'package:silicash_mobile/core/widgets/costum_app_bar.dart';
import 'package:silicash_mobile/features/login/presentation/pages/login_page.dart';
import '../../../../core/theme/app_theme_extension.dart';
import '../../../login/data/services/login_service.dart';

class ProfilePage extends StatelessWidget {
  final LoginService loginService;
  const ProfilePage({Key? key, required this.loginService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardColor =
        Theme.of(context).extension<AppThemeExtension>()?.cardColor(context);
    final headingStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        );
    final labelStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14,
    );
    final valueStyle = const TextStyle(
      fontSize: 14,
    );
    bool? isVerified = false;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: CustomAppBar(),
        body: FutureBuilder<Map<String, String?>>(
          future: loginService.getStoredCredentials(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData) {
              return Center(child: Text('No user data found'));
            }
            final credentials = snapshot.data!;

            return SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TITLE
                  Row(
                    children: [
                      Text(
                        "Personal Information",
                        style: headingStyle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // User Avatar + Name
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.grey[300],
                      backgroundImage:
                          AssetImage("assets/images/appAssets/dp.jpg"),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      credentials['fullName']?.toUpperCase() ?? 'N/A',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // KYC Section
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: cardColor,
                    ),
                    child: Column(
                      children: [
                        // ... Keep existing KYC section unchanged ...
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // TITLE
                            Text(
                              'KYC Level',
                              style: labelStyle,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // PROGRESS BAR

                            Container(
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  Container(
                                    width: width * .9,
                                    height: 4,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withOpacity(.2)),
                                  ),
                                  Container(
                                    width: width * .4,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Theme.of(context).colorScheme.primary,
                                        Theme.of(context).colorScheme.secondary,
                                      ]),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          child: Image.asset(
                                              "assets/images/appAssets/check.png")),
                                      Container(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          child: Image.asset(
                                              "assets/images/appAssets/check.png")),
                                      Container(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          child: Image.asset(
                                              "assets/images/appAssets/check.png")),
                                    ],
                                  )
                                ],
                              ),
                            ),

                            // ROW LEVEL VERIFICATION
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text('Lvl 2'),
                                ),
                                isVerified
                                    ? Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 3),
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: const Text(
                                          "Veirified",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                    : TextButton(
                                        onPressed: () {
                                          // TODO: handle upgrade action
                                        },
                                        child: const Text('Upgrade Now'),
                                      ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(.2)),
                          child: Row(
                            children: [
                              Image.asset(
                                  "assets/images/appAssets/warning.png"),
                              const SizedBox(
                                width: 16,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                  width: width * .6,
                                  child: const Text(
                                    'Upgrade your account to enjoy greater transaction limits',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Personal Information
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Personal Information', style: headingStyle),
                  ),
                  const SizedBox(height: 16),

                  Container(
                    padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: cardColor,
                    ),
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            _InfoColumn(
                              label: 'Phone Number',
                              value: credentials['phone'] ?? 'N/A',
                              labelStyle: labelStyle,
                              valueStyle: valueStyle,
                            ),
                            _InfoColumn(
                              label: 'Email Address',
                              value: credentials['email'] ?? 'N/A',
                              labelStyle: labelStyle,
                              valueStyle: valueStyle,
                            ),
                            _InfoColumn(
                              label: 'Address',
                              value: '',
                              labelStyle: labelStyle,
                              valueStyle: valueStyle,
                            ),
                            _InfoColumn(
                              label: 'Date of Birth',
                              value: '',
                              labelStyle: labelStyle,
                              valueStyle: valueStyle,
                            ),
                            // Remove address and DOB fields as they're not in storage
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  // TODO: handle edit action
                                },
                                child: const Text('Edit'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Account Information
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Account Information', style: headingStyle),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: cardColor,
                    ),
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _InfoRow(
                              label: 'Currency',
                              value: 'Nigeria Naira',
                              labelStyle: labelStyle,
                              valueStyle: valueStyle,
                            ),
                            _InfoRow(
                              label: 'Account Name',
                              value: credentials['fullName'] ?? 'N/A',
                              labelStyle: labelStyle,
                              valueStyle: valueStyle,
                            ),
                            _InfoRow(
                              label: 'Account Number',
                              value: '',
                              labelStyle: labelStyle,
                              valueStyle: valueStyle,
                            ),
                            _InfoRow(
                              label: 'Bank',
                              value: 'Silicash MFB',
                              labelStyle: labelStyle,
                              valueStyle: valueStyle,
                            ),
                            const SizedBox(height: 36),
                            const SizedBox(height: 36),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Sign-out button
                  AppButton(
                    buttonLabel: "Sign Out",
                    onclick: () async {
                      await loginService.logout();
                      // Navigate to login screen - adjust route name as needed
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  LoginPage(loginService: loginService)));
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/// A simple reusable row widget for displaying label/value pairs.
class _InfoColumn extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  const _InfoColumn({
    Key? key,
    required this.label,
    required this.value,
    this.labelStyle,
    this.valueStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: labelStyle,
          ),
          Text(
            value,
            style: valueStyle,
          ),
        ],
      ),
    );
  }
}

/// A simple reusable row widget for displaying label/value pairs.
class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  const _InfoRow({
    Key? key,
    required this.label,
    required this.value,
    this.labelStyle,
    this.valueStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: labelStyle,
          ),
          Text(
            value,
            style: valueStyle,
          ),
        ],
      ),
    );
  }
}
