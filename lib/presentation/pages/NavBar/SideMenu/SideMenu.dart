import 'package:flutter/material.dart';
import 'package:tripto/l10n/app_localizations.dart';
import 'package:tripto/main.dart';
import 'package:tripto/presentation/pages/NavBar/SideMenu/Contact-Us.dart';
import 'package:tripto/presentation/pages/NavBar/SideMenu/MyTrips/MyTripsPage.dart';
import 'package:tripto/presentation/pages/NavBar/SideMenu/Privacypolicy.dart';
import 'package:tripto/presentation/pages/NavBar/SideMenu/Report.dart';
import 'package:tripto/presentation/pages/NavBar/SideMenu/TermsandCondations.dart';
import 'package:tripto/presentation/app/app.dart';
import 'package:tripto/presentation/pages/NavBar/SideMenu/About-us.dart';
import 'package:tripto/presentation/pages/NavBar/SideMenu/Cancellattion.dart';
import 'package:tripto/presentation/pages/NavBar/SideMenu/Favorite_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tripto/presentation/pages/NavBar/profile_logiin_sign_verfi/SignupOrLogin.dart';

final storage = FlutterSecureStorage();

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        foregroundColor: theme.appBarTheme.foregroundColor,
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.sidemenu,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
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
                ? Icons.keyboard_arrow_right_outlined
                : Icons.keyboard_arrow_left_outlined,
            size: 35,
            color: theme.iconTheme.color,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.02,
          MediaQuery.of(context).size.height * 0.1,
          MediaQuery.of(context).size.width * 0.02,
          0,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(16),
          ),
          height: MediaQuery.of(context).size.height * 0.6,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              _buildMenuItem(
                context,
                icon: Icons.trip_origin,
                label: AppLocalizations.of(context)!.mytrips,
                onTap: () async {
                  final storedUserId = await storage.read(key: 'userId');
                  if (storedUserId != null && storedUserId.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyTripsPage()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            AppLocalizations.of(context)!.pleaseLoginFirst),
                        backgroundColor: Color(0xFF002E70),
                        duration: const Duration(seconds: 5),
                      ),
                    );
                    Future.delayed(const Duration(seconds: 1), () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Signuporlogin()),
                      );
                    });
                  }
                },
              ),
              _divider(),

              _buildMenuItem(
                context,
                icon: Icons.favorite,
                label: AppLocalizations.of(context)!.favourite,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FavoritePage()),
                ),
              ),
              _divider(),

              _buildMenuItem(
                context,
                icon: Icons.info,
                label: AppLocalizations.of(context)!.aboutus,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutUs()),
                ),
              ),
              _divider(),

              _buildMenuItem(
                context,
                icon: Icons.autorenew,
                label: AppLocalizations.of(context)!.cancellation1,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Cancellattion()),
                ),
              ),
              _divider(),

              // 🌐 تغيير اللغة
              ListTile(
                leading: const Icon(Icons.language, color: Color(0xFF002E70), size: 30),
                 title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Localizations.localeOf(context).languageCode == "en"
                          ? "Change Language"
                          : "تغيير اللغة",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            final currentLocale =
                                Localizations.localeOf(context).languageCode;
                            final newLocale = currentLocale == 'ar'
                                ? const Locale('en')
                                : const Locale('ar');
                            TripToApp.setLocale(context, newLocale);
                            setState(() {});
                          },
                          child: Text(
                            Localizations.localeOf(context).languageCode == "en"
                                ? "العربية"
                                : "English",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: theme.textTheme.bodyLarge?.color,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            final currentLocale =
                                Localizations.localeOf(context).languageCode;
                            final newLocale = currentLocale == 'ar'
                                ? const Locale('en')
                                : const Locale('ar');
                            TripToApp.setLocale(context, newLocale);
                            setState(() {});
                          },
                          icon: Icon(
                            Localizations.localeOf(context).languageCode == 'ar'
                                ? Icons.keyboard_arrow_left_outlined
                                : Icons.keyboard_arrow_right_outlined,
                            size: 35,
                            color: theme.iconTheme.color,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _divider(),

              // // 🌙 تغيير الثيم
              // ListTile(
              //  leading: const Icon(Icons.brightness_4, color: Color(0xFF002E70), size: 30),
              //   title: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         AppLocalizations.of(context)!.themedate,
              //         style: TextStyle(
              //           fontSize: 16,
              //           fontWeight: FontWeight.bold,
              //           color: theme.textTheme.bodyLarge?.color,
              //         ),
              //       ),
              //       IconButton(
              //         onPressed: () {
              //           TripToApp.toggleTheme(context);
              //         },
              //         icon: Icon(
              //           Theme.of(context).brightness == Brightness.dark
              //               ? Icons.dark_mode
              //               : Icons.light_mode,
              //           size: 35,
              //           color: Theme.of(context).brightness == Brightness.dark
              //               ? Colors.yellow
              //               : Colors.black,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // _divider(),

              _buildMenuItem(
                context,
                icon: Icons.lock,
                label: AppLocalizations.of(context)!.privacypolicy,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Privacypolicy()),
                ),
              ),
              _divider(),

              _buildMenuItem(
                context,
                icon: Icons.book,
                label: AppLocalizations.of(context)!.termsandcondations,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Termsandcondations()),
                ),
              ),
              _divider(),

              _buildMenuItem(
                context,
                icon: Icons.call,
                label: AppLocalizations.of(context)!.contactus,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ContactUs()),
                ),
              ),
              _divider(),

              _buildMenuItem(
                context,
                icon: Icons.description,
                label: AppLocalizations.of(context)!.report,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Report()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 عنصر قائمة موحد
  Widget _buildMenuItem(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    final theme = Theme.of(context);
    return ListTile(
leading: Icon(icon, color: const Color(0xFF002E70), size: 30),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
          Icon(
            Localizations.localeOf(context).languageCode == 'ar'
                ? Icons.keyboard_arrow_left_outlined
                : Icons.keyboard_arrow_right_outlined,
            size: 35,
            color: theme.iconTheme.color,
          ),
        ],
      ),
      onTap: onTap,
    );
  }

  // 🔹 Divider موحد
  Widget _divider() {
    return const Divider(thickness: 0.3);
  }
}