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
          const Spacer(flex: 3),
          const Spacer(flex: 2),
         const Image(image: AssetImage('assets/splah.png')),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, AppRoutes.splash);
            },
            child: const Text("Let's Go"),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
