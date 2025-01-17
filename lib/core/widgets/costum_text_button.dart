import 'package:flutter/material.dart';

class CostumTextButton extends StatelessWidget {
  final String buttonLabel;
  final void Function()? onclick;
  const CostumTextButton({
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
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.surface),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              buttonLabel,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
        ),
      ),
    );
  }
}
