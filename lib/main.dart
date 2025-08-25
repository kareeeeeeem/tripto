import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto/bloc/ProfileUserDate/Edit/EditBloc.dart';
import 'package:tripto/bloc/ProfileUserDate/logout/LogoutBloc.dart';
import 'package:tripto/bloc/ProfileUserDate/logout/LogoutRepository.dart';
import 'package:tripto/bloc/ِAuth/AuthBloc.dart';
import 'package:tripto/bloc/GetTrip/GetTrip_bloc.dart';
import 'package:tripto/data/repositories/AuthRepository.dart';
import 'package:tripto/data/repositories/ProfileRepository.dart';
import 'package:tripto/data/repositories/TripsRepository.dart';
import 'package:tripto/core/routes/app_routes.dart';
import 'l10n/app_localizations.dart';
import 'package:tripto/bloc/GetTrip/GetTrip_event.dart';

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
  Locale _locale = const Locale('en');

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
        RepositoryProvider<TripsRepository>(create: (_) => TripsRepository()),
        RepositoryProvider<CarRepository>(create: (_) => CarRepository()),
        RepositoryProvider<UserRepository>(create: (_) => UserRepository()),
        RepositoryProvider<AccountRepository>(
          create: (_) => AccountRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create:
                (context) => AuthBloc(
                  authRepository: RepositoryProvider.of<AuthRepository>(
                    context,
                  ),
                ),
          ),
          BlocProvider<GetTripBloc>(
            create:
                (context) =>
                    GetTripBloc(RepositoryProvider.of<TripsRepository>(context))
                      ..add(FetchTrips()),
          ),
          BlocProvider<TripBloc>(create: (context) => TripBloc()),
          BlocProvider(
            create:
                (context) => UpdateUserBloc(
                  userRepository: RepositoryProvider.of<UserRepository>(
                    context,
                  ),
                ),
          ),
          BlocProvider<LogoutBloc>(
            create:
                (context) => LogoutBloc(
                  repository: RepositoryProvider.of<AccountRepository>(context),
                ),
          ),
        ],
        child: MaterialApp(
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
          initialRoute: '/',
          routes: AppRoutes.routes,
        ),
      ),
    );
  }
}
