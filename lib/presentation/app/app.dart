// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:tripto/core/constants/CustomBottomNavBar.dart';
import 'package:tripto/presentation/pagess/Login_pages/SignupOrLogin.dart';
import 'package:tripto/presentation/app/vedio_player_page.dart';
import 'package:tripto/presentation/pagess/NavBar/home_page.dart';
import '../pagess/NavBar/Favorite_page.dart';
import '../pagess/NavBar/ActivityPage/activities_page.dart';

class App extends StatefulWidget {
  const App({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  final List<Widget> _pages = [
    const HomePage(),
    const ActivityPage(),
    const Signuporlogin(),
    const FavoritePage(),
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

          /// شريط التنقل السفلي المستقل
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomBottomNavBar(
              currentIndex: _currentIndex,
              onTap: _changePage,
            ),
          ),
        ],
      ),
    );
  }
}
