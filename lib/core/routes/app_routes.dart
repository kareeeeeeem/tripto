import 'package:flutter/material.dart';
import '../../presentation/pagess/navbar_pages/home_page.dart';
import '../../presentation/before_start/splash_page.dart';
import '../../presentation/app/vedio_player_page.dart';
import '../../presentation/before_start/welcome_page.dart';

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
