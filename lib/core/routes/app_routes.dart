import 'package:flutter/material.dart';
import 'package:tripto/features/splash/presentation/vedio_player_page.dart';
import 'package:tripto/features/splash/presentation/welcome_home_page.dart';
import 'package:tripto/features/splash/presentation/welcome_home_page.dart';


class AppRoutes {
  static const splash = '/';
  static const welcome = '/welcome';
  static const videoPlayer = '/videoPlayer';





  static final routes = <String, WidgetBuilder>{

    welcome: (context) => const WelcomeHomePage(),
    videoPlayer: (context) => const VideoPlayerPage(),    


  };
}
