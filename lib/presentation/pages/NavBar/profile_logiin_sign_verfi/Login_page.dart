// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripto/l10n/app_localizations.dart';
import 'package:tripto/bloc&repo/%D9%90Auth/AuthBloc.dart';
import 'package:tripto/bloc&repo/%D9%90Auth/AuthEvent.dart';
import 'package:tripto/bloc&repo/%D9%90Auth/AuthState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart'; // ضروري لإدخال الأرقام فقط

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? completePhoneNumber;
  bool obscurePassword = true;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  // final _storage = const FlutterSecureStorage();

  @override
  void dispose() {
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
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
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is AuthLoading) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Loading...')));
          } else if (state is LoginSuccess) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            Navigator.of(context).pushReplacementNamed('/app');
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
        },
        child: Container(
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

                  /// Phone Field (بدون اختيار كود الدولة)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                    ),
                    child: TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter
                            .digitsOnly, // يقبل أرقام فقط
                      ],
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.phone,
                        labelStyle: TextStyle(color: Color(0xFF002E70)),
                        suffixIcon: const Icon(Icons.phone),
                        // filled: true,
                        // fillColor: const Color(0xFFD9D9D9).withOpacity(0.2),
                        prefixIcon: const Icon(Icons.phone),
                        filled: true,
                        fillColor: const Color(0xFFD9D9D9).withOpacity(0.2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(color: Colors.black45),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(color: Colors.black45),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        completePhoneNumber = value; // الرقم زي ما هو
                      },
                    ),
                  ),

                  /// Password Field (بدون تغييرات)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: 12,
                    ),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: obscurePassword,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.password,
                        labelStyle: TextStyle(color: Color(0xFF002E70)),

                        suffixIcon: IconButton(
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                        ),
                        // filled: true,
                        // fillColor: const Color(0xFFD9D9D9).withOpacity(0.2),
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
                    ),
                  ),

                  /// Login Button
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
                          if ((completePhoneNumber != null &&
                              completePhoneNumber!.isNotEmpty &&
                              passwordController.text.isNotEmpty)) {
                            context.read<AuthBloc>().add(
                              LoginRequested(
                                phoneNumber:
                                    completePhoneNumber!, // الرقم اللي دخلته زي ما هو
                                password: passwordController.text,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.pleaseEnterPhoneAndPassword,
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
      ),
    );
  }
}
