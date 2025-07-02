import 'package:flutter/material.dart';
import '../../../../../core/routes/app_routes.dart';
import '../../../core/constants/button_lets.dart';

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
            image: AssetImage('assets/images/welcome.png'),
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
