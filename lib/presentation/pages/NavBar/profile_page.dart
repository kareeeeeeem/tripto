import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripto/bloc/ProfileUserDate/Edit/EditBloc.dart';
import 'package:tripto/bloc/ProfileUserDate/Edit/EditEvent.dart';
import 'package:tripto/bloc/ProfileUserDate/Edit/EditModel.dart';
import 'package:tripto/bloc/ProfileUserDate/Edit/EditState.dart';
import 'package:tripto/bloc/ProfileUserDate/logout/LogoutBloc.dart';
import 'package:tripto/bloc/ProfileUserDate/logout/LogoutEvent.dart';
import 'package:tripto/bloc/ProfileUserDate/logout/LogoutState.dart';
import 'package:tripto/core/constants/Colors_Fonts_Icons.dart';
import 'package:tripto/core/constants/Profiletextfield.dart';
import 'package:tripto/l10n/app_localizations.dart';
import 'package:tripto/presentation/pages/Login_pages/SignupOrLogin.dart';

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
  bool isEditing = false;
  bool isLoading = true;

  int? userId;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final storage = SecureStorageService();
    final userData = await storage.getUser();

    if (userData != null) {
      setState(() {
        userId = int.tryParse(userData['id'].toString());
        nameController.text = userData['name'] ?? '';
        emailController.text = userData['email'] ?? '';
        phoneController.text = userData['phone'] ?? '';
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User data not found. Please login again."),
        ),
      );
    }
  }

  Future<void> _saveUser(User user) async {
    final storage = SecureStorageService();
    await storage.saveUser(
      jsonEncode({
        "id": int.tryParse(user.id.toString()),
        "name": user.name,
        "email": user.email,
        "phone": user.phone,
      }),
    );
    setState(() {
      userId = int.tryParse(user.id.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return MultiBlocListener(
      listeners: [
        BlocListener<UpdateUserBloc, UpdateUserState>(
          listener: (context, state) async {
            if (state is UpdateUserSuccess) {
              nameController.text = state.user.name;
              emailController.text = state.user.email;
              phoneController.text = state.user.phone;

              await _saveUser(state.user);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    AppLocalizations.of(context)!.profile +
                        " updated successfully",
                  ),
                ),
              );
            } else if (state is UpdateUserFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),
        BlocListener<LogoutBloc, LogoutState>(
          listener: (context, state) {
            if (state is LogoutSuccess) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const Signuporlogin()),
                (route) => false,
              );
            } else if (state is LogoutFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),
      ],
      child: Scaffold(
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
            onPressed: () => Navigator.pop(context),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
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
                  isReadOnly: true,
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
                      if (userId == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("User ID not loaded yet."),
                          ),
                        );
                        return;
                      }

                      setState(() {
                        isEditing = !isEditing;
                        isNameReadOnly = !isNameReadOnly;
                        isEmailReadOnly = !isEmailReadOnly;
                        isPhoneReadOnly = !isPhoneReadOnly;
                      });

                      if (!isEditing) {
                        context.read<UpdateUserBloc>().add(
                          UpdateUserRequested(
                            id: userId!,
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          ),
                        );
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
                // Logout Button (Bloc)
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
                      context.read<LogoutBloc>().add(LogoutRequested());
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
                // Delete Account Button
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
                      // TODO: Delete account logic
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
                SizedBox(height: height * 0.05),
              ],
            ),
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
