import 'package:flutter/material.dart';

class PassengerSelectorWidget extends StatefulWidget {
  final int initialAdultCount;
  final int initialChildCount;
  final Function(int, int)
      onPassengersSelected; // Callback to return counts to parent

  const PassengerSelectorWidget({
    super.key,
    this.initialAdultCount = 1, // Default to 1 adult
    this.initialChildCount = 0, // Default to 0 children
    required this.onPassengersSelected,
  });

  @override
  State<PassengerSelectorWidget> createState() =>
      _PassengerSelectorWidgetState();
}

class _PassengerSelectorWidgetState extends State<PassengerSelectorWidget> {
  late int _adultCount;
  late int _childCount;

  @override
  void initState() {
    super.initState();
    _adultCount = widget.initialAdultCount;
    _childCount = widget.initialChildCount;
  }

  void _showPassengerDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          void updateState(int newAdultCount, int newChildCount) {
            if (mounted) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setModalState(() {
                  _adultCount = newAdultCount;
                  _childCount = newChildCount;
                });
                setState(() {
                  _adultCount = newAdultCount;
                  _childCount = newChildCount;
                });
                widget.onPassengersSelected(_adultCount, _childCount);
              });
            }
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Select Passengers',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                _buildPassengerCounter('Adults', _adultCount, (value) {
                  updateState(value, _childCount);
                }, min: 1, max: 9),
                const SizedBox(height: 16.0),
                _buildPassengerCounter('Children', _childCount, (value) {
                  updateState(_adultCount, value);
                }, max: 8),
                const SizedBox(height: 16.0),
                Text(
                  'Total: ${_adultCount + _childCount} Passengers',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (mounted) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {});
                        widget.onPassengersSelected(_adultCount, _childCount);
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
                  child: const Text(
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
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove, color: Colors.grey),
              onPressed: count > min ? () => onChanged(count - 1) : null,
            ),
            Text('$count', style: const TextStyle(fontSize: 16)),
            IconButton(
              icon: const Icon(Icons.add, color: Colors.green),
              onPressed: count < max && (_adultCount + _childCount) < 9
                  ? () => onChanged(count + 1)
                  : null,
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showPassengerDialog,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$_adultCount Adult${_adultCount != 1 ? 's' : ''}, $_childCount Child${_childCount != 1 ? 'ren' : ''}',
              style: const TextStyle(fontSize: 16),
            ),
            const Icon(Icons.arrow_drop_down, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
