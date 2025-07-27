import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
// تم إزالة استيراد NavBar.dart هنا لأنه لم يعد جزءًا من ProfilePage.
// import 'package:tripto/core/constants/NavBar.dart';
import 'package:tripto/core/constants/Colors_Fonts_Icons.dart';
import 'package:tripto/core/constants/Profiletextfield.dart';
import 'package:tripto/l10n/app_localizations.dart';
import 'package:tripto/presentation/pagess/Login_pages/SignupOrLogin.dart';
// تم إزالة استيراد app.dart هنا لأنه لم يعد يستخدم بهذه الطريقة.
// import 'package:tripto/presentation/app/app.dart';

class ProfilePage extends StatefulWidget {
  // تأكيد استخدام الاسم الأصلي
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isNameReadOnly = true;
  bool isEmailReadOnly = true;
  bool isPhoneReadOnly = true;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    final storage = SecureStorageService();
    final userData = await storage.getUser();

    if (userData != null) {
      setState(() {
        nameController.text = userData['name'] ?? '';
        emailController.text = userData['email'] ?? '';
        phoneController.text = userData['phone'] ?? '';
        // لا تقومي بتحميل كلمة المرور وعرضها بهذا الشكل لأسباب أمنية.
        // passwordController.text = userData['password'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.profile,
          style: GoogleFonts.markaziText(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(
            Localizations.localeOf(context).languageCode == 'ar'
                ? Icons.keyboard_arrow_right_outlined
                : Icons.keyboard_arrow_left_outlined,
            size: 35,
            color: Colors.black,
          ),
          onPressed: () {
            // استخدام Navigator.pop للرجوع للصفحة السابقة في الـ Stack.
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        // تم تعديل padding السفلي لأن NavBar لم يعد موجودًا.
        padding: EdgeInsets.only(bottom: height * 0.05),
        child: Padding(
          padding: EdgeInsets.all(width * 0.04),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage("assets/images/shika.png"),
              ),
              SizedBox(height: height * 0.07),
              Profiletextfield(
                label: AppLocalizations.of(context)!.name,
                isReadOnly: isNameReadOnly,
                controller: nameController,
              ),
              SizedBox(height: height * 0.05),
              Profiletextfield(
                label: AppLocalizations.of(context)!.email,
                isReadOnly: isEmailReadOnly,
                controller: emailController,
              ),
              SizedBox(height: height * 0.05),
              Profiletextfield(
                label: AppLocalizations.of(context)!.phone,
                isReadOnly: isPhoneReadOnly,
                controller: phoneController,
              ),
              SizedBox(height: height * 0.05),
              Profiletextfield(
                label: AppLocalizations.of(context)!.password,
                isReadOnly:
                    true, // دائمًا للقراءة فقط أو لحقل تغيير كلمة المرور.
                controller: passwordController,
                // obscureText: true, // لإخفاء النص في حقل كلمة المرور.
              ),
              SizedBox(height: height * 0.05),
              SizedBox(
                width: width,
                height: height * 0.06,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: btn_background_color_gradiant,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      isEditing = !isEditing;
                      isNameReadOnly = !isNameReadOnly;
                      isEmailReadOnly = !isEmailReadOnly;
                      isPhoneReadOnly = !isPhoneReadOnly;
                    });
                    // TODO: أضيفي هنا منطق حفظ التغييرات لو isEditing أصبح false.
                    if (!isEditing) {
                      // يمكنك هنا استدعاء UserRepository لتحديث البيانات.
                    }
                  },
                  child: Text(
                    isEditing
                        ? AppLocalizations.of(context)!.save
                        : AppLocalizations.of(context)!.edit,
                    style: GoogleFonts.markaziText(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.025),

              SizedBox(
                width: width,
                height: height * 0.06,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    // TODO: أضيفي منطق تسجيل الخروج هنا.

                    // مسح التوكن وبيانات المستخدم من التخزين الآمن.
                    final storage = SecureStorageService();
                    await storage._storage.delete(key: 'jwt_token');
                    await storage._storage.delete(key: 'user_data');

                    // ثم العودة لصفحة تسجيل الدخول/التسجيل وإزالة كل الصفحات السابقة.
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Signuporlogin(),
                      ),
                      (route) => false,
                    );
                  },
                  child: Text(
                    'Logout',
                    style: GoogleFonts.markaziText(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(height: height * 0.015),
              SizedBox(
                width: width,
                height: height * 0.06,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black54,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // TODO: أضيفي منطق حذف الحساب هنا.
                  },
                  child: Text(
                    'Delete my account',
                    style: GoogleFonts.markaziText(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}

class SecureStorageService {
  final _storage = const FlutterSecureStorage();

  Future<void> saveUser(String userJson) async {
    await _storage.write(key: 'user_data', value: userJson);
  }

  Future<Map<String, dynamic>?> getUser() async {
    final userData = await _storage.read(key: 'user_data');
    if (userData != null) {
      return jsonDecode(userData);
    }
    return null;
  }
}
