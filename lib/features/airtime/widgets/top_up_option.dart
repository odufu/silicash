import 'package:flutter/material.dart';

class TopUpOptions extends StatefulWidget {
  final Size size;
  final Function(int) onSelectionChanged;

  TopUpOptions(
      {super.key, required this.size, required this.onSelectionChanged});

  @override
  State<TopUpOptions> createState() => _TopUpOptionsState();
}

class _TopUpOptionsState extends State<TopUpOptions> {
  int? selectedPrice; // Holds the currently selected price

  void handleSelection(int price) {
    setState(() {
      selectedPrice = price; // Update the selected price
    });
    widget.onSelectionChanged(price); // Notify the parent of the new selection
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [50, 100, 200, 500, 1000, 2000, 5000, 10000]
          .map(
            (price) => GestureDetector(
              onTap: () => handleSelection(price), // Handle price selection
              child: Container(
                width: widget.size.width / 4 - 20,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: selectedPrice == price
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context)
                          .colorScheme
                          .surface, // Highlight if selected
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "\u20a6$price",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
