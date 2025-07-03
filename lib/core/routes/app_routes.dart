import 'package:flutter/material.dart';

import '../../features/presentation/activities.dart';
import '../../features/presentation/home_page.dart';
import '../../features/presentation/splash_page.dart';
import '../../features/presentation/vedio_player_page.dart';
import '../../features/presentation/welcome_page.dart';
import '../constants/nav_bar.dart';

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
    navBar: (context) => const NavBar(),
    // activities: (context) => const activities(),
  };
}
