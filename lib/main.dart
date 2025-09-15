import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto/bloc&repo/%D9%90Auth/AuthRepository.dart';
import 'package:tripto/bloc&repo/BookNow_OrderTrip/OrderTripBloc.dart';
import 'package:tripto/bloc&repo/BookNow_OrderTrip/OrderTripRepository.dart';
import 'package:tripto/bloc&repo/ContactUs/ContactUs_bloc.dart';
import 'package:tripto/bloc&repo/ContactUs/ContactUs_repository.dart';
import 'package:tripto/bloc&repo/ProfileUserDate/Edit/EditBloc.dart';
import 'package:tripto/bloc&repo/ProfileUserDate/logout/LogoutBloc.dart';
import 'package:tripto/bloc&repo/%D9%90Auth/AuthBloc.dart';
import 'package:tripto/bloc&repo/ProfileUserDate/ProfileRepository.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/SearchOnTripBySUB/SearchOnTripBySubDestination_Bloc.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/SearchOnTripBySUB/SearchOnTripBySubDestination_repository.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byCategory/SearchOnTripByCategory_Bloc.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byCategory/SearchOnTripByCategory_repository.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byDate/SearchOnTripByDate_Bloc.dart';
import 'package:tripto/bloc&repo/SearchOnTrip/byDate/SearchOnTripByDate_repository.dart';
import 'package:tripto/bloc&repo/car/car_repository.dart';
import 'package:tripto/bloc&repo/GetTrip/GetTrip_bloc.dart';
import 'package:tripto/bloc&repo/GetTrip/GetTrip_event.dart';
import 'package:tripto/bloc&repo/GetTrip/GetTrip_repository.dart';
import 'package:tripto/core/routes/app_routes.dart';
import 'package:tripto/presentation/pages/NavBar/homePage/VedioPlayerPage.dart';
import 'package:tripto/wrappers/internet_wrapper.dart';
import 'l10n/app_localizations.dart';
import 'package:showcaseview/showcaseview.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
final GlobalKey<VideoPlayerScreenState> videoPlayerScreenKey =
    GlobalKey<VideoPlayerScreenState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const TripToApp());
}

class TripToApp extends StatefulWidget {
  const TripToApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    final _TripToAppState? state =
        context.findAncestorStateOfType<_TripToAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<TripToApp> createState() => _TripToAppState();
}

class _TripToAppState extends State<TripToApp> {
  Locale _locale = const Locale('ar');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(create: (_) => AuthRepository()),
        RepositoryProvider<TripRepository>(create: (_) => TripRepository()),
        RepositoryProvider<UserRepository>(create: (_) => UserRepository()),
        RepositoryProvider<CarRepository>(create: (_) => CarRepository()),
        RepositoryProvider<ContactusRepository>(create: (_) => ContactusRepository()),
        RepositoryProvider<SearchTripByDateRepository>(create: (_) => SearchTripByDateRepository()),
        RepositoryProvider<SearchTripByCategoryRepository>(create: (_) => SearchTripByCategoryRepository()),
        RepositoryProvider<SearchTripBySubDestinationRepository>(create: (_) => SearchTripBySubDestinationRepository()),
        RepositoryProvider<OrderTripRepository>(create: (_) => OrderTripRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: RepositoryProvider.of<AuthRepository>(context),
            ),
          ),
          BlocProvider<TripBloc>(
            create: (context) => TripBloc(
              RepositoryProvider.of<TripRepository>(context),
            )..add(FetchTrips()),
          ),
          BlocProvider<UpdateUserBloc>(
            create: (context) => UpdateUserBloc(
              userRepository: RepositoryProvider.of<UserRepository>(context),
            ),
          ),
          BlocProvider<LogoutBloc>(
            create: (context) => LogoutBloc(
              repository: RepositoryProvider.of<AuthRepository>(context),
            ),
          ),
          BlocProvider<ContactusBloc>(
            create: (context) => ContactusBloc(
              contactusRepository: RepositoryProvider.of<ContactusRepository>(context),
            ),
          ),
          BlocProvider<SearchTripByDateBloc>(
            create: (context) => SearchTripByDateBloc(
              repository: RepositoryProvider.of<SearchTripByDateRepository>(context),
            ),
          ),
          BlocProvider<OrderTripBloc>(
            create: (context) => OrderTripBloc(
              RepositoryProvider.of<OrderTripRepository>(context),
            ),
          ),
          BlocProvider<SearchTripByCategoryBloc>(
            create: (context) => SearchTripByCategoryBloc(
              repository: RepositoryProvider.of<SearchTripByCategoryRepository>(context),
            ),
          ),
          BlocProvider<SearchTripBySubDestinationBloc>(
            create: (context) => SearchTripBySubDestinationBloc(
              repository: RepositoryProvider.of<SearchTripBySubDestinationRepository>(context),
            ),
          ),
        ],
        child: ShowCaseWidget(
          builder: (context) => MaterialApp(
            navigatorObservers: [routeObserver],
            locale: _locale,
            supportedLocales: const [Locale('en'), Locale('ar')],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: ThemeData(
              textTheme: GoogleFonts.loraTextTheme(),
              textSelectionTheme: const TextSelectionThemeData(
                cursorColor: Colors.black,
                selectionColor: Colors.grey,
                selectionHandleColor: Colors.grey,
              ),
            ),
            title: 'TripTo',
            debugShowCheckedModeBanner: false,
            routes: AppRoutes.routes,
            initialRoute: AppRoutes.splash,
            builder: (context, child) {
              return Wrapper(child: child ?? const SizedBox());
            },
          ),
        ),
      ),
    );
  }
}
