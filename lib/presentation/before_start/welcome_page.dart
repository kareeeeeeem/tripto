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
  bool _isSaving = false;

  Future<void> _saveAndNavigate() async {
    setState(() => _isSaving = true);

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isFirstTime', false);

      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.app);
      }
    } catch (e) {
      debugPrint("⚠️ Error saving preferences: $e");
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _toggleLanguage() async {
    final currentLocale = Localizations.localeOf(context).languageCode;
    final newLocale =
        currentLocale == 'en' ? const Locale('ar') : const Locale('en');

    TripToApp.setLocale(context, newLocale);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('savedLocale', newLocale.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final currentLocale = Localizations.localeOf(context).languageCode;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.08),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 600, 
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double imageWidth;
                  double buttonHeight;
                  double iconSize;
                  double textFontSize;
                  double verticalSpacing;

                  if (constraints.maxWidth < 600) {
                    // موبايل
                    imageWidth = constraints.maxWidth * 0.8;
                    buttonHeight = screenSize.height * 0.06;
                    iconSize = constraints.maxWidth * 0.12;
                    textFontSize = constraints.maxWidth * 0.035;
                    verticalSpacing = screenSize.height * 0.08;
                  } else if (constraints.maxWidth < 1024) {
                    // تاب
                    imageWidth = constraints.maxWidth * 0.6;
                    buttonHeight = screenSize.height * 0.06;
                    iconSize = constraints.maxWidth * 0.1;
                    textFontSize = constraints.maxWidth * 0.03;
                    verticalSpacing = screenSize.height * 0.07;
                  } else {
                    // لابتوب أو ويب كبير
                    imageWidth = constraints.maxWidth * 0.5;
                    buttonHeight = screenSize.height * 0.06;
                    iconSize = constraints.maxWidth * 0.08;
                    textFontSize = constraints.maxWidth * 0.025;
                    verticalSpacing = screenSize.height * 0.06;
                  }

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 🖼️ الصورة
                      Image.asset(
                        'assets/images/welcome.png',
                        width: imageWidth,
                        fit: BoxFit.contain,
                      ),

                      SizedBox(height: verticalSpacing),

                      // 🚀 الزر
                      SizedBox(
                        width: double.infinity,
                        height: buttonHeight,
                        child: _isSaving
                            ? const Center(child: CircularProgressIndicator())
                            : CustomButton(
                                text: currentLocale == "ar"
                                    ? "إبدا رحلتك 🚀"
                                    : "Let's Go 🚀",
                                onPressed: _saveAndNavigate,
                              ),
                      ),

                      SizedBox(height: verticalSpacing * 0.25),

                      // 🌍 اختيار اللغة
                      GestureDetector(
                        onTap: _toggleLanguage,
                        child: Column(
                          children: [
                            Icon(
                              Icons.language,
                              color: const Color(0xFF002E70),
                              size: iconSize,
                            ),
                            SizedBox(height: verticalSpacing * 0.02),
                            Text(
                              currentLocale == "en"
                                  ? "تغيير اللغة إلى العربية"
                                  : "Change language to English",
                              style: TextStyle(
                                fontSize: textFontSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
