import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DepartureDateSelectorWidget extends StatefulWidget {
  final Function(DateTime?)
      onDateSelected; // Callback to return the departure date to the parent

  const DepartureDateSelectorWidget({super.key, required this.onDateSelected});

  @override
  State<DepartureDateSelectorWidget> createState() =>
      _DepartureDateSelectorWidgetState();
}

class _DepartureDateSelectorWidgetState
    extends State<DepartureDateSelectorWidget> {
  DateTime? _departureDate;
  final TextEditingController _departureDateController =
      TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _departureDate = picked;
          _departureDateController.text = "${picked.toLocal()}".split(' ')[0];
          // Call the callback to send the departure date back to the parent
          widget.onDateSelected(_departureDate);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text(
              'Departure Date',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _departureDateController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'DD/MM/YYYY',
            prefixIcon: Icon(Icons.calendar_today), // Simplified icon
          ),
          readOnly: true,
          onTap: () => _selectDate(context),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _departureDateController.dispose();
    super.dispose();
  }
}
