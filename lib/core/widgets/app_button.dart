import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String buttonLabel;
  final void Function()? onclick;
  const AppButton({
    required this.buttonLabel,
    this.onclick,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onclick,
        style: IconButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(0),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                onclick == null
                    ? Theme.of(context).colorScheme.surface
                    : Theme.of(context).colorScheme.primary,
                onclick == null
                    ? Theme.of(context).colorScheme.surface
                    : Theme.of(context).colorScheme.secondary,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              buttonLabel,
              style: TextStyle(
                color: onclick == null
                    ? Theme.of(context).colorScheme.onSurface
                    : Theme.of(context).colorScheme.surface,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
