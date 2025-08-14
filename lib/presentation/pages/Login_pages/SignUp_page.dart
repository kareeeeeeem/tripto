// signup_page.dart
// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unused_import
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // 🚀 ضفنا الـ import ده
import 'package:tripto/bloc/%D9%90Auth/AuthBloc.dart';
import 'package:tripto/bloc/%D9%90Auth/AuthEvent.dart';
import 'package:tripto/bloc/%D9%90Auth/AuthState.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

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
      body: BlocListener<AuthBloc, AuthState>(
        // 🚀 BlocListener عشان نستقبل الـ States
        listener: (context, state) {
          if (state is AuthLoading) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('loading...')));
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
                buildLabel("Name"),
                buildTextFormField(
                  controller: nameController,
                  icon: Icons.person,
                  labelText: "Name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your name";
                    }
                    return null;
                  },
                ),
                buildLabel("Phone"),
                IntlPhoneField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Phone",
                    suffixIcon: const Icon(Icons.phone),
                    filled: true,
                    fillColor: const Color(0xFFD9D9D9).withOpacity(0.2),
                    border: inputBorder,
                    enabledBorder: inputBorder,
                    focusedBorder: inputBorder.copyWith(
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 2,
                      ),
                    ),
                    errorBorder: inputBorder.copyWith(
                      borderSide: const BorderSide(color: Colors.red, width: 2),
                    ),
                    focusedErrorBorder: inputBorder.copyWith(
                      borderSide: const BorderSide(color: Colors.red, width: 2),
                    ),
                  ),
                  initialCountryCode: 'EG',
                  onChanged: (phone) {
                    phoneNumber = phone.number;
                    completePhoneNumber =
                        phone.completeNumber; // 🚀 حفظ الرقم كامل
                  },
                  validator: (phone) {
                    if (phone == null || phone.number.isEmpty) {
                      return "Please enter your phone number";
                    }
                    if (phone.number.length < 9) {
                      return "Phone number is too short";
                    }
                    return null;
                  },
                ),
                buildLabel("Email"),
                buildTextFormField(
                  controller: emailController,
                  icon: Icons.email_outlined,
                  labelText: "Email",
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    }
                    if (!EmailValidator.validate(value)) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                ),
                buildLabel("Password"),
                buildPasswordField(
                  controller: passController,
                  obscure: obsecureText1,
                  toggle: () => setState(() => obsecureText1 = !obsecureText1),
                  labelText: "Password",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password";
                    }
                    if (value.length < 6) {
                      return "Password is too short (min 6 characters)";
                    }
                    return null;
                  },
                ),
                buildLabel("Confirm Password"),
                buildPasswordField(
                  controller: confirmPassController,
                  obscure: obsecureText2,
                  toggle: () => setState(() => obsecureText2 = !obsecureText2),
                  labelText: "Confirm Password",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please confirm your password";
                    }
                    if (value != passController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),
                _buildPasswordStrengthIndicator(
                  "At least 6 characters",
                  hasMinLength,
                ),
                _buildPasswordStrengthIndicator(
                  "At least one lowercase letter",
                  hasLowercase,
                ),
                _buildPasswordStrengthIndicator(
                  "At least one uppercase letter",
                  hasUppercase,
                ),
                _buildPasswordStrengthIndicator("At least one digit", hasDigit),
                _buildPasswordStrengthIndicator(
                  "At least one special character",
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
                              content: Text("Password is not strong enough"),
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
                                "Please enter a valid phone number",
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
                      "Sign Up",
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
          title: Text('Successful ✅ '),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('ok', style: TextStyle(color: Colors.blue)),
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
          title: Text('Error! 😔'),
          content: Text(cleanedErrorMessage), // نعرض الرسالة النظيفة مباشرة
          actions: <Widget>[
            TextButton(
              child: Text('ok', style: TextStyle(color: Colors.blue)),
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
