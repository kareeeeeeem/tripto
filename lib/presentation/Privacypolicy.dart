import 'package:flutter/material.dart';
import 'package:tripto/l10n/app_localizations.dart';
import 'package:tripto/presentation/pages/NavBar/listPages/SideMenu.dart';

class Privacypolicy extends StatefulWidget {
  const Privacypolicy({super.key});

  @override
  State<Privacypolicy> createState() => _PrivacypolicyState();
}

class _PrivacypolicyState extends State<Privacypolicy> {
  @override
  Widget build(BuildContext context) {
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
          AppLocalizations.of(context)!.privacypolicy1,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
              Text(
                AppLocalizations.of(context)!.introduction,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),

              Text(
                AppLocalizations.of(context)!.privacypolicy2,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),

              Text(
                AppLocalizations.of(context)!.privacypolicy3,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.03),
              Text(
                AppLocalizations.of(context)!.privacypolicy4,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy5,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy6,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy7,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy8,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy9,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy10,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy11,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy12,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy13,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.03),
              Text(
                AppLocalizations.of(context)!.privacypolicy14,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy15,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy16,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy17,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy18,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy19,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy20,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy21,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.03),
              Text(
                AppLocalizations.of(context)!.privacypolicy22,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy23,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy24,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy25,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy26,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy27,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy28,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.03),
              Text(
                AppLocalizations.of(context)!.privacypolicy29,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy30,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy31,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy32,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.03),
              Text(
                AppLocalizations.of(context)!.privacypolicy33,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy34,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy35,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy36,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy37,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy38,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.03),
              Text(
                AppLocalizations.of(context)!.privacypolicy39,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy40,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy41,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy42,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy43,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy44,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.03),
              Text(
                AppLocalizations.of(context)!.privacypolicy45,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy46,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy47,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.03),

              Text(
                AppLocalizations.of(context)!.privacypolicy48,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy49,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.03),
              Text(
                AppLocalizations.of(context)!.privacypolicy50,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy51,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.03),
              Text(
                AppLocalizations.of(context)!.privacypolicy52,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy53,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy54,
                style: const TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              Text(
                AppLocalizations.of(context)!.privacypolicy55,
                style: const TextStyle(fontSize: 16),
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
              // SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              // Text(
              //   AppLocalizations.of(context)!.privacypolicy54,
              //   style: const TextStyle(fontSize: 16),
              // ),
              // SizedBox(height: MediaQuery.of(context)!.size.height * 0.01),
              // Text(
              //   AppLocalizations.of(context)!.privacypolicy55,
              //   style: const TextStyle(fontSize: 16),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
