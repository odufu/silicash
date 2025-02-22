import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? action;
  final VoidCallback? onBackButtonPressed;

  const CustomAppBar({
    Key? key,
    this.action,
    this.onBackButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use Navigator.of(context).canPop() to check if the route can be popped.
    final bool canPop = Navigator.of(context).canPop();
    // Show back button if a callback is provided or if the navigator can pop.
    final bool showBackButton = onBackButtonPressed != null || canPop;

    // Determine the correct image path based on the theme
    final String arrowIconPath = Theme.of(context).brightness == Brightness.dark
        ? "assets/images/appAssets/arrowLeftDark.png"
        : "assets/images/brand/arrowLeft.png";

    return PreferredSize(
      preferredSize: const Size.fromHeight(56), // Height of the custom AppBar
      child: SafeArea(
        child: Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side: back button with text
              Row(
                children: [
                  if (showBackButton)
                    IconButton(
                      icon: Image.asset(
                        arrowIconPath,
                        errorBuilder: (context, error, stackTrace) {
                          // Fallback if the image fails to load
                          return Icon(
                            Icons.arrow_back_ios,
                            color: Theme.of(context).colorScheme.onSurface,
                          );
                        },
                      ),
                      tooltip:
                          MaterialLocalizations.of(context).backButtonTooltip,
                      onPressed: () {
                        if (onBackButtonPressed != null) {
                          onBackButtonPressed!();
                        } else if (canPop) {
                          Navigator.maybePop(context);
                        }
                      },
                    )
                  else
                    const SizedBox(width: 48), // Placeholder for alignment
                  Text(
                    'Back',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: showBackButton
                          ? Theme.of(context).colorScheme.onSurface
                          : Colors.grey[400],
                    ),
                  ),
                ],
              ),
              // Right side: optional action widget
              if (action != null) action!,
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
