import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripto/core/constants/CustomButton.dart';
import 'package:tripto/core/routes/app_routes.dart';
import 'package:tripto/main.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final currentLocale = Localizations.localeOf(context).languageCode;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          width: width,
          height: height,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.08),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // الصورة
                Flexible(
                  flex: 12,
                  child: Image.asset(
                    'assets/images/welcome.png',
                    width: width * 0.8,
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(height: height * 0.12),

                // زر Let's Go
                Flexible(
                  flex: 5,
                  child: SizedBox(
                    width: double.infinity,
                    height: height * 0.06,
                    child: CustomButton(
                      text: currentLocale == "ar"
                          ? "إبدا رحلتك 🚀"
                          : "Let's Go 🚀",
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('isFirstTime', false);
                        Navigator.pushReplacementNamed(context, AppRoutes.app);
                      },
                    ),
                  ),
                ),

                SizedBox(height: height * 0.01),

                // اختيار اللغة
                Flexible(
                  flex: 3,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final newLocale = currentLocale == 'en'
                                ? const Locale('ar')
                                : const Locale('en');
                            TripToApp.setLocale(context, newLocale);

                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setString(
                                'savedLocale', newLocale.languageCode);
                          },
                          child: Icon(
                            Icons.language,
                            color: const Color(0xFF002E70),
                            size: width * 0.12,
                          ),
                        ),
                        SizedBox(height: height * 0.015),
                        GestureDetector(
                          onTap: () async {
                            final newLocale = currentLocale == 'en'
                                ? const Locale('ar')
                                : const Locale('en');
                            TripToApp.setLocale(context, newLocale);

                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setString(
                                'savedLocale', newLocale.languageCode);
                          },
                          child: Text(
                            currentLocale == "en"
                                ? "تغيير اللغة إلى العربية"
                                : "Change language to English",
                            style: TextStyle(
                              fontSize: width * 0.035,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
