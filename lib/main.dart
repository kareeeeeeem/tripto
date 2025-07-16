// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tripto/core/routes/app_routes.dart';
import 'package:tripto/presentation/pagess/NavBar/ActivityPage/activities_page.dart';
import 'package:tripto/presentation/pagess/SlideBar/ActivitiesCard.dart';

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
      // home: const ActivityCard(),
    );
  }
}
