import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripto/l10n/app_localizations.dart';
import 'package:tripto/presentation/pages/NavBar/SideMenu/SideMenu.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController messagebodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        // elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.contactus,
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
            buildLabel(AppLocalizations.of(context)!.name),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: nameController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.name,
                labelStyle: TextStyle(color: Color(0xFF002E70)),

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
                suffixIcon: Icon(Icons.person),
              ),
            ),
            // /////////////////////////////////////////////////////////////////////////////////////////////////////////
            buildLabel(AppLocalizations.of(context)!.phone),
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: phoneController,

              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.phone,
                labelStyle: TextStyle(color: Color(0xFF002E70)),

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
                    color: Color(0xFF002E70), // 👈 اللون وقت الـ focus
                    width: 2,
                  ),
                ),
                suffixIcon: Icon(Icons.phone),
              ),
            ),
            // /////////////////////////////////////////////////////////////////////////////////////////////////////////
            buildLabel(AppLocalizations.of(context)!.email),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: emailController,

              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.email,
                labelStyle: TextStyle(color: Color(0xFF002E70)),

                fillColor: const Color(0xFFD9D9D9).withOpacity(0.2),
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
                suffixIcon: Icon(Icons.email),
              ),
            ),
            // //////////////////////////////////////////////////////////////////////////////////////////////////////////
            // SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            buildLabel(AppLocalizations.of(context)!.messagebody),

            TextFormField(
              controller: messagebodyController,
              keyboardType: TextInputType.multiline,
              maxLines: 100, // هنا حددت 6 أسطر
              minLines: 6, // أقل حاجة 3 أسطر
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.messagebody,
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
            // //////////////////////////////////////////*/////////////////////////////
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),

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
                  AppLocalizations.of(context)!.submitmessage,

                  style: GoogleFonts.markaziText(
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
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

  // Widget buildTextFormField({
  //   required TextEditingController controller,
  //   required IconData icon,
  //   String? labelText,
  //   TextInputType keyboardType = TextInputType.text,
  //   // String? Function(String?)? validator,
  // }) {
  //   return TextFormField(
  //     controller: controller,
  //     keyboardType: keyboardType,
  //     decoration: InputDecoration(
  //       labelText: labelText,
  //       suffixIcon: Icon(
  //         icon,
  //         color: Colors.grey, // 👈 اللون العادي
  //       ),
  //       filled: true,
  //       fillColor: const Color(0xFFD9D9D9).withOpacity(0.2),
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(6),
  //         borderSide: const BorderSide(color: Colors.black45),
  //       ),
  //       enabledBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(6),
  //         borderSide: const BorderSide(color: Colors.black45),
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(8),
  //         borderSide: const BorderSide(color: Colors.grey, width: 2),
  //       ),
  //     ),
  //     // validator: validator,
  //   );
  // }
}
