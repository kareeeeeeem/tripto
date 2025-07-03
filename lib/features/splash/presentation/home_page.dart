import 'package:flutter/material.dart';
import 'package:tripto/features/presentation/vedio_player_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _navItems = [
    {
      'icon': Icons.home,
      'page': const VideoPlayerPage(),
    },
    {
      'icon': Icons.grid_view,
      'page': const Center(
        child: Text("Activities", style: TextStyle(color: Colors.white)),
      ),
    },
    {
      'icon': Icons.person_outline,
      'page': const Center(
        child: Text("Profile Page", style: TextStyle(color: Colors.white)),
      ),
    },
    {
      'icon': Icons.favorite_border,
      'page': const Center(
        child: Text("Favorites", style: TextStyle(color: Colors.white)),
      ),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _navItems[_currentIndex]['page'],
          _buildBottomNavBar(),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Positioned(
      bottom: 30,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            color: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                _navItems.length,
                (index) => _buildNavItem(_navItems[index]['icon'], index),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Icon(
        icon,
        color: _currentIndex == index ? Colors.white : Colors.grey,
        size: 28,
      ),
    );
  }
}
