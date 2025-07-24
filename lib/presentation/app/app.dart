import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tripto/core/constants/NavBar.dart';
import 'package:tripto/presentation/pagess/Login_pages/SignupOrLogin.dart';
import 'package:tripto/presentation/pagess/NavBar/home_page.dart';
import 'package:tripto/presentation/pagess/NavBar/profile_page.dart';
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
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

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

  void _changePage(int index) async {
    if (index == 2) {
      final token = await _storage.read(key: 'token');
      if (token != null && token.isNotEmpty) {
        // لو فيه توكن → نفتح صفحة البروفايل
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ProfilePage()),
        );
        return;
      }
    }

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
