import 'package:flutter/material.dart';
import 'package:tripto/presentation/pages/SlideBar/car/CarDetials.dart';
import 'package:tripto/core/models/CarModel.dart';
import 'package:tripto/presentation/app/app.dart';
import 'package:tripto/presentation/pages/SlideBar/category/CategoryCard.dart';
import 'package:tripto/presentation/pages/NavBar/profile_logiin_sign_verfi/profile_page.dart';
import '../../presentation/pages/NavBar/ActivityPage/activity_details_page.dart';
import '../../presentation/pages/NavBar/homePage/home_page.dart';
import '../../presentation/before_start/splash_page.dart';
import '../../presentation/pages/NavBar/homePage/VedioPlayerPage.dart';
import '../../presentation/before_start/welcome_page.dart';
import '../../presentation/pages/screens/payment/payment_option.dart';
import '../../presentation/pages/screens/payment/payment_destination.dart';
import '../models/activityPageModel.dart';

class AppRoutes {
  static const splash = '/splas';
  static const welcome = '/welcomePage';
  static const app = '/app';
  static const videoPlayer = '/videoPlayer';
  static const home = '/home';
  static const activities = '/activities';
  static const paymentOption = '/paymentOption';
  static const paymentDestination = '/paymentDestination';
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
    videoPlayer: (context) => const VideoPlayerScreen(),
    home: (context) => const HomePage(),
    profile: (context) => ProfilePage(),
    paymentOption: (context) => const PaymentOption(),
    paymentDestination: (context) => const PaymentDestination(),
    // favoritePage: (context) => const FavoritePage(),
    activityDetailsPageRoute: (context) {
      final activity =
          ModalRoute.of(context)!.settings.arguments as GetActivityModel;
      return ActivityDetailsPage(activity: activity);
    },
    categoryCard: (context) => const CategoryCard(),
    carCardRoute: (context) {
      final car = ModalRoute.of(context)!.settings.arguments as Carmodel;
      return CarCard(car: car);
    },
  };
}
