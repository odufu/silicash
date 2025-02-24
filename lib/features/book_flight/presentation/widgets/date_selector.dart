import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelectorWidget extends StatefulWidget {
  final Function(DateTime?, DateTime?)
      onDatesSelected; // Callback to return dates to parent

  const DateSelectorWidget({super.key, required this.onDatesSelected});

  @override
  State<DateSelectorWidget> createState() => _DateSelectorWidgetState();
}

class _DateSelectorWidgetState extends State<DateSelectorWidget> {
  DateTime? _departureDate;
  DateTime? _returnDate;
  final TextEditingController _departureDateController =
      TextEditingController();
  final TextEditingController _returnDateController = TextEditingController();

  Future<void> _selectDate(BuildContext context, bool isDeparture) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          if (isDeparture) {
            _departureDate = picked;
            _departureDateController.text = "${picked.toLocal()}".split(' ')[0];
          } else {
            _returnDate = picked;
            _returnDateController.text = "${picked.toLocal()}".split(' ')[0];
          }
          // Call the callback to send dates back to the parent
          widget.onDatesSelected(_departureDate, _returnDate);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
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
                  hintText: 'Pick a date',
                  prefixIcon: Icon(Icons.calendar_today), // Simplified icon
                ),
                readOnly: true,
                onTap: () => _selectDate(context, true),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Text(
                    'Return Date',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _returnDateController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  hintText: 'Pick a date',
                  prefixIcon: Icon(Icons.calendar_today), // Simplified icon
                ),
                readOnly: true,
                onTap: () => _selectDate(context, false),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _departureDateController.dispose();
    _returnDateController.dispose();
    super.dispose();
  }
}
