import 'package:flutter/material.dart';
import 'package:tripto/core/constants/textfield_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Profile",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.settings, size: 35),
            onPressed: () {},
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage("assets/images/shika.png"),
              ),
              SizedBox(height: 60,),
              textfield(label: "Name", onEdit: () {}),
              SizedBox(height: 30,),
              textfield(label: "Email", onEdit: () {}),
              SizedBox(height: 30,),
              textfield(label: "phone", onEdit: () {}),
              SizedBox(height: 30,),
              textfield(label: "phone", onEdit: () {}),
              SizedBox(height: 30,),
              textfield(label: "Password", onEdit: () {}),
              const SizedBox(height: 60),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2196F3),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Save",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
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
