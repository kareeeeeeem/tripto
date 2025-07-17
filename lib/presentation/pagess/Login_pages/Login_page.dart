import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripto/l10n/app_localizations.dart';
import 'package:tripto/presentation/pagess/Login_pages/verification_page.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? completePhoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Localizations.localeOf(context).languageCode == 'ar'
                ? Icons.keyboard_arrow_right_outlined  // في العربي: سهم لليمين
                : Icons.keyboard_arrow_left_outlined,
            size: 35,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(
              top:
                  MediaQuery.of(context).size.height *
                  0.07, // تقريبًا تعادل 110 على شاشة ارتفاعها ~800
            ),
            child: Column(
              children: [
                Text(
                AppLocalizations.of(context)!.joinusviaphonenumber,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text(
                  AppLocalizations.of(context)!.wewilltextacodetoverfiyyournumber,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF989898),
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                Padding(
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.width * 0.04,
                  ), // حوالي 4% من العرض
                  child: IntlPhoneField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    initialCountryCode: 'SA',
                    onChanged: (phone) {
                      completePhoneNumber = phone.completeNumber;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.width * 0.025,
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.878,
                    height: MediaQuery.of(context).size.height * 0.05875,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF002E70),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        if (completePhoneNumber != null &&
                            completePhoneNumber!.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => Verification(
                                    phoneNumber: completePhoneNumber!,
                                  ),
                            ),
                          );
                        } else {
                          // ممكن تظهر رسالة هنا إن الرقم فاضي
                          print("Please enter a valid phone number.");
                        }
                      },
                      child: Text(
                        AppLocalizations.of(context)!.next,
                        style: GoogleFonts.lateef(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
