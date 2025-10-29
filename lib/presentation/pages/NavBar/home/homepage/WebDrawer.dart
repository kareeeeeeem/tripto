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
import 'package:tripto/presentation/pages/NavBar/home/homepage/home_page.dart' hide AppLocalizations;
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
        'title': AppLocalizations.of(context)!.hotels,
        'page': const Hotelcard(),
      },
      {
        'icon': Icons.extension,
        'title': AppLocalizations.of(context)!.activities,
        'page': const ActivityPage(),
      },
      {
        'icon': Icons.car_rental_sharp,
        'title': AppLocalizations.of(context)!.cars,
        'page': const CarCard(),
      },
      {
        'icon': Icons.person_2_outlined,
        'title': AppLocalizations.of(context)!.profile,
        'action': (BuildContext context, VoidCallback refreshUI) async {
          final token = await storage.read(
            key: 'token',
          ); // أو أي طريقة بتستخدمها
          if (token != null && token.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfilePage()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const Signuporlogin()),
            );
          }
        },
      },

      {
        'icon': Icons.trip_origin,
        'title': AppLocalizations.of(context)!.mytrips,
        'action': (BuildContext context, VoidCallback refreshUI) async {
          final token = await storage.read(key: 'token');
          if (token != null && token.isNotEmpty) {
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
        'icon': Icons.language,
        'title':
            Localizations.localeOf(context).languageCode == "en"
                ? "Language"
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
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Localizations.localeOf(context).languageCode == "en"
                          ? "العربية"
                          : "English",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      Localizations.localeOf(context).languageCode == 'ar'
                          ? Icons.keyboard_arrow_left_outlined
                          : Icons.keyboard_arrow_right_outlined,
                      size: 22,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
                 Text(
                  Localizations.localeOf(context).languageCode == "en"
                      ? "العربية"
                      : "English",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              

              // Icon(
              //   Localizations.localeOf(context).languageCode == 'ar'
              //       ? Icons.keyboard_arrow_left_outlined
              //       : Icons.keyboard_arrow_right_outlined,
              //   size: 35,
              //   color: Colors.white,
              // ),
            ],
          );
        },
      },

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
    ];

    return Drawer(
      backgroundColor: Colors.black,
      child: ScrollbarTheme(
        data: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.all(Colors.white70),
          trackColor: MaterialStateProperty.all(Colors.white10),
          radius: const Radius.circular(12),
          thickness: MaterialStateProperty.all(3.5),
          interactive: true,
        ),
        child: Scrollbar(
          thumbVisibility: true,
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
              leading: Icon(
                drawerItems[i]['icon'],
                color: Colors.white,
                size: 22,
              ),
              title: Text(
                drawerItems[i]['title'],
                style: TextStyle(
                  fontSize: 15,
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
                  leading: Icon(
                    drawerItems[i]['icon'],
                    color: Colors.white,
                    size: 22,
                  ),
                  title: Text(
                    drawerItems[i]['title'],
                    style: TextStyle(
                      fontSize: 15,
                      color:
                          selectedIndex == i
                              ? const Color(0xFF00AEEF)
                              : Colors.white,
                      fontWeight:
                          selectedIndex == i
                              ? FontWeight.bold
                              : FontWeight.normal,
                    ),
                  ),
                  trailing:
                      drawerItems[i]['trailing'] != null
                          ? drawerItems[i]['trailing']!(context)
                          : null,
                  hoverColor: Colors.white.withOpacity(0.1),
                  onTap: () async {
                    setState(() {
                      selectedIndex = i;
                    });

                    // Navigator.pop(context);

                    if (drawerItems[i]['page'] != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => drawerItems[i]['page'],
                        ),
                      );
                    } else if (drawerItems[i]['action'] != null) {
                      await drawerItems[i]['action']!(
                        context,
                        () => setState(() {}),
                      );
                    }
                  },
                ),

                if (i == 3 || i == 6)
                  const Divider(color: Colors.white30, thickness: 0.5),

                // if (i == 6)
                //   SizedBox(
                //     width: MediaQuery.of(context).size.width * 0.03,
                //   ),
                if (i == 3)
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "Developed by Eng.Amr Hassan",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        Text(
                          "© 2025 Google ",
                          style: TextStyle(color: Colors.white54, fontSize: 12),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent, // لون الخلفية
                              foregroundColor: Colors.white, // لون النص
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () async {
                              const phoneNumber = '201028476944';
                              final message = Uri.encodeComponent(
                                AppLocalizations.of(context)!.customTripMessage,
                              );
                              final url =
                                  'https://wa.me/$phoneNumber?text=$message';

                              if (await canLaunchUrl(Uri.parse(url))) {
                                await launchUrl(
                                  Uri.parse(url),
                                  mode: LaunchMode.externalApplication,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.cannotOpenWhatsapp,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              AppLocalizations.of(context)!.customtrip,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            if (i == 3 || i == 6)
              const Divider(color: Colors.white30, thickness: 0.5),

            // if (i == 6)
            //   SizedBox(
            //     width: MediaQuery.of(context).size.width * 0.03,
            //   ), // 👈 برضو هنا
            if (i == 3)
              Column(
                children: [
                  Text(
                    "Developed by Eng.Amr Hassan",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  Center(
                    child: Text(
                      "© 2025 Google ",
                      style: TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent, // لون الخلفية
                        foregroundColor: Colors.white, // لون النص
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
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
                                AppLocalizations.of(
                                  context,
                                )!.cannotOpenWhatsapp,
                              ),
                            ),
                          );
                        }
                      },
                      child: Text(AppLocalizations.of(context)!.customtrip),
                    ),
                  ),
                ],
              ),

                // const Divider(color: Colors.white30, thickness: 1),
                ],
              ],
            );
            }
          ),
          ]
        ]
          ),
        )
        )
      );
    }
    }
