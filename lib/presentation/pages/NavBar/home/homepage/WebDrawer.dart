import 'package:flutter/material.dart';
import 'package:tripto/l10n/app_localizations.dart';
import 'package:tripto/main.dart';
import 'package:tripto/presentation/pages/NavBar/ActivityPage/activities_page.dart';
import 'package:tripto/presentation/pages/NavBar/SideMenu/About-us.dart';
import 'package:tripto/presentation/pages/NavBar/SideMenu/AllCars.dart';
import 'package:tripto/presentation/pages/NavBar/SideMenu/Cancellattion.dart';
import 'package:tripto/presentation/pages/NavBar/SideMenu/Contact-Us.dart';
import 'package:tripto/presentation/pages/NavBar/SideMenu/MyTrips/MyTripsPage.dart';
import 'package:tripto/presentation/pages/NavBar/SideMenu/Privacypolicy.dart';
import 'package:tripto/presentation/pages/NavBar/SideMenu/Report.dart';
import 'package:tripto/presentation/pages/NavBar/SideMenu/SideMenu.dart';
import 'package:tripto/presentation/pages/NavBar/SideMenu/TermsandCondations.dart';
import 'package:tripto/presentation/pages/NavBar/home/homepage/home_page.dart';
import 'package:tripto/presentation/pages/NavBar/hotel/HotelCard.dart';
import 'package:tripto/presentation/pages/NavBar/profile_logiin_sign_verfi/SignupOrLogin.dart';
import 'package:tripto/presentation/pages/NavBar/profile_logiin_sign_verfi/profile_page.dart';
import 'package:url_launcher/url_launcher.dart';

bool hasToken = false;

class WebDrawer extends StatefulWidget {
  const WebDrawer({super.key});

  @override
  State<WebDrawer> createState() => _WebDrawerState();
}

class _WebDrawerState extends State<WebDrawer> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    // ✅ دي الليست اللي فيها كل العناصر (icon + title + page)
    final List<Map<String, dynamic>> drawerItems = [
      {
        'icon': Icons.home,
        'title': AppLocalizations.of(context)!.home,
        'page': const HomePage(),
      },
      {
        'icon': Icons.hotel,
        'title': AppLocalizations.of(context)!.hotel,
        'page': const Hotelcard(),
      },
      {
        'icon': Icons.extension,
        'title': AppLocalizations.of(context)!.activities,
        'page': const ActivityPage(),
      },
      {
        'icon': Icons.person_2_outlined,
        'title': AppLocalizations.of(context)!.profile,
        'page':
            hasToken ? const ProfilePage() : const Signuporlogin(), // index 2
      },

      {
        'icon': Icons.trip_origin,
        'title': AppLocalizations.of(context)!.mytrips,
        'action': () async {
          final storedUserId = await storage.read(key: 'userId');
          if (storedUserId != null && storedUserId.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyTripsPage()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AppLocalizations.of(context)!.pleaseLoginFirst),
                backgroundColor: Color(0xFF002E70),
                duration: const Duration(seconds: 5),
              ),
            );
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Signuporlogin()),
              );
            });
          }
        },
      },
      {
        'icon': Icons.car_rental_sharp,
        'title': AppLocalizations.of(context)!.cars,
        'page': const CarCard(),
      },

      {
        'icon': Icons.language,
        'title':
            Localizations.localeOf(context).languageCode == "en"
                ? "Change Language"
                : "تغيير اللغة",
        'action': (BuildContext context, VoidCallback refreshUI) {
          final currentLocale = Localizations.localeOf(context).languageCode;
          final newLocale =
              currentLocale == 'ar' ? const Locale('en') : const Locale('ar');

          TripToApp.setLocale(context, newLocale);
          refreshUI();
        },
        'trailing': (BuildContext context) {
          return Row(
            mainAxisSize: MainAxisSize.min,
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
                },
                child: Text(
                  Localizations.localeOf(context).languageCode == "en"
                      ? "العربية"
                      : "English",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Icon(
                Localizations.localeOf(context).languageCode == 'ar'
                    ? Icons.keyboard_arrow_left_outlined
                    : Icons.keyboard_arrow_right_outlined,
                size: 35,
                color: Colors.white,
              ),
            ],
          );
        },
      },

      // {
      //   'icon': Icons.extension,
      //   'title': AppLocalizations.of(context)!.activities,
      //   'page': const ActivityPage(),
      // },
      {
        'icon': Icons.call,
        'title': AppLocalizations.of(context)!.contactus,
        'page': const ContactUs(),
      },

      {
        'icon': Icons.info,
        'title': AppLocalizations.of(context)!.aboutus,
        'page': const AboutUs(),
      },

      {
        'icon': Icons.description,
        'title': AppLocalizations.of(context)!.report,
        'page': const Report(),
      },

      {
        'icon': Icons.autorenew,
        'title': AppLocalizations.of(context)!.cancellation1,
        'page': const Cancellattion(),
      },

      {
        'icon': Icons.lock,
        'title': AppLocalizations.of(context)!.privacypolicy,
        'page': const Privacypolicy(),
      },

      {
        'icon': Icons.book,
        'title': AppLocalizations.of(context)!.termsandcondations,
        'page': const Termsandcondations(),
      },

      // {
      //   'icon': Icons.extension,
      //   'title': AppLocalizations.of(context)!.activities,
      //   'page': const ActivityPage(),
      // },

      // {
      //   'icon': Icons.extension,
      //   'title': AppLocalizations.of(context)!.activities,
      //   'page': const ActivityPage(),
      // },
    ];

    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // DrawerHeader(
          //   decoration: BoxDecoration(color: Colors.black),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       // Container(
          //       //   child: const Text(
          //       //     'TripTo',
          //       //     style: TextStyle(color: Colors.white, fontSize: 24),
          //       //   ),
          //       // ),
          //       // Image(
          //       //   image: const AssetImage('assets/images/Logo.png'),
          //       //   height: 50,
          //       //   width: 70,
          //       // ),
          //     ],
          //   ),
          // ),
          for (int i = 0; i < drawerItems.length; i++) ...[
            ListTile(
              leading: Icon(drawerItems[i]['icon'], color: Colors.white),
              title: Text(
                drawerItems[i]['title'],
                style: TextStyle(
                  fontSize: 18,
                  color:
                      selectedIndex == i
                          ? const Color(0xFF00AEEF)
                          : Colors.white, // ✅ لون مميز لو العنصر متعلم
                  fontWeight:
                      selectedIndex == i ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              trailing:
                  drawerItems[i]['trailing'] != null
                      ? drawerItems[i]['trailing']!(context)
                      : null,
              onTap: () async {
                // ✅ أول حاجة نحدث العنصر المحدد
                setState(() {
                  selectedIndex = i;
                });

                // ✅ نقفل الدروار
                Navigator.pop(context);

                // ✅ لو في صفحة نروحها
                if (drawerItems[i]['page'] != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => drawerItems[i]['page'],
                    ),
                  );
                }
                // ✅ لو في أكشن (زي تغيير اللغة)
                else if (drawerItems[i]['action'] != null) {
                  await drawerItems[i]['action']!(
                    context,
                    () => setState(() {}),
                  );
                }
              },
            ),

            if (i == 3 || i == 6)
              const Divider(color: Colors.white30, thickness: 1),
            if (i == 3)
              Center(
                child: TextButton(
                  onPressed: () async {
                    const phoneNumber = '201028476944';
                    final message = Uri.encodeComponent(
                      AppLocalizations.of(context)!.customTripMessage,
                    );
                    final url = 'https://wa.me/$phoneNumber?text=$message';

                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(
                        Uri.parse(url),
                        mode: LaunchMode.externalApplication,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            AppLocalizations.of(context)!.cannotOpenWhatsapp,
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(
                    AppLocalizations.of(context)!.customtrip,
                    style: const TextStyle(
                      color: Colors.lightBlueAccent, // لون النص أبيض
                      fontWeight: FontWeight.bold, // خط غامق
                      fontSize: 18, // حجم الخط
                    ),
                  ),
                ),
              ),

            // const Divider(color: Colors.white30, thickness: 1),
          ],
        ],
      ),
    );
  }
}
