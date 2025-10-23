import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tripto/presentation/pages/NavBar/hotel/HotelCard.dart';
import 'package:tripto/core/constants/NavBar.dart';
import 'package:tripto/presentation/pages/NavBar/profile_logiin_sign_verfi/SignupOrLogin.dart';
import 'package:tripto/presentation/pages/NavBar/home/homepage/home_page.dart';
import 'package:tripto/presentation/pages/NavBar/profile_logiin_sign_verfi/profile_page.dart';
import 'package:tripto/presentation/pages/NavBar/SideMenu/SideMenu.dart';
import '../pages/NavBar/ActivityPage/activities_page.dart';

class App extends StatefulWidget {
  const App({super.key, this.initialIndex = 0});
  final int initialIndex;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late int _currentIndex;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  bool hasToken = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _checkToken();
  }

  Future<void> _checkToken() async {
    final token = await _storage.read(key: 'token');
    setState(() {
      hasToken = token != null && token.isNotEmpty;
    });
  }

  void _changePage(int index) async {
    if (index == 2) {
      await _checkToken();
    }
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomePage(), // index 0
      const Hotelcard(),
      const ActivityPage(), // index 1
      hasToken ? const ProfilePage() : const Signuporlogin(), // index 2
      // const FavoritePage(), // index 3
      const SideMenu(),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          pages[_currentIndex],
          if (!kIsWeb)
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
