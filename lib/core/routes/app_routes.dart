import 'package:flutter/material.dart';
import 'package:tripto/features/home_page.dart';
import 'package:tripto/features/splash/splash_page.dart';


class AppRoutes {
  static const splash = '/';
  static const home = '/home';

  static final routes = <String, WidgetBuilder>{
    splash: (context) => const SplashPage(),
    home: (context) => const HomePage(),
  };
}
