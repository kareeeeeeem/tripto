import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tripto/core/routes/app_routes.dart';
import 'package:tripto/l10n/app_localizations.dart'; // تأكد أن المسار صحيح حسب مشروعك

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // ← هنا تحدد اللغة الافتراضية
      locale: const Locale('en'), // غيّر لـ 'ar' لو عايز التطبيق يبدأ بالعربي
      // ← اللغات المدعومة
      supportedLocales: const [Locale('en'), Locale('ar')],

      // ← الديليجات الخاصة بالترجمة
      localizationsDelegates: const [
        AppLocalizations.delegate, // ← دي لازم تكون موجودة
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      title: 'Tripto',

      // ← لو عندك Theme خاص
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Cairo', // ← حط اسم الخط اللي ضايفه في pubspec.yaml
      ),

      initialRoute: '/', // أو حط اسم أول Route عندك هنا
      routes: AppRoutes.routes,
    );
  }
}
