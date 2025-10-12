import 'package:flutter/material.dart';
import 'package:tripto/l10n/app_localizations.dart';
import 'package:tripto/presentation/pages/NavBar/SideMenu/SideMenu.dart';

class Termsandcondations extends StatefulWidget {
  const Termsandcondations({super.key});

  @override
  State<Termsandcondations> createState() => _TermsandcondationsState();
}

class _TermsandcondationsState extends State<Termsandcondations> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        // elevation: 0,
        // scrolledUnderElevation: 0,
        scrolledUnderElevation: 0,

        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.termsandcondations1,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                child: Image.asset(
                  "assets/images/terms.png",
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.20,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.introduction,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              Text(
                AppLocalizations.of(context)!.termsandcondations2,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Text(
                AppLocalizations.of(context)!.termsandcondations3,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              Text(
                AppLocalizations.of(context)!.termsandcondations4,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              Text(
                AppLocalizations.of(context)!.termsandcondations5,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              Text(
                AppLocalizations.of(context)!.termsandcondations6,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              Text(
                AppLocalizations.of(context)!.termsandcondations7,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Text(
                AppLocalizations.of(context)!.termsandcondations8,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              Text(
                AppLocalizations.of(context)!.termsandcondations9,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              Text(
                AppLocalizations.of(context)!.termsandcondations10,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              Text(
                AppLocalizations.of(context)!.termsandcondations11,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Text(
                AppLocalizations.of(context)!.termsandcondations12,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              Text(
                AppLocalizations.of(context)!.termsandcondations13,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              Text(
                AppLocalizations.of(context)!.termsandcondations14,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              Text(
                AppLocalizations.of(context)!.termsandcondations15,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              Text(
                AppLocalizations.of(context)!.termsandcondations16,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Text(
                AppLocalizations.of(context)!.termsandcondations17,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              Text(
                AppLocalizations.of(context)!.termsandcondations18,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              Text(
                AppLocalizations.of(context)!.termsandcondations19,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              Text(
                AppLocalizations.of(context)!.termsandcondations20,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Text(
                AppLocalizations.of(context)!.termsandcondations21,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              Text(
                AppLocalizations.of(context)!.termsandcondations22,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Text(
                AppLocalizations.of(context)!.termsandcondations23,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              Text(
                AppLocalizations.of(context)!.termsandcondations24,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              Text(
                AppLocalizations.of(context)!.termsandcondations25,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Text(
                AppLocalizations.of(context)!.termsandcondations26,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              Text(
                AppLocalizations.of(context)!.termsandcondations27,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              Text(
                AppLocalizations.of(context)!.termsandcondations28,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Text(
                AppLocalizations.of(context)!.termsandcondations29,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              Text(
                AppLocalizations.of(context)!.termsandcondations30,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              Text(
                AppLocalizations.of(context)!.termsandcondations31,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Text(
                AppLocalizations.of(context)!.termsandcondations32,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              Text(
                AppLocalizations.of(context)!.termsandcondations33,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Text(
                AppLocalizations.of(context)!.termsandcondations34,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              Text(
                AppLocalizations.of(context)!.termsandcondations35,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Text(
                AppLocalizations.of(context)!.termsandcondations36,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              Text(
                AppLocalizations.of(context)!.termsandcondations37,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Text(
                AppLocalizations.of(context)!.termsandcondations38,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              Text(
                AppLocalizations.of(context)!.termsandcondations39,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              Text(
                AppLocalizations.of(context)!.termsandcondations40,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              Text(
                AppLocalizations.of(context)!.termsandcondations41,
                style: const TextStyle(fontSize: 16),
              ),
              Padding(
                padding: EdgeInsets.all(
                  MediaQuery.of(context).size.width * 0.06, // 10% من عرض الشاشة
                ),
                child: Container(
                  width: 400,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/Logo.png"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
