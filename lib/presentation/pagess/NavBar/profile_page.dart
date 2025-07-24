import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripto/core/constants/NavBar.dart';
import 'package:tripto/core/constants/Colors_Fonts_Icons.dart';
import 'package:tripto/core/constants/Profiletextfield.dart';
import 'package:tripto/l10n/app_localizations.dart';
import 'package:tripto/presentation/app/app.dart';

class ProfilePage extends StatefulWidget {
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
  bool isPasswordReadOnly = true;
  bool isEditing = false;

  int currentIndex = 2;

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
        passwordController.text = userData['password'] ?? '';
      });
    }
  }

  void _changePage(int index) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => App(initialIndex: index)),
    );
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
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const App()),
              (route) => false,
            );
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: height * 0.22),
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
                    isReadOnly: isPasswordReadOnly,
                    controller: passwordController,
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
                          isPasswordReadOnly = !isPasswordReadOnly;
                        });
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
                      onPressed: () {
                        // Logout logic
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
                        // Delete account logic
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
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomBottomNavBar(
              currentIndex: currentIndex,
              onTap: _changePage,
            ),
          ),
        ],
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
