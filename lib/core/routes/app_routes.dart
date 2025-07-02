import 'package:flutter/material.dart';
import 'package:tripto/features/splash/splash_page.dart';


class AppRoutes {
  static const splash = '/';

  static final routes = <String, WidgetBuilder>{
    splash: (context) => const SplashPage(),
  };
}
