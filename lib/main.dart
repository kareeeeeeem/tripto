import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/routes/app_routes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isFirstTime = prefs.getBool('isFirstTime') ?? true;
  runApp(TripToApp(isFirstTime : isFirstTime));
}

class TripToApp extends StatelessWidget {
  final bool isFirstTime;
  const TripToApp({super.key , required this.isFirstTime});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TripTo',
      debugShowCheckedModeBanner: false,

      initialRoute: isFirstTime ? '/splash' : '/welcome',
      routes: AppRoutes.routes,
    );
  }
}
