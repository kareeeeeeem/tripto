import 'package:flutter/material.dart';
import '../../features/presentation/nav_bar_pages/home_page.dart';
import '../../features/presentation/splash_page.dart';
import '../../features/presentation/vedio_player_page.dart';
import '../../features/presentation/welcome_page.dart';

class AppRoutes {
  static const splash = '/';
  static const welcome = '/welcomePage';
  static const videoPlayer = '/videoPlayer';
  static const home = '/home';
  static const navBar = '/navBar';
  // static const activities = '/activities';

  static final routes = <String, WidgetBuilder>{
    splash: (context) =>  SplashScreen(),
    welcome: (context) => const WelcomePage(),
    videoPlayer: (context) => const VideoPlayerPage(),
    home: (context) => const HomePage(),
 
    // activities: (context) => const activities(),
  };
}
