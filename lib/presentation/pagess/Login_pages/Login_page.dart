import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripto/core/services/api.dart'; // تأكد إن ده مسار ملف ApiConstants بتاعك
import 'package:tripto/l10n/app_localizations.dart';
import 'package:tripto/presentation/pagess/Login_pages/verification_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? completePhoneNumber; // هذا المتغير سيحمل الرقم كاملاً مع كود الدولة

  Future<void> sendPhoneNumberToApi(String phone) async {
    final url = Uri.parse(
      '${ApiConstants.baseUrl}login',
    ); // <--- عدّل الـ 'login' حسب الـ endpoint الصحيح في الـ Backend

    print(
      'Sending phone number payload: {"phone": "$phone"} to URL: $url',
    ); // لطباعة الـ payload والـ URL

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phone': phone}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = jsonDecode(response.body);
        print(
          '✅ Success API Response: $body',
        ); // طباعة استجابة الـ API عند النجاح

        // الانتقال لصفحة التحقق
        // هنا أنت ترسل completePhoneNumber (الرقم بكود الدولة) إلى صفحة التحقق.
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Verification(phoneNumber: phone),
          ),
        );
      } else {
        print(
          '❌ API Error: ${response.statusCode} - ${response.body}',
        ); // طباعة تفاصيل الخطأ من الـ API
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('فشل الإرسال: ${response.statusCode}')),
        );
      }
    } catch (e) {
      print('🔴 Network Exception: $e'); // طباعة أي أخطاء في الاتصال
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('حدث خطأ أثناء الاتصال: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            locale == 'ar'
                ? Icons.keyboard_arrow_right_outlined
                : Icons.keyboard_arrow_left_outlined,
            size: 35,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.07),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.joinusviaphonenumber,
                  style: GoogleFonts.markaziText(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  textDirection:
                      locale == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  AppLocalizations.of(
                    context,
                  )!.wewilltextacodetoverfiyyournumber,
                  style: GoogleFonts.markaziText(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF989898),
                  ),
                  textAlign: TextAlign.center,
                  textDirection:
                      locale == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                ),
                SizedBox(height: screenHeight * 0.08),

                // رقم الهاتف
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                  child: IntlPhoneField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(
                          color: Colors.black45,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 2,
                        ),
                      ),
                    ),
                    initialCountryCode: 'SA',
                    onChanged: (phone) {
                      // هنا بنخزن الرقم كاملاً بكود الدولة
                      completePhoneNumber = phone.completeNumber;
                    },
                  ),
                ),

                // زر "التالي"
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.025),
                  child: SizedBox(
                    width: screenWidth * 0.878,
                    height: screenHeight * 0.05875,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF002E70),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        // هنا بنتأكد إن الرقم مش فاضي قبل ما نبعته
                        if (completePhoneNumber != null &&
                            completePhoneNumber!.isNotEmpty) {
                          sendPhoneNumberToApi(completePhoneNumber!);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                locale == 'ar'
                                    ? 'من فضلك أدخل رقم هاتف صحيح'
                                    : 'Please enter a valid phone number.',
                                textAlign: TextAlign.center,
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: Text(
                        AppLocalizations.of(context)!.login,
                        style: GoogleFonts.markaziText(
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
