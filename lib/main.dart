import 'package:flutter/material.dart';
import 'package:tripto/core/routes/app_routes.dart';

void main() {
  runApp(const TripToApp());
}

class TripToApp extends StatelessWidget {
  const TripToApp({super.key});

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
