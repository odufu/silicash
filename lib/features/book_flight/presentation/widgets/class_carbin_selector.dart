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
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
          decoration: BoxDecoration(
            color: Theme.of(context)
                .extension<AppThemeExtension>()
                ?.cardColor(context),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              const double smallScreenWidth = 400; // Adjusted breakpoint
              bool isSmallScreen = constraints.maxWidth < smallScreenWidth;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Class/Cabin',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  isSmallScreen
                      ? Column(
                          children: [
                            _buildRadioOption('Economy', isSmallScreen),
                            _buildRadioOption('Business', isSmallScreen),
                            _buildRadioOption('First Class', isSmallScreen),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildRadioOption('Economy', isSmallScreen),
                            _buildRadioOption('Business', isSmallScreen),
                            _buildRadioOption('First Class', isSmallScreen),
                          ],
                        ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRadioOption(String value, bool isSmallScreen) {
    return isSmallScreen
        ? RadioListTile<String>(
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
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            activeColor: Theme.of(context).colorScheme.primary,
            contentPadding: EdgeInsets.zero,
            dense: true,
            controlAffinity: ListTileControlAffinity.trailing,
          )
        : Expanded(
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
                style: const TextStyle(
                  fontSize: 10,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.primary,
              contentPadding: EdgeInsets.zero,
              dense: true,
              controlAffinity: ListTileControlAffinity.leading,
            ),
          );
  }
}
