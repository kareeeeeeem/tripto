import 'package:flutter/material.dart';
import 'package:tripto/l10n/app_localizations.dart';
import 'package:tripto/main.dart';
import 'package:tripto/presentation/pages/NavBar/SideMenu/Contact-Us.dart';
import 'package:tripto/presentation/pages/NavBar/SideMenu/Privacypolicy.dart';
import 'package:tripto/presentation/pages/NavBar/SideMenu/TermsandCondations.dart';
import 'package:tripto/presentation/app/app.dart';
import 'package:tripto/presentation/pages/NavBar/SideMenu/About-us.dart';
import 'package:tripto/presentation/pages/NavBar/SideMenu/Cancellattion.dart';
import 'package:tripto/presentation/pages/NavBar/SideMenu/Favorite_page.dart';
// import 'package:tripto/presentation/pages/SideMenu';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.sidemenu,
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
              MaterialPageRoute(builder: (context) => const App()),
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
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.02, // left 2% من العرض
          MediaQuery.of(context).size.height * 0.1, // top 10% من الارتفاع
          MediaQuery.of(context).size.width * 0.02, // right 2% من العرض
          0, // bottom
        ),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 243, 241, 241),

            borderRadius: BorderRadius.circular(16), // لو عايز زوايا مدوّرة
          ),
          height: MediaQuery.of(context).size.height * 0.6,
          // width: MediaQuery.of(context).size.width * 0.9,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ListTile(
                leading: const Icon(
                  Icons.favorite,
                  color: Color(0xFF002E70),
                  size: 30,
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.favourite,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FavoritePage(),
                          ),
                          (route) => false,
                        );
                      },
                      icon: Icon(
                        Localizations.localeOf(context).languageCode == 'ar'
                            ? Icons
                                .keyboard_arrow_left_outlined // في العربي: سهم لليمين
                            : Icons
                                .keyboard_arrow_right_outlined, // في الإنجليزي: سهم لليسار
                        size: 35,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  // Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoritePage()),
                  );
                },
              ),
              const Divider(
                thickness: 0.3, // سُمك الخط
                color: Colors.grey,
              ),
              ListTile(
                leading: const Icon(
                  Icons.info,
                  color: Color(0xFF002E70),
                  size: 30,
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.aboutus,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AboutUs(),
                          ),
                          (route) => false,
                        );
                      },
                      icon: Icon(
                        Localizations.localeOf(context).languageCode == 'ar'
                            ? Icons
                                .keyboard_arrow_left_outlined // في العربي: سهم لليمين
                            : Icons
                                .keyboard_arrow_right_outlined, // في الإنجليزي: سهم لليسار
                        size: 35,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  // Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutUs()),
                  );
                },
              ),
              const Divider(
                thickness: 0.3, // سُمك الخط
                color: Colors.grey,
              ),
              // الجديد
              ListTile(
                leading: const Icon(
                  Icons.autorenew,
                  color: Color(0xFF002E70),
                  size: 30,
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.cancellation1,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Cancellattion(),
                          ),
                          (route) => false,
                        );
                      },
                      icon: Icon(
                        Localizations.localeOf(context).languageCode == 'ar'
                            ? Icons
                                .keyboard_arrow_left_outlined // في العربي: سهم لليمين
                            : Icons
                                .keyboard_arrow_right_outlined, // في الإنجليزي: سهم لليسار
                        size: 35,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  // Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Cancellattion()),
                  );
                },
              ),
              const Divider(
                thickness: 0.3, // سُمك الخط
                color: Colors.grey,
              ),
              ListTile(
                leading: const Icon(
                  Icons.language,
                  color: Color(0xFF002E70),
                  size: 30,
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              final currentLocale =
                                  Localizations.localeOf(context).languageCode;
                              final newLocale =
                                  currentLocale == 'ar'
                                      ? const Locale('en')
                                      : const Locale('ar');
                              TripToApp.setLocale(context, newLocale);
                              setState(() {});
                            },
                            child: Text(
                              Localizations.localeOf(context).languageCode ==
                                      "en"
                                  ? " تغيير اللغة "
                                  : "Change Language",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(
                              right:
                                  Localizations.localeOf(
                                            context,
                                          ).languageCode ==
                                          'ar'
                                      ? 30.0
                                      : 0.0,
                              left:
                                  Localizations.localeOf(
                                            context,
                                          ).languageCode ==
                                          'en'
                                      ? 80.0
                                      : 0.0,
                            ),

                            child: TextButton(
                              onPressed: () {
                                final currentLocale =
                                    Localizations.localeOf(
                                      context,
                                    ).languageCode;
                                final newLocale =
                                    currentLocale == 'ar'
                                        ? const Locale('en')
                                        : const Locale('ar');
                                TripToApp.setLocale(context, newLocale);
                                setState(() {});
                              },
                              child: Text(
                                Localizations.localeOf(context).languageCode ==
                                        "en"
                                    ? "اللغة العربيه"
                                    : "English",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        final currentLocale =
                            Localizations.localeOf(context).languageCode;
                        final newLocale =
                            currentLocale == 'ar'
                                ? const Locale('en')
                                : const Locale('ar');
                        TripToApp.setLocale(context, newLocale);
                        setState(() {});
                      },
                      icon: Icon(
                        Localizations.localeOf(context).languageCode == 'ar'
                            ? Icons
                                .keyboard_arrow_left_outlined // في العربي: سهم لليمين
                            : Icons
                                .keyboard_arrow_right_outlined, // في الإنجليزي: سهم لليسار
                        size: 35,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              // 28/88888888888888888888888888888888888888888888888888888
              const Divider(
                thickness: 0.3, // سُمك الخط
                color: Colors.grey,
              ),
              ListTile(
                leading: const Icon(
                  Icons.lock,
                  color: Color(0xFF002E70),
                  size: 30,
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.privacypolicy,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Privacypolicy(),
                          ),
                          (route) => false,
                        );
                      },
                      icon: Icon(
                        Localizations.localeOf(context).languageCode == 'ar'
                            ? Icons
                                .keyboard_arrow_left_outlined // في العربي: سهم لليمين
                            : Icons
                                .keyboard_arrow_right_outlined, // في الإنجليزي: سهم لليسار
                        size: 35,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  // Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Privacypolicy()),
                  );
                },
              ),

              // 8888888888888888888888888888888888888888888888888888888888888888888888888888888
              const Divider(
                thickness: 0.3, // سُمك الخط
                color: Colors.grey,
              ),
              ListTile(
                leading: const Icon(
                  Icons.book,
                  color: Color(0xFF002E70),
                  size: 30,
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.termsandcondations,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Termsandcondations(),
                          ),
                          (route) => false,
                        );
                      },
                      icon: Icon(
                        Localizations.localeOf(context).languageCode == 'ar'
                            ? Icons
                                .keyboard_arrow_left_outlined // في العربي: سهم لليمين
                            : Icons
                                .keyboard_arrow_right_outlined, // في الإنجليزي: سهم لليسار
                        size: 35,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  // Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Termsandcondations(),
                    ),
                  );
                },
              ),
              //31/8888888888888888888888888888888888888888888888888888888888888888888888888888
              const Divider(
                thickness: 0.3, // سُمك الخط
                color: Colors.grey,
              ),
              ListTile(
                leading: const Icon(
                  Icons.call,
                  color: Color(0xFF002E70),
                  size: 30,
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.contactus,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ContactUs(),
                          ),
                          (route) => false,
                        );
                      },
                      icon: Icon(
                        Localizations.localeOf(context).languageCode == 'ar'
                            ? Icons
                                .keyboard_arrow_left_outlined // في العربي: سهم لليمين
                            : Icons
                                .keyboard_arrow_right_outlined, // في الإنجليزي: سهم لليسار
                        size: 35,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  // Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ContactUs()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
