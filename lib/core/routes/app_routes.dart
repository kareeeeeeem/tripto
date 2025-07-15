// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:tripto/presentation/CarDetials.dart';
import 'package:tripto/core/models/CarModel.dart';
import 'package:tripto/presentation/app/app.dart';
import 'package:tripto/presentation/pagess/NavBar/Favorite_page.dart';
import 'package:tripto/presentation/pagess/SlideBar/CarCard.dart';
import 'package:tripto/presentation/pagess/SlideBar/CategoryCard.dart';
import 'package:tripto/presentation/pagess/NavBar/profile_page.dart';
// import '../../data/models/activity_model.dart';
import '../../presentation/pagess/NavBar/Favorite_page.dart';
import '../../presentation/pagess/NavBar/Activity_details_page.dart';
import '../../presentation/pagess/NavBar/activities_page.dart';
import '../../presentation/pagess/NavBar/home_page.dart';
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
  static const FavoritePage = '/FavoritePage';

  static const carCardRoute = 'carCard';
  static const carSelectionPage = '/carSelectionPage';

  static final routes = <String, WidgetBuilder>{
    splash: (context) => SplashScreen(),
    welcome: (context) => const WelcomePage(),
    app: (context) => App(),
    videoPlayer: (context) => const VideoPlayerPage(),
    activities: (context) => const Activities(),
    home: (context) => const HomePage(),
    profile: (context) => ProfilePage(),
    paymentOption: (context) => const PaymentOption(),
    paymentDestination: (context) => const PaymentDestination(),
    // favoritePage: (context) => const FavoritePage(),
    activityDetailsPageRoute: (context) {
      final activity =
          ModalRoute.of(context)!.settings.arguments as Activitymodel;
      return ActivityDetailsPage(activity: activity);
    },
    // Category Pages
    categoryCard: (context) => const CategoryCard(),

    carCardRoute: (context) {
      final car = ModalRoute.of(context)!.settings.arguments as Carmodel;
      return CarCard(car: car);
    },

    carSelectionPage: (context) => const CarSelectionPage(), // ✅ الإضافة هنا
  };
}

//
