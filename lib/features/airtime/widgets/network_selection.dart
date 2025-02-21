import 'package:flutter/material.dart';

class NetworkSelection extends StatelessWidget {
  final List<String> networks;
  final List<String> networkImages;
  final List<Color> networkColors;
  final int selectedNetwork;
  final Function(int) onNetworkSelected;

  const NetworkSelection({
    required this.networks,
    required this.networkColors,
    required this.selectedNetwork,
    required this.onNetworkSelected,
    required this.networkImages,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: networks.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onNetworkSelected(index),
            child: Container(
              width: 80,
              margin: EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: selectedNetwork == index
                    ? networkColors[index].withOpacity(0.2)
                    : Colors.white,
                border: Border.all(
                  color: selectedNetwork == index
                      ? networkColors[index]
                      : Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(networkImages[index]),
                  SizedBox(height: 8),
                  Text(
                    networks[index],
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
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
