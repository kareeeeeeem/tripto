import 'package:flutter/material.dart';
import 'package:tripto/core/constants/CustomNavBar.dart';
import 'package:tripto/core/constants/colors.dart';
import 'package:tripto/core/constants/Profiletextfield.dart';
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

  int currentIndex = 2; // نخليها 2 لأنها بتمثل الـ Profile حسب الترتيب

  void _changePage(int index) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => App(initialIndex: index)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,

        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left_outlined, size: 35),
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
            padding: const EdgeInsets.only(bottom: 100), // مسافة تحت للـ NavBar
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage("assets/images/shika.png"),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                  Profiletextfield(
                    label: "Name",
                    isReadOnly: isNameReadOnly,
                    controller: nameController,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.050),
                  Profiletextfield(
                    label: "Email",
                    isReadOnly: isEmailReadOnly,
                    controller: emailController,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.050),
                  Profiletextfield(
                    label: "Phone1",
                    isReadOnly: isPhoneReadOnly,
                    controller: phoneController,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.050),
                  Profiletextfield(
                    label: "Password",
                    isReadOnly: isPasswordReadOnly,
                    controller: passwordController,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.075),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.035,
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.85,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: btn_background_color_gradiant,
                              minimumSize: Size(
                                MediaQuery.of(context).size.width,
                                MediaQuery.of(context).size.height * 0.06,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                if (isEditing) {
                                  // Save data here if needed
                                  isEditing = false;
                                  isNameReadOnly = true;
                                  isEmailReadOnly = true;
                                  isPhoneReadOnly = true;
                                  isPasswordReadOnly = true;
                                } else {
                                  isEditing = true;
                                  isNameReadOnly = false;
                                  isEmailReadOnly = false;
                                  isPhoneReadOnly = false;
                                  isPasswordReadOnly = false;
                                }
                              });
                            },
                            child: Text(
                              isEditing ? "Save" : "Edit",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ✅ Custom Bottom Navigation Bar
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
