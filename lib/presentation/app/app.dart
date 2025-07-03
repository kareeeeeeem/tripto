import 'package:flutter/material.dart';
import 'package:tripto/core/constants/nav_bar.dart';
import 'package:tripto/presentation/app/vedio_player_page.dart';


//will named app


class app extends StatefulWidget {
  const app({super.key});

  @override
  State<app> createState() => _appState();
}

class _appState extends State<app> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    VideoPlayerPage(),
    //ActivitiesPage(),
    //profilePage(),
    //FavoritesPage(),
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
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: NavBar(
              currentIndex: _currentIndex,
              onTabSelected: _changePage,
            ),
          ),
        ],
      ),
    );
  }
}
