import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  final String label;
  final List<String> options;
  final String? selectedValue;
  final Function(String) onChanged;

  const CustomDropdownField({
    Key? key,
    required this.label,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: selectedValue,
          items: options
              .map(
                  (value) => DropdownMenuItem(value: value, child: Text(value)))
              .toList(),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          icon: Image.asset(
            "assets/images/appAssets/arrowDown.png",
            width: 20, // Adjust size as needed
            height: 20,
          ),
          validator: (value) => value == null ? '$label is required' : null,
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
            }
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
