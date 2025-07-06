import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripto/core/constants/button_lets.dart';
import 'package:tripto/core/routes/app_routes.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(image: AssetImage('assets/images/welcome.png')),
          const SizedBox(height: 222),
          ConstButton(
            text: "Let's Go",
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isFirstTime', false);
              Navigator.pushReplacementNamed(context, AppRoutes.app);
            },
          ),
        ],
      ),
    );
  }
}
