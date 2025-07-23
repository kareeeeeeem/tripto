import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tripto/core/services/api.dart';
import 'package:tripto/l10n/app_localizations.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  Future<void> registerUser() async {
    if (!_formKey.currentState!.validate()) return;

    final url = Uri.parse('${ApiConstants.baseUrl}register');

    final bodyData = jsonEncode({
      'name': nameController.text.trim(),
      'email': emailController.text.trim(),
      'phone': phoneNumber,
      'password': passController.text.trim(),
      'password_confirmation': confirmPassController.text.trim(),
    });

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: bodyData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        print('✅ Success: $data');
      } else {
        print('❌ Error: ${response.body}');
      }
    } catch (e) {
      print('🔴 Exception: $e');
    }
  }

  int? gender;
  bool obsecureText1 = true;
  bool obsecureText2 = true;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  String? phoneNumber;

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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset("assets/images/Logo.png", height: 120),
              buildLabel(AppLocalizations.of(context)!.name),
              buildInputField(
                controller: nameController,
                icon: Icons.person,
                validator: (value) => value!.isEmpty ? 'الاسم مطلوب' : null,
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
                  phoneNumber = phone.number;
                },
                validator: (phone) {
                  if (phone == null || phone.number.length < 9) {
                    return 'رقم الهاتف غير صحيح';
                  }
                  return null;
                },
              ),
              buildLabel(AppLocalizations.of(context)!.password),
              buildPasswordField(
                controller: passController,
                obscure: obsecureText1,
                toggle: () => setState(() => obsecureText1 = !obsecureText1),
                validator:
                    (value) => value!.length < 6 ? 'كلمة المرور قصيرة' : null,
              ),
              buildLabel(AppLocalizations.of(context)!.confirmpassword),
              buildPasswordField(
                controller: confirmPassController,
                obscure: obsecureText2,
                toggle: () => setState(() => obsecureText2 = !obsecureText2),
                validator:
                    (value) =>
                        value != passController.text
                            ? 'كلمتا المرور غير متطابقتين'
                            : null,
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
                  onPressed: registerUser,
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
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
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
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
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
