import 'package:flutter/material.dart';
import '../../../../core/routes/app_routes.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage('assets/splash.png'),
          ),
          const SizedBox(height: 70),

          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, AppRoutes.videoPlayer);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 111, vertical: 22),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0), // مستطيل بحواف ناعمة
              ),
            ),
            child: const Text(
              "Let's Go",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
