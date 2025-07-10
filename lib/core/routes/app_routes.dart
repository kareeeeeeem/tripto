// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:tripto/presentation/app/app.dart';
import 'package:tripto/presentation/pagess/RightButtonsPages/CategoryCard.dart';
import 'package:tripto/presentation/pagess/navbar_pages/profile_page.dart';
// import '../../data/models/activity_model.dart';
import '../../presentation/pagess/RightButtonsPages/Favorite_page.dart';
import '../../presentation/pagess/navbar_pages/Activity_details_page.dart';
import '../../presentation/pagess/navbar_pages/activities.dart';
import '../../presentation/pagess/navbar_pages/home_page.dart';
import '../../presentation/before_start/splash_page.dart';
import '../../presentation/app/vedio_player_page.dart';
import '../../presentation/before_start/welcome_page.dart';
import '../../presentation/pagess/payment_option.dart';
import '../../presentation/payment_destination.dart';
import '../models/activity_model.dart';

class AppRoutes {
  static const splash = '/';
  static const welcome = '/welcomePage';
  static const app = '/app';
  static const videoPlayer = '/videoPlayer';
  static const home = '/home';
  static const activities = '/activities';
  static const paymentOption = '/paymentOption';
  static const paymentDestination = '/paymentDestination';
  // Category Routes
  static const categoryCard = '/CategoryCard';
  static const categoryGold = '/categoryGold';
  static const categoryDiamond = '/categoryDiamond';
  static const categoryPlatinum = '/categoryPlatinum';
  static const date = '/DateCard';
  static const profile = '/ProfileCard';
  static const activityDetailsPageRoute = '/activityDetailsPage';
  static const savedHistory = '/savedHistory';

  static final routes = <String, WidgetBuilder>{
    splash: (context) => SplashScreen(),
    welcome: (context) => const WelcomePage(),
    app: (context) => const App(),
    videoPlayer: (context) => const VideoPlayerPage(),
    activities: (context) => const Activities(),
    home: (context) => const HomePage(),
    profile: (context) => ProfilePage(),
    paymentOption: (context) => const PaymentOption(),
    paymentDestination: (context) => const PaymentDestination(),
    savedHistory: (context) => const Saved_History(),
    activityDetailsPageRoute: (context) {
      final activity = ModalRoute.of(context)!.settings.arguments as Activitymodel;
      return ActivityDetailsPage(activity: activity);
    },
    // Category Pages
    categoryCard: (context) => const CategoryCard(),
  };
}
