import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CustomCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
            color: value ? Colors.transparent : Colors.grey,
            width: 1,
          ),
          gradient: value
              ? LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: value ? null : Colors.transparent,
        ),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: value ? 1.0 : 0.0,
          child: AnimatedScale(
            scale: value ? 1.0 : 0.8,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: const Icon(Icons.check, size: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
