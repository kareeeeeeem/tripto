// ignore_for_file: prefer_const_constructors
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripto/core/routes/app_routes.dart';

import 'l10n/app_localizations.dart';

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
    return MaterialApp(
      locale: _locale, // أو Locale('ar') للتجربة
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
    );
  }
}
