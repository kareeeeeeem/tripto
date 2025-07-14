import 'package:flutter/material.dart';
import 'package:tripto/core/constants/colors.dart';
import 'package:tripto/core/constants/Profiletextfield.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 35),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.075, // تقريبًا 7.5% من ارتفاع الشاشة
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.035),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: btn_background_color_gradiant,
                          minimumSize: const Size(double.infinity, 50),
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
    );
  }
}
