import 'package:flutter/material.dart';
import 'package:tripto/l10n/app_localizations.dart';
import 'package:tripto/main.dart';
import 'package:tripto/presentation/pages/SideMenu.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        // elevation: 0,
        // scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.aboutus,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       final currentLocale =
        //           Localizations.localeOf(context).languageCode;
        //       final newLocale =
        //           currentLocale == 'ar'
        //               ? const Locale('en')
        //               : const Locale('ar');
        //       TripToApp.setLocale(context, newLocale);
        //       setState(() {});
        //     },
        //     icon: const Icon(
        //       Icons.language,
        //       size: 30,
        //       color: Color(0xFF002E70),
        //     ),
        //   ),
        // ],
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const SideMenu()),
              (route) => false,
            );
          },
          icon: Icon(
            Localizations.localeOf(context).languageCode == 'ar'
                ? Icons
                    .keyboard_arrow_right_outlined // في العربي: سهم لليمين
                : Icons
                    .keyboard_arrow_left_outlined, // في الإنجليزي: سهم لليسار
            size: 35,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ), // ستايل أساسي
                children: [
                  TextSpan(text: AppLocalizations.of(context)!.aboutus1),
                  TextSpan(
                    text:
                        AppLocalizations.of(
                          context,
                        )!.aboutus2, // الجزء اللي عايزه Bold
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: AppLocalizations.of(context)!.aboutus3),
                  TextSpan(
                    text: AppLocalizations.of(context)!.aboutus4,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: AppLocalizations.of(context)!.aboutus5),
                ],
              ),
            ),
          ),
          // الفاصل بين اول قطعه و تاني قطعه
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 16),
                children: [
                  TextSpan(text: AppLocalizations.of(context)!.abutus6),
                  TextSpan(
                    text: AppLocalizations.of(context)!.aboutus7,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.aboutus8,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),

          Padding(
            padding: EdgeInsets.only(
              left:
                  Localizations.localeOf(context).languageCode == 'en'
                      ? MediaQuery.of(context).size.width *
                          0.1 // 10% من عرض الشاشة
                      : 0,
              right:
                  Localizations.localeOf(context).languageCode == 'ar'
                      ? MediaQuery.of(context).size.width *
                          0.1 // 10% من عرض الشاشة
                      : 0,
            ),
            child: Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.aboutus9,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left:
                  Localizations.localeOf(context).languageCode == 'en'
                      ? MediaQuery.of(context).size.width *
                          0.1 // 10% من عرض الشاشة
                      : 0,
              right:
                  Localizations.localeOf(context).languageCode == 'ar'
                      ? MediaQuery.of(context).size.width *
                          0.1 // 10% من عرض الشاشة
                      : 0,
            ),
            child: Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.aboutus10,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left:
                  Localizations.localeOf(context).languageCode == 'en'
                      ? MediaQuery.of(context).size.width *
                          0.1 // 10% من عرض الشاشة
                      : 0,
              right:
                  Localizations.localeOf(context).languageCode == 'ar'
                      ? MediaQuery.of(context).size.width *
                          0.1 // 10% من عرض الشاشة
                      : 0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ), // ستايل أساسي
                      children: [
                        TextSpan(
                          text: AppLocalizations.of(context)!.aboutus11,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: AppLocalizations.of(context)!.aboutus12),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppLocalizations.of(context)!.aboutus13,
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppLocalizations.of(context)!.aboutus14,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Container(
            width: 400,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/Logo.png"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
