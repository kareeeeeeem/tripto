import 'package:flutter/material.dart';
<<<<<<< HEAD
=======
import 'package:shared_preferences/shared_preferences.dart';
>>>>>>> 9b5221c54622dc8a0270a9f49a2044111d8581d9
import 'core/routes/app_routes.dart';

void main() {
  runApp(TripToApp());
}

class TripToApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TripTo',
      debugShowCheckedModeBanner: false,
    initialRoute: '/',

      routes: AppRoutes.routes,
    );
  }
}