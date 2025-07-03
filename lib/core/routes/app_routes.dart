import 'package:flutter/material.dart';
import 'package:tripto/core/constants/nav_bar.dart';
import 'package:tripto/features/splash/presentation/splash_page.dart';
import 'package:tripto/features/splash/presentation/vedio_player_page.dart';
import 'package:tripto/features/splash/presentation/welcome_page.dart';
import 'package:tripto/features/splash/presentation/home_page.dart';

class AppRoutes {
  static const splash = '/';
  static const welcome = '/welcomePage';
  static const videoPlayer = '/videoPlayer';
  static const home = '/home';
  static const navBar = '/navBar';

  static final routes = <String, WidgetBuilder>{
    splash: (context) =>  SplashScreen(),
    welcome: (context) => const WelcomePage(),
    videoPlayer: (context) => const VideoPlayerPage(),
    home: (context) => const HomePage(),
    navBar: (context) => const NavBar(),
  };
}
