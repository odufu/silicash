import 'package:flutter/material.dart';

class DataOption extends StatefulWidget {
  final Size size;
  final Function(int) onSelectionChanged;

  DataOption({super.key, required this.size, required this.onSelectionChanged});

  @override
  State<DataOption> createState() => _DataOptionState();
}

class _DataOptionState extends State<DataOption> {
  int? selectedPrice; // Holds the currently selected price

  // Handle selection and notify parent
  void handleSelection(int price) {
    setState(() {
      selectedPrice = price; // Update the selected price
    });
    widget.onSelectionChanged(price); // Notify the parent of the new selection
  }

  @override
  Widget build(BuildContext context) {
    // Define your data options
    final List<Map<String, dynamic>> dataOptions = [
      {"qty": 1.5, "duration": "2 days", "price": 200},
      {"qty": 2.0, "duration": "3 days", "price": 300},
      {"qty": 3.5, "duration": "5 days", "price": 500},
      {"qty": 5.0, "duration": "7 days", "price": 1000},
      {"qty": 1.5, "duration": "2 days", "price": 124},
      {"qty": 2.0, "duration": "3 days", "price": 245},
      {"qty": 3.5, "duration": "5 days", "price": 350},
      {"qty": 5.0, "duration": "7 days", "price": 3000},
    ];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: dataOptions
          .map(
            (option) => GestureDetector(
              onTap: () =>
                  handleSelection(option["price"]), // Handle price selection
              child: Container(
                width: widget.size.width / 4 -
                    20, // Adjust width for a better layout
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: selectedPrice == option["price"]
                      ? Theme.of(context).colorScheme.secondary
                      : Colors.white, // Highlight if selected
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${option["qty"]}GB", // Display data quantity
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      option["duration"], // Display duration
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "\u20a6${option["price"]}", // Display price
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
