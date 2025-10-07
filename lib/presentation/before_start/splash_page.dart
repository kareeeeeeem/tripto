// ignore_for_file: use_build_context_synchronously, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripto/presentation/app/app.dart';
import 'package:tripto/presentation/before_start/welcome_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkFirstLaunch();
  }

  Future<void> checkFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isFirstLaunch = prefs.getBool('first_launch');

    if (isFirstLaunch == null || isFirstLaunch == true) {
      await prefs.setBool('first_launch', false);
      await Future.delayed(const Duration(seconds: 3));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WelcomePage()),
      );
    } else {
      await Future.delayed(const Duration(seconds: 3));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const App()),
      );
    }
  }

@override
Widget build(BuildContext context) {
  final screenSize = MediaQuery.of(context).size;
  final isSmallScreen = screenSize.width < 600; 

  return Scaffold(
    backgroundColor: Colors.white,
    body: Center(
      child: Image.asset(
        "assets/images/splash.png",
        width: isSmallScreen ? screenSize.width : screenSize.width * 0.8,
        height: isSmallScreen ? screenSize.height : screenSize.height * 0.8,
        fit: isSmallScreen ? BoxFit.cover : BoxFit.contain,
      ),
    ),
  );
}

}
