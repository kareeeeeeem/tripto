import 'package:flutter/material.dart';
import 'package:tripto/core/constants/RightButtons.dart';
import 'package:tripto/presentation/app/vedio_player_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    VideoPlayerPage(),
    Center(child: Text("Activities Page", style: TextStyle(color: Colors.white))),
    Center(child: Text("Profile Page", style: TextStyle(color: Colors.white))),
    Center(child: Text("Favorites Page", style: TextStyle(color: Colors.white))),
  ];

  final List<IconData> _icons = const [
    Icons.home,
    Icons.extension,
    Icons.person_2_outlined,
    Icons.favorite_border,
  ];

  void _changePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _pages[_currentIndex],

          // ✅ Right Side Buttons
          const RightButtons(),

          // ✅ Bottom Navigation
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30, left: 32, right: 32),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  color: Colors.black.withOpacity(0.8),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(_icons.length, (index) {
                      return GestureDetector(
                        onTap: () => _changePage(index),
                        child: Icon(
                          _icons[index],
                          color: _currentIndex == index ? Colors.white : Colors.grey,
                          size: 28,
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
