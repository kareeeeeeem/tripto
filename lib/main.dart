import 'package:flutter/material.dart';
import 'package:tripto/core/routes/app_routes.dart';
import 'package:tripto/presentation/pagess/RightButtonsPages/Favorite_page.dart';
import 'package:tripto/presentation/pagess/navbar_pages/Activity_details_page.dart';
import 'package:tripto/presentation/pagess/navbar_pages/activities.dart';
import 'package:tripto/presentation/pagess/navbar_pages/profile_page.dart';
import 'package:tripto/presentation/pagess/payment_option.dart';
import 'package:tripto/presentation/payment_destination.dart';

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
