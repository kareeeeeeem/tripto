// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:tripto/presentation/app/app.dart';
import 'package:tripto/presentation/pagess/RightButtonsPages/CategoryCard.dart';
import 'package:tripto/presentation/pagess/navbar_pages/profile_page.dart';
import '../../presentation/pagess/navbar_pages/activities.dart';
import '../../presentation/pagess/navbar_pages/home_page.dart';
import '../../presentation/before_start/splash_page.dart';
import '../../presentation/app/vedio_player_page.dart';
import '../../presentation/before_start/welcome_page.dart';

class AppRoutes {
  static const splash = '/';
  static const welcome = '/welcomePage';
  static const app = '/app';
  static const videoPlayer = '/videoPlayer';
  static const home = '/home';
  static const activities = '/activities';
  // Category Routes
  static const categoryCard = '/CategoryCard';
  static const categoryGold = '/categoryGold';
  static const categoryDiamond = '/categoryDiamond';
  static const categoryPlatinum = '/categoryPlatinum';
  static const date = '/DateCard';
  static const profile = '/ProfileCard';

  static final routes = <String, WidgetBuilder>{
    splash: (context) => SplashScreen(),
    welcome: (context) => const WelcomePage(),
    app: (context) => const App(),
    videoPlayer: (context) => const VideoPlayerPage(),
    activities: (context) => const Activities(),
    home: (context) => const HomePage(),
    profile: (context) => ProfilePage(),
    // Category Pages
    categoryCard: (context) => const CategoryCard(),
  };
}
