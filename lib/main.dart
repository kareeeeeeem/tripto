import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripto/features/presentation/activities.dart';
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
    // initialRoute: '/',
      home: Activities(),

      // routes: AppRoutes.routes,
    );
  }
}