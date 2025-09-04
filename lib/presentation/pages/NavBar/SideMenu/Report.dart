import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripto/l10n/app_localizations.dart';
import 'package:tripto/presentation/pages/NavBar/SideMenu/SideMenu.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  final TextEditingController reportController = TextEditingController();

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
          AppLocalizations.of(context)!.report,
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
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05, // 5% يمين/شمال
          // vertical: MediaQuery.of(context).size.height * 0.2, // 2% فوق/تحت
        ),

        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.report, color: const Color(0xFF002E70), size: 12),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02),

                buildLabel(AppLocalizations.of(context)!.report),
              ],
            ),

            TextFormField(
              controller: reportController,
              keyboardType: TextInputType.multiline,
              maxLines: 100, // هنا حددت 6 أسطر
              minLines: 6, // أقل حاجة 3 أسطر
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.report,
                labelStyle: TextStyle(color: Color(0xFF002E70)),
                // fillColor: const Color(0xFFD9D9D9).withOpacity(0.2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.black45, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFF002E70),
                    width: 2,
                  ),
                ),
                // prefixIcon: Icon(Icons.message),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.28),

            SizedBox(
              width: MediaQuery.of(context).size.width * 0.878,
              height: MediaQuery.of(context).size.height * 0.05875,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF002E70),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  AppLocalizations.of(context)!.sendreport,

                  style: GoogleFonts.markaziText(
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.07),

            // //////////////////////////////////////////////////////////////////////////////////////
            Padding(
              padding: EdgeInsets.all(
                MediaQuery.of(context).size.width * 0.2, // 10% من عرض الشاشة
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
    );
  }

  Widget buildLabel(String text) => Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 6),
      child: Text(
        text,
        style: GoogleFonts.markaziText(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.left,
      ),
    ),
  );
}
