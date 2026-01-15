// signup_page.dart
// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unused_import
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // 🚀 ضفنا الـ import ده
import 'package:tripto/bloc&repo/%D9%90Auth/AuthBloc.dart';
import 'package:tripto/bloc&repo/%D9%90Auth/AuthEvent.dart';
import 'package:tripto/bloc&repo/%D9%90Auth/AuthState.dart';
import 'package:tripto/l10n/app_localizations.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  int? gender;
  bool obsecureText1 = true;
  bool obsecureText2 = true;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  String? phoneNumber; // ده هيكون الرقم بدون كود الدولة
  String? completePhoneNumber; // ده هيكون الرقم بالكامل مع كود الدولة

  bool hasLowercase = false;
  bool hasUppercase = false;
  bool hasDigit = false;
  bool hasSpecialChar = false;
  bool hasMinLength = false;

  @override
  void initState() {
    super.initState();
    passController.addListener(_updatePasswordStrength);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.removeListener(_updatePasswordStrength);
    passController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  void _updatePasswordStrength() {
    final password = passController.text;
    setState(() {
      hasLowercase = password.contains(RegExp(r'[a-z]'));
      hasUppercase = password.contains(RegExp(r'[A-Z]'));
      hasDigit = password.contains(
        RegExp(r'[0-6]'),
      ); // 🚀 عدلتها عشان تشمل كل الأرقام
      hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      hasMinLength = password.length >= 6;
    });
  }

  // 🚀 دالة الـ registerUser دي هنشيلها خالص
  // Future<void> registerUser() async { ... }

  @override
  Widget build(BuildContext context) {
    // final inputBorder = OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(8),
    //   borderSide: const BorderSide(color: Colors.black45, width: 1),
    // );

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
      body: BlocListener<AuthBloc, AuthState>(
        // 🚀 BlocListener عشان نستقبل الـ States
        listener: (context, state) {
          if (state is AuthLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(AppLocalizations.of(context)!.loading)),
            );
          } else if (state is RegisterSuccess) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            _showSuccessDialog(context, state.message);
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            _showErrorDialog(context, 'failer: ${state.error}');
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset("assets/images/Logo.png", height: 120),
                buildLabel(AppLocalizations.of(context)!.name),
                buildTextFormField(
                  controller: nameController,
                  icon: Icons.person,
                  labelText: AppLocalizations.of(context)!.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.pleaseEnterName;
                    }
                    return null;
                  },
                ),
                buildLabel(AppLocalizations.of(context)!.phone),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, // ✅ كده صح
                  ],
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.phone,
                    labelStyle: TextStyle(color: Color(0xFF002E70)),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.black45,
                        width: 1,
                      ),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Color(0xFF002E70),
                        width: 2,
                      ),
                    ),
                    suffixIcon: Icon(Icons.phone),
                  ),
                  onChanged: (value) {
                    completePhoneNumber = value; // ✅ نخزن الرقم في المتغير
                    print("Phone: $completePhoneNumber");
                  },
                ),

                buildLabel(AppLocalizations.of(context)!.email),
                buildTextFormField(
                  controller: emailController,
                  icon: Icons.email_outlined,
                  labelText: AppLocalizations.of(context)!.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.pleaseEnterEmail;
                    }
                    if (!EmailValidator.validate(value)) {
                      return AppLocalizations.of(context)!.invalidEmail;
                    }
                    return null;
                  },
                ),
                buildLabel(AppLocalizations.of(context)!.password),
                buildPasswordField(
                  controller: passController,
                  obscure: obsecureText1,
                  toggle: () => setState(() => obsecureText1 = !obsecureText1),
                  labelText: AppLocalizations.of(context)!.password,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.pleaseEnterPassword;
                    }
                    if (value.length < 6) {
                      return AppLocalizations.of(context)!.passwordTooShort;
                    }
                    return null;
                  },
                ),
                buildLabel(AppLocalizations.of(context)!.password),
                buildPasswordField(
                  controller: confirmPassController,
                  obscure: obsecureText2,
                  toggle: () => setState(() => obsecureText2 = !obsecureText2),
                  labelText: AppLocalizations.of(context)!.confirmPassword,

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(
                        context,
                      )!.pleaseConfirmPassword;
                    }
                    if (value != passController.text) {
                      return AppLocalizations.of(context)!.passwordsDoNotMatch;
                    }
                    return null;
                  },
                ),
                _buildPasswordStrengthIndicator(
                  AppLocalizations.of(context)!.atLeast6Chars,
                  hasMinLength,
                ),
                _buildPasswordStrengthIndicator(
                  AppLocalizations.of(context)!.atLeastOneLowercaseLetter,
                  hasLowercase,
                ),
                _buildPasswordStrengthIndicator(
                  AppLocalizations.of(context)!.atLeastOneUppercaseLetter,
                  hasUppercase,
                ),
                _buildPasswordStrengthIndicator(
                  AppLocalizations.of(context)!.atLeastOneDigit,
                  hasDigit,
                ),
                _buildPasswordStrengthIndicator(
                  AppLocalizations.of(context)!.atLeastOneSpecialCharacter,
                  hasSpecialChar,
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
                      if (_formKey.currentState!.validate()) {
                        if (!hasLowercase ||
                            !hasUppercase ||
                            !hasDigit ||
                            !hasSpecialChar ||
                            !hasMinLength) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                AppLocalizations.of(context)!.passwordNotStrong,
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        if (completePhoneNumber == null ||
                            completePhoneNumber!.isEmpty) {
                          // 🚀 بنستخدم completePhoneNumber هنا
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                AppLocalizations.of(context)!.pleaseEnterPhone,
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        // 🚀 بنبعت الـ Event للـ AuthBloc بدل ما نستدعي API مباشرة
                        context.read<AuthBloc>().add(
                          RegisterRequested(
                            name: nameController.text.trim(),
                            email: emailController.text.trim(),
                            phoneNumber:
                                completePhoneNumber!, // 🚀 بنستخدم completePhoneNumber هنا
                            password: passController.text.trim(),
                            confirmPassword: confirmPassController.text.trim(),
                          ),
                        );
                      }
                    },
                    child: Text(
                      AppLocalizations.of(context)!.signUp,
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

  Widget buildTextFormField({
    required TextEditingController controller,
    required IconData icon,
    String? labelText,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Color(0xFF002E70)),

        suffixIcon: Icon(icon),
        // filled: true,
        // fillColor: const Color(0xFFD9D9D9).withOpacity(0.2),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.black45, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF002E70), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
      validator: validator,
    );
  }

  Widget buildPasswordField({
    required TextEditingController controller,
    required bool obscure,
    required VoidCallback toggle,
    String? labelText,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Color(0xFF002E70)),

        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          ),
          onPressed: toggle,
        ),
        // filled: true,
        // fillColor: const Color(0xFFD9D9D9).withOpacity(0.2),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.black45, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF002E70), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildPasswordStrengthIndicator(String text, bool isValid) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
      child: Row(
        children: [
          Icon(
            isValid ? Icons.check_circle : Icons.cancel,
            color: isValid ? Colors.green : Colors.blueAccent,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: isValid ? Colors.green : Colors.blueAccent,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
  // signup_page.dart

  // ... (باقي كود الـ SignupPageState قبل الدوال المساعدة)

  // 🚀 دالة لعرض رسالة النجاح في AlertDialog
  void _showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(AppLocalizations.of(context)!.success),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text(
                AppLocalizations.of(context)!.ok,
                style: TextStyle(color: Colors.blue),
              ),

              onPressed: () {
                // Navigator.of(context).pop(); // لإغلاق الـ dialog
                // 🚀 هنا ممكن تنتقل لصفحة تسجيل الدخول أو صفحة رئيسية بعد إغلاق الـ dialog
                Navigator.of(context).pushReplacementNamed('/app');
              },
            ),
          ],
        );
      },
    );
  }
  // signup_page.dart

  // ... (باقي الكود)

  // 🚀 دالة لعرض رسالة الخطأ في AlertDialog
  void _showErrorDialog(BuildContext context, String errorMessage) {
    String cleanedErrorMessage = errorMessage;

    // بنشيل "failer: " لو موجودة (من BlocListener لو لسه بتستخدمها)
    if (cleanedErrorMessage.startsWith('failer: ')) {
      cleanedErrorMessage = cleanedErrorMessage.substring('failer: '.length);
    }
    // وبنشيل "Exception: " لو لسه موجودة (من الـ e.toString() في الـ Bloc)
    if (cleanedErrorMessage.startsWith('Exception: ')) {
      cleanedErrorMessage = cleanedErrorMessage.substring('Exception: '.length);
    }

    cleanedErrorMessage = cleanedErrorMessage.trim();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(AppLocalizations.of(context)!.error),
          content: Text(cleanedErrorMessage), // نعرض الرسالة النظيفة مباشرة
          actions: <Widget>[
            TextButton(
              child: Text(
                AppLocalizations.of(context)!.ok,
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
