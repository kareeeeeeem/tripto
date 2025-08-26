import 'package:flutter/material.dart';
import 'package:tripto/l10n/app_localizations.dart';
import 'package:tripto/main.dart';
import 'package:tripto/presentation/About-us.dart';
import 'package:tripto/presentation/Cancellattion.dart';
import 'package:tripto/presentation/app/app.dart';
import 'package:tripto/presentation/pages/NavBar/Favorite_page.dart';
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
        actions: [
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
            icon: const Icon(
              Icons.language,
              size: 30,
              color: Color(0xFF002E70),
            ),
          ),
        ],
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
        padding: const EdgeInsets.fromLTRB(10, 60, 10, 0),
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
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.15,
              //   child: DrawerHeader(
              //     decoration: BoxDecoration(color: Color(0xFF002E70)),
              //     // child: Text(
              //     //   AppLocalizations.of(context)!.aboutus,
              //     //   style: TextStyle(color: Colors.white, fontSize: 30),
              //     // ),
              //   ),
              // ),
              // اول اختيار في ال drawer + icon
              ListTile(
                leading: const Icon(Icons.favorite, color: Color(0xFF002E70)),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.favourite,
                      style: TextStyle(
                        fontSize: 17,
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
                thickness: 0.5, // سُمك الخط
                color: Colors.grey,
              ),
              ListTile(
                leading: const Icon(Icons.group, color: Color(0xFF002E70)),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.aboutus,
                      style: TextStyle(
                        fontSize: 17,
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
                thickness: 0.5, // سُمك الخط
                color: Colors.grey,
              ),
              // الجديد
              ListTile(
                leading: const Icon(Icons.autorenew, color: Color(0xFF002E70)),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.cancellation1,
                      style: TextStyle(
                        fontSize: 17,
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
            ],
          ),
          // الجديد

          // Column(
          //   // crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     GestureDetector(
          //       onTap: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(builder: (context) => const AboutUs()),
          //         );
          //       },
          //       child: Row(
          //         children: [
          //           IconButton(onPressed: () {}, icon: Icon(Icons.group, size: 30)),

          //           Text(
          //             AppLocalizations.of(context)!.aboutus,
          //             style: TextStyle(
          //               fontSize: 24,
          //               fontWeight: FontWeight.bold,
          //               color: Colors.black,
          //               // decoration: TextDecoration.underline,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
