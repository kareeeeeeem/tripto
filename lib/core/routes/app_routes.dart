import 'package:flutter/material.dart';
import 'package:tripto/features/splash/presentation/home_page.dart';
import 'package:tripto/features/splash/presentation/vedio_player_page.dart';
import 'package:tripto/features/splash/presentation/welcome_page.dart';

class AppRoutes {

  static const welcome = '/welcomePage';
  static const videoPlayer = '/videoPlayer';
  static const home = '/home'; // ممكن تفعّله لاحقًا





  static final routes = <String, WidgetBuilder>{
    welcome: (context) => const WelcomePage(),
    videoPlayer: (context) => const VideoPlayerPage(),
   // home: (context) => const HomePage(), // فعل السطر لو الصفحة جاهزة
  };
}
