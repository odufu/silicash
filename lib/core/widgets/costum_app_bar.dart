import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? action;
  final VoidCallback? onBackButtonPressed;

  CustomAppBar({
    this.action,
    this.onBackButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Determine if the current route can pop
    final bool canPop = ModalRoute.of(context)?.canPop ?? false;

    return PreferredSize(
      preferredSize: const Size.fromHeight(56), // Custom AppBar height
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // Show back button if onBackButtonPressed is provided or if the route can pop
                if (onBackButtonPressed != null || canPop)
                  IconButton(
                    icon: Image.asset("assets/images/brand/arrowLeft.png"),
                    onPressed: () {
                      if (onBackButtonPressed != null) {
                        onBackButtonPressed!();
                      } else if (canPop) {
                        Navigator.pop(context);
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
                    color: (onBackButtonPressed != null || canPop)
                        ? Colors.grey[800]
                        : Colors.grey[400],
                  ),
                ),
              ],
            ),
            if (action != null) action!,
          ],
        ),  
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
