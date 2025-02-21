import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:silicash_mobile/features/home/screens/home_screen.dart';

import '../screens/home_screen2.dart';

class HomePage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _screens = [
    HomeScreen2(),
    HomeScreen(),
    const Center(child: Text('Payments Screen')),
    const Center(child: Text('More Screen')),
  ];

// Initialize the audio player (can be made static for reuse across taps)
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> _playClickSound() async {
    try {
      await _audioPlayer.play(AssetSource('audio/page.mp3'));
    } catch (e) {
      print('Error playing sound: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: _screens,
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.black : Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                unselectedImagePath:
                    'assets/images/appAssets/home_outlined.png',
                selectedImagePath: 'assets/images/appAssets/home.png',
                label: 'Home',
                isSelected: _selectedIndex == 0,
                onTap: () => _onItemTapped(0),
                gradientColors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary
                ],
                isCompact: screenWidth < 450,
              ),
              _buildNavItem(
                unselectedImagePath:
                    'assets/images/appAssets/expense_outlined.png',
                selectedImagePath: 'assets/images/appAssets/expense.png',
                label: 'Expenses',
                isSelected: _selectedIndex == 1,
                onTap: () => _onItemTapped(1),
                isCompact: screenWidth < 450,
                gradientColors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary
                ],
              ),
              _buildNavItem(
                unselectedImagePath:
                    'assets/images/appAssets/card_outlined.png',
                selectedImagePath: 'assets/images/appAssets/card.png',
                label: 'Cards',
                isSelected: _selectedIndex == 2,
                onTap: () => _onItemTapped(2),
                isCompact: screenWidth < 450,
                gradientColors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary
                ],
              ),
              _buildNavItem(
                unselectedImagePath:
                    'assets/images/appAssets/more_menu_outlined.png',
                selectedImagePath: 'assets/images/appAssets/more_menu.png',
                label: 'More',
                isSelected: _selectedIndex == 3,
                onTap: () => _onItemTapped(3),
                isCompact: screenWidth < 450,
                gradientColors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeInOut,
    );
  }

  Widget _buildNavItem({
    required String unselectedImagePath,
    required String selectedImagePath,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    List<Color>? gradientColors,
    required bool isCompact,
  }) {
    return Flexible(
      child: GestureDetector(
        onTap: () {
          _playClickSound(); // Play the sound when the item is tapped
          onTap(); // Execute the provided callback
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: isCompact
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: ShaderMask(
                        key: ValueKey(isSelected),
                        shaderCallback: (bounds) {
                          return LinearGradient(
                            colors: isSelected
                                ? (gradientColors ??
                                    [Colors.green, Colors.lightGreen])
                                : [Colors.grey, Colors.grey],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                        },
                        child: Image.asset(
                          isSelected ? selectedImagePath : unselectedImagePath,
                          key: ValueKey(isSelected),
                          width: isSelected ? 32 : 28,
                          height: isSelected ? 32 : 28,
                          color: Colors.white, // Masked with gradient
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: isSelected ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          label,
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: ShaderMask(
                        key: ValueKey(isSelected),
                        shaderCallback: (bounds) {
                          return LinearGradient(
                            colors: isSelected
                                ? (gradientColors ??
                                    [Colors.green, Colors.lightGreen])
                                : [Colors.grey, Colors.grey],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                        },
                        child: Image.asset(
                          isSelected ? selectedImagePath : unselectedImagePath,
                          key: ValueKey(isSelected),
                          width: isSelected ? 32 : 28,
                          height: isSelected ? 32 : 28,
                          color: Colors.white, // Masked with gradient
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: isSelected ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          label,
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
