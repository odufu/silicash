import 'package:flutter/material.dart';
import 'package:silicash_mobile/core/theme/app_theme_extension.dart';

class ClassCabinSelector extends StatefulWidget {
  final String? initialValue; // Initial selected value
  final ValueChanged<String?> onChanged; // Callback to notify parent of changes

  const ClassCabinSelector({
    Key? key,
    this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<ClassCabinSelector> createState() => _ClassCabinSelectorState();
}

class _ClassCabinSelectorState extends State<ClassCabinSelector> {
  String? _selectedValue; // Track the selected value

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue; // Set initial value from parent
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Class/Cabin',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors
                .grey[600], // Matches the green-grey tone in the screenshot
          ),
        ),
        const SizedBox(height: 8.0),
        Stack(
          children: [
            // Container(
            //   width: 200,
            //   height: 200,
            //   decoration:
            //       BoxDecoration(color: Theme.of(context).colorScheme.primary),
            // ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .extension<AppThemeExtension>()
                    ?.cardColor(context),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                    color:
                        Colors.grey[300]!), // Grey border as in the screenshot
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildRadioOption(
                    'Economy',
                  ),
                  _buildRadioOption(
                    'Business',
                  ),
                  _buildRadioOption(
                    'First Class',
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildRadioOption(String value) {
    return Expanded(
      child: RadioListTile<String>(
        value: value,
        groupValue: _selectedValue,
        onChanged: (newValue) {
          if (newValue != null) {
            setState(() {
              _selectedValue = newValue;
            });
            widget.onChanged(newValue); // Notify parent of the change
          }
        },
        title: Text(
          value,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        activeColor: Colors.green, // Green checkmark for selected option
        contentPadding:
            EdgeInsets.zero, // Remove default padding for compact layout
        dense: true, // Makes the radio button more compact
      ),
    );
  }
}
