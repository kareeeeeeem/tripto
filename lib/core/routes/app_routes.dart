import 'package:flutter/material.dart';
import 'package:tripto/features/splash/presentation/vedio_player_page.dart';
import 'package:tripto/features/splash/presentation/splash_page.dart';

import '../../features/splash/presentation/welcome_page.dart';

class AppRoutes {
  static const splash = '/';
  // static const home = '/home';
  static const welcome = '/welcomePage';
  static const videoPlayer = '/videoPlayer';





  static final routes = <String, WidgetBuilder>{
    splash: (context) => const splashpage(),
    // home: (context) => const WelcomeHomePage(),
    welcome: (context) => const WelcomePage(),
    videoPlayer: (context) => const VideoPlayerPage(),    


  };
}
