import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;

  CustomAppBar({required this.context});

  @override
  Widget build(BuildContext context) {
    // Check if the navigator can pop
    final bool canPop = Navigator.canPop(context);

    return PreferredSize(
      preferredSize: Size.fromHeight(56), // Height of the custom AppBar
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            IconButton(
              icon: Image.asset("assets/images/brand/arrowLeft.png"),
              onPressed: canPop
                  ? () {
                      Navigator.pop(context); // Navigate back
                    }
                  : null, // Disable button if cannot pop
            ),
            Text(
              'Back',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: canPop ? Colors.grey[800] : Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
