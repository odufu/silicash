import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:silicash_mobile/core/widgets/app_button.dart';
import 'package:silicash_mobile/core/widgets/custom_dropdown_field.dart';
import 'package:silicash_mobile/features/book_flight/presentation/widgets/class_carbin_selector.dart';

class RoundTripTab extends StatefulWidget {
  const RoundTripTab({super.key});

  @override
  State<RoundTripTab> createState() => _RoundTripTabState();
}

class _RoundTripTabState extends State<RoundTripTab> {
  String? leavingFrom;
  String? goingTo;
  int _adultCount = 1; // Default to 1 Adult
  int _childCount = 0; // Default to 0 Children
  DateTime? _departureDate;
  DateTime? _returnDate;
  TextEditingController _returnDateController = TextEditingController();
  TextEditingController _departureDateController = TextEditingController();

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && mounted) {
      // Ensure the widget is still mounted
      // Defer the state update to ensure it's safe after the gesture
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          if (isStartDate) {
            _departureDate = picked;
            _departureDateController.text = "${picked.toLocal()}".split(' ')[0];
          } else {
            _returnDate = picked;
            _returnDateController.text = "${picked.toLocal()}".split(' ')[0];
          }
        });
      });
    }
  }

  void _showPassengersDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          void updateState(int newAdultCount, int newChildCount) {
            if (mounted) {
              // Ensure the widget is still mounted
              // Defer the state update to ensure it's safe after the gesture
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() {
                  _adultCount = newAdultCount;
                  _childCount = newChildCount;
                });
              });
            }
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Select Passengers',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                _buildPassengerCounter('Adults', _adultCount, (value) {
                  updateState(value, _childCount);
                }, min: 1, max: 9), // Minimum 1 Adult, maximum 9 total
                const SizedBox(height: 16.0),
                _buildPassengerCounter('Children', _childCount, (value) {
                  updateState(_adultCount, value);
                }, max: 8), // Maximum 8 Children (to stay under total 9)
                const SizedBox(height: 16.0),
                Text(
                  'Total: ${_adultCount + _childCount} Passengers',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (mounted) {
                      // Ensure the widget is still mounted
                      // Defer the state update to ensure it's safe after the gesture
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {});
                      });
                    }
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 24.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                  child: Text(
                    'Done',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPassengerCounter(
      String category, int count, ValueChanged<int> onChanged,
      {int min = 0, int max = 9}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          category,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove, color: Colors.grey),
              onPressed: count > min
                  ? () => onChanged(count - 1)
                  : null, // Disable if at minimum
            ),
            Text(
              '$count',
              style: TextStyle(fontSize: 16),
            ),
            IconButton(
              icon: const Icon(Icons.add, color: Colors.green),
              onPressed: count < max && (_adultCount + _childCount) < 9
                  ? () => onChanged(count + 1)
                  : null, // Disable if at maximum or total exceeds 9
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required TextEditingController controller,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
                fontSize: 14,
              ) ?? // Fallback style
              TextStyle(
                fontSize: 14,
              ),
        ),
        const SizedBox(height: 8.0),
        GestureDetector(
          behavior: HitTestBehavior.opaque, // Ensure proper hit testing
          onTap: () {
            // Defer the dialog opening to ensure it's safe after the gesture
            WidgetsBinding.instance.addPostFrameCallback((_) {
              onTap();
            });
          },
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  controller.text,
                  style: TextStyle(
                        fontSize: 16,
                      ) ?? // Fallback style
                      const TextStyle(
                        fontSize: 16,
                      ),
                ),
                Image.asset("assets/images/appAssets/arrowDowndark.png"),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime? value,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
                  fontSize: 14, color: Colors.grey[600]) ?? // Fallback style
              TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        const SizedBox(height: 8.0),
        GestureDetector(
          behavior: HitTestBehavior.opaque, // Ensure proper hit testing
          onTap: () {
            // Defer the date picker opening to ensure it's safe after the gesture
            WidgetsBinding.instance.addPostFrameCallback((_) {
              onTap();
            });
          },
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value == null
                      ? 'DD/MM/YYYY'
                      : DateFormat('dd/MM/yyyy').format(value),
                  style: TextStyle(
                          fontSize: 16,
                          color: Colors.black) ?? // Fallback style
                      const TextStyle(fontSize: 16, color: Colors.black),
                ),
                const Icon(Icons.calendar_today, color: Colors.black),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomDropdownField(
              label: "Leaving From",
              options: ["Uyo", "Abuja", "Port Harcourt"],
              selectedValue: leavingFrom,
              onChanged: (value) {
                if (mounted) {
                  // Ensure the widget is still mounted
                  // Defer the state update to ensure it's safe after the gesture
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      leavingFrom = value;
                    });
                  });
                }
              },
            ),
            const SizedBox(height: 16.0),
            CustomDropdownField(
              label: "Going To",
              options: ["Uyo", "Abuja", "Port Harcourt"],
              selectedValue: goingTo,
              onChanged: (value) {
                if (mounted) {
                  // Ensure the widget is still mounted
                  // Defer the state update to ensure it's safe after the gesture
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      goingTo = value;
                    });
                  });
                }
              },
            ),
            const SizedBox(height: 16.0),
            _buildDropdownField(
              label: 'Passengers',
              controller: TextEditingController(
                  text:
                      '$_adultCount Adult${_adultCount != 1 ? 's' : ''}, $_childCount Child${_childCount != 1 ? 'ren' : ''}'),
              onTap: _showPassengersDialog,
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Departure Date',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: _departureDateController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          hintText: 'Pick a date',
                          prefixIcon:
                              Image.asset("assets/images/appAssets/date.png"),
                        ),
                        readOnly: true,
                        onTap: () => _selectDate(context, true),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Return Date',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: _returnDateController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          hintText: 'Pick a date',
                          prefixIcon:
                              Image.asset("assets/images/appAssets/date.png"),
                        ),
                        readOnly: true,
                        onTap: () => _selectDate(context, false),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 16.0), // Added spacing before the button

            ClassCabinSelector(onChanged: (value) {}),
            const SizedBox(height: 16.0), // Added spacing before the button
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: AppButton(
                buttonLabel: "Search Flight",
                onclick: () {
                  print("Impliment Search Flight");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
