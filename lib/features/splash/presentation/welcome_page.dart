import 'package:flutter/material.dart';
import 'package:tripto/core/constants/ConstButton.dart';
import '../../../../../core/routes/app_routes.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage('assets/splash.png'),
          ),
          const SizedBox(height: 222),

          ConstButton(
            text: "Let's Go",
            onPressed: () {
              Navigator.pushReplacementNamed(context, AppRoutes.videoPlayer);
            },
          ),
        ],
      ),
    );
  }
}
