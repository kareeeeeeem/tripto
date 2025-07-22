import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tripto/l10n/app_localizations.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  Future<void> registerUser() async {
    final url = Uri.parse(
      'https://tripto.blueboxpet.com/',
    ); // ← غيّر الرابط حسب الـ endpoint الصح

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': nameController.text.trim(),
          'email': emailController.text.trim(),
          'password': passController.text.trim(),
          'confirm_password': confirmPassController.text.trim(),
          'phone': completePhoneNumber,
          'gender': gender == 1 ? 'male' : 'female',
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        print('✅ Success: $data');
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم التسجيل بنجاح")));
        // Navigator.push(...);
      } else {
        print('❌ Error: ${response.body}');
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("فشل التسجيل")));
      }
    } catch (e) {
      print('🔴 Exception: $e');
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("حصل خطأ غير متوقع")));
    }
  }

  int? gender;
  bool obsecureText1 = true;
  bool obsecureText2 = true;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  String? completePhoneNumber;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.black45, width: 1),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Localizations.localeOf(context).languageCode == 'ar'
                ? Icons.keyboard_arrow_right_outlined
                : Icons.keyboard_arrow_left_outlined,
            size: 35,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Image.asset("assets/images/Logo.png", height: 120),
            buildLabel(AppLocalizations.of(context)!.name),
            buildInputField(controller: nameController, icon: Icons.person),
            buildLabel(AppLocalizations.of(context)!.email),
            buildInputField(
              controller: emailController,
              icon: Icons.email_outlined,
            ),
            buildLabel(AppLocalizations.of(context)!.password),
            buildPasswordField(
              controller: passController,
              obscure: obsecureText1,
              toggle: () {
                setState(() {
                  obsecureText1 = !obsecureText1;
                });
              },
            ),
            buildLabel(AppLocalizations.of(context)!.confirmpassword),
            buildPasswordField(
              controller: confirmPassController,
              obscure: obsecureText2,
              toggle: () {
                setState(() {
                  obsecureText2 = !obsecureText2;
                });
              },
            ),
            buildLabel(AppLocalizations.of(context)!.phone),
            IntlPhoneField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.phone),
                filled: true,
                fillColor: const Color(0xFFD9D9D9).withOpacity(0.2),
                border: inputBorder,
                enabledBorder: inputBorder,
                focusedBorder: inputBorder.copyWith(
                  borderSide: const BorderSide(color: Colors.grey, width: 2),
                ),
              ),
              initialCountryCode: 'SA',
              onChanged: (phone) {
                completePhoneNumber = phone.completeNumber;
              },
            ),
            buildLabel(AppLocalizations.of(context)!.gender),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: 1,
                  groupValue: gender,
                  onChanged: (value) => setState(() => gender = value),
                  activeColor: const Color(0xFF002E70),
                ),
                Text(AppLocalizations.of(context)!.male),
                const SizedBox(width: 30),
                Radio(
                  value: 2,
                  groupValue: gender,
                  onChanged: (value) => setState(() => gender = value),
                  activeColor: const Color(0xFF002E70),
                ),
                Text(AppLocalizations.of(context)!.female),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF002E70),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  registerUser();

                  // هنا تقدر تستخدم controllers و completePhoneNumber وترسلهم للـ API
                },
                child: Text(
                  AppLocalizations.of(context)!.signup,
                  style: GoogleFonts.markaziText(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
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

  Widget buildInputField({
    required TextEditingController controller,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: Icon(icon),
        filled: true,
        fillColor: const Color(0xFFD9D9D9).withOpacity(0.2),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.black45, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey, width: 2),
        ),
      ),
    );
  }

  Widget buildPasswordField({
    required TextEditingController controller,
    required bool obscure,
    required VoidCallback toggle,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          ),
          onPressed: toggle,
        ),
        filled: true,
        fillColor: const Color(0xFFD9D9D9).withOpacity(0.2),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.black45, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey, width: 2),
        ),
      ),
    );
  }
}
