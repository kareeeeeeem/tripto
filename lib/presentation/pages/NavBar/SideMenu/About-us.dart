import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tripto/l10n/app_localizations.dart';
import 'package:tripto/presentation/pages/NavBar/SideMenu/SideMenu.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  // تعريف قيمة الحشو الأفقي القياسية التي نريد استخدامها
  static const double horizontalPaddingValue = 16.0;

  Widget _buildPaddedText(BuildContext context, TextSpan textSpan) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: horizontalPaddingValue,
        vertical: 4.0,
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.start, // لضمان البدء من اليسار/اليمين
        children: [
          Expanded(
            child: RichText(
              textAlign:
                  Localizations.localeOf(context).languageCode == 'ar'
                      ? TextAlign.right
                      : TextAlign.left,
              text: textSpan,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // استخدام الـ Localizations.localeOf(context).languageCode لتحديد اتجاه السهم (لغة المستخدم)
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.aboutus,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),

        leading: IconButton(
          onPressed: () {
            // Navigator.popAndPush to prevent rebuild loop if SideMenu is same as current route stack base
            // Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(builder: (context) => const SideMenu()),
            //   (route) => false,
            // );
            Navigator.pop(context);
          },
          icon: Icon(
            isArabic
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
        child: Column(
          // CrossAxisAlignment.start ensures elements start from the correct side (Start/Left/Right)
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE
            Center(
              child: ClipRRect(
                child: Image.asset(
                  "assets/images/aboutus.png",
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.20,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),

            // --- النص الأول ---
            _buildPaddedText(
              context,
              TextSpan(
                style: const TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  TextSpan(text: AppLocalizations.of(context)!.aboutus1),
                  TextSpan(
                    text: AppLocalizations.of(context)!.aboutus2,
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

            // --- الفاصل بين اول قطعه و تاني قطعه ---
            _buildPaddedText(
              context,
              TextSpan(
                style: const TextStyle(color: Colors.black, fontSize: 16),
                children: [
                  TextSpan(text: AppLocalizations.of(context)!.abutus6),
                  TextSpan(
                    text: AppLocalizations.of(context)!.aboutus7,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),

            // --- النص الثامن (العنوان) ---
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalPaddingValue,
                vertical: 4.0,
              ),
              child: Text(
                AppLocalizations.of(context)!.aboutus8,
                style: const TextStyle(fontSize: 16),
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),

            // --- النص التاسع (نقطة) - تم تعديل الـ Padding ---
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalPaddingValue,
                vertical: 4.0,
              ),
              child: Text(
                AppLocalizations.of(context)!.aboutus9,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
              ),
            ),

            // --- النص العاشر (نقطة) - تم تعديل الـ Padding ---
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalPaddingValue,
                vertical: 4.0,
              ),
              child: Text(
                AppLocalizations.of(context)!.aboutus10,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
              ),
            ),

            // --- النص الحادي عشر والثاني عشر (شرح) ---
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalPaddingValue,
                vertical: 4.0,
              ),
              child: RichText(
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
                text: TextSpan(
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  children: [
                    TextSpan(
                      text: AppLocalizations.of(context)!.aboutus11,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: AppLocalizations.of(context)!.aboutus12),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),

            // --- النص الثالث عشر ---
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalPaddingValue,
                vertical: 4.0,
              ),
              child: Text(
                AppLocalizations.of(context)!.aboutus13,
                style: const TextStyle(fontSize: 16),
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),

            // --- النص الرابع عشر ---
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalPaddingValue,
                vertical: 4.0,
              ),
              child: Text(
                AppLocalizations.of(context)!.aboutus14,
                style: const TextStyle(fontSize: 16),
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
              ),
            ),

            // LOGO
            Center(
              child: Container(
                width: 400,
                height: 100,
                decoration: const BoxDecoration(
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
}
