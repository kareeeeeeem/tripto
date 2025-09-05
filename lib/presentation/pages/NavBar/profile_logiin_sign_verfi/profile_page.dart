import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripto/bloc&repo/ProfileUserDate/Edit/EditBloc.dart';
import 'package:tripto/bloc&repo/ProfileUserDate/Edit/EditEvent.dart';
import 'package:tripto/bloc&repo/ProfileUserDate/Edit/EditModel.dart';
import 'package:tripto/bloc&repo/ProfileUserDate/Edit/EditState.dart';
import 'package:tripto/bloc&repo/ProfileUserDate/logout/LogoutBloc.dart';
import 'package:tripto/bloc&repo/ProfileUserDate/logout/LogoutEvent.dart';
import 'package:tripto/bloc&repo/ProfileUserDate/logout/LogoutState.dart';
import 'package:tripto/core/constants/Colors_Fonts_Icons.dart';
import 'package:tripto/l10n/app_localizations.dart';
import 'package:tripto/presentation/app/app.dart';
import 'package:tripto/presentation/pages/NavBar/profile_logiin_sign_verfi/SignupOrLogin.dart';

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

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _nameFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    super.dispose();
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
        "id": user.id,
        "name": user.name,
        "email": user.email,
        "phone": user.phone,
      }),
    );
    setState(() {
      userId = user.id;
    });
  }

  void _handleEditSave() {
    // أولًا نفصل أي TextField نشط
    FocusScope.of(context).unfocus();

    // تأخير بسيط عشان الـ TextField يكون جاهز قبل التحديث
    Future.delayed(const Duration(milliseconds: 100), () {
      if (userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User ID not loaded yet.")),
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
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFF002E70)),
        ),
      );
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
                    "${AppLocalizations.of(context)!.profile} updated successfully",
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
      child: GestureDetector(
        onTap: () {
          // Dismiss keyboard when tapping outside
          FocusScope.of(context).unfocus();
        },
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
              onPressed: () {
                FocusScope.of(context).unfocus();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const App()),
                  (route) => false,
                );
              },
            ),
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: height * 0.05),
            child: Padding(
              padding: EdgeInsets.all(width * 0.06),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/images/pro.png"),
                  ),
                  SizedBox(height: height * 0.07),

                  TextFormField(
                    keyboardType: TextInputType.name,
                    inputFormatters: [
                      FilteringTextInputFormatter
                          .singleLineFormatter, // ✅ لو عايز الرقم بس، لكن غالبًا الاسم مش أرقام
                    ],
                    controller: nameController,
                    focusNode: _nameFocus,
                    readOnly: isNameReadOnly,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.name,
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

                      suffixIcon: Icon(
                        Icons.person,
                      ), // استخدم Icons.person بدل Icons.name
                    ),
                  ),

                  // Profiletextfield(
                  //   label: AppLocalizations.of(context)!.name,
                  //   isReadOnly: isNameReadOnly,
                  //   controller: nameController,
                  //   focusNode: _nameFocus,
                  //   fieldType: FieldType.name,
                  // ),
                  SizedBox(height: height * 0.05),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    inputFormatters: [
                      FilteringTextInputFormatter
                          .singleLineFormatter, // ✅ لو عايز الرقم بس، لكن غالبًا الاسم مش أرقام
                    ],
                    controller: emailController,
                    focusNode: _emailFocus,
                    readOnly: isEmailReadOnly,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.email,
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
                      suffixIcon: Icon(
                        Icons.email,
                      ), // استخدم Icons.person بدل Icons.name
                    ),
                  ),

                  // Profiletextfield(
                  //   label: AppLocalizations.of(context)!.email,
                  //   isReadOnly: isEmailReadOnly,
                  //   controller: emailController,
                  //   focusNode: _emailFocus,
                  //   fieldType: FieldType.email,
                  // ),
                  SizedBox(height: height * 0.15),

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
                      onPressed: _handleEditSave,
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
                        backgroundColor: Color(0xFF002E70),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        context.read<LogoutBloc>().add(LogoutRequested());
                      },
                      child: Text(
                        AppLocalizations.of(context)!.logout,
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
