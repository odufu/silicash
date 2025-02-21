import 'package:flutter/material.dart';

class BettingProviderSelection extends StatelessWidget {
  final List<String> providers;
  final List<String> providerImages;
  final List<Color> providerColors;
  final int selectedProvider;
  final Function(int) onProviderSelected;

  const BettingProviderSelection({
    required this.providers,
    required this.providerColors,
    required this.selectedProvider,
    required this.onProviderSelected,
    required this.providerImages,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: providers.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onProviderSelected(index),
            child: Container(
              width: 100,
              margin: EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border.all(
                  width: 2,
                  color: selectedProvider == index
                      ? Theme.of(context).colorScheme.primary
                      : Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(providerImages[index]),
                  SizedBox(height: 8),
                  Text(
                    providers[index],
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
