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
              CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage("assets/images/shika.png"),
              ),
            textfield(label: "Name", onEdit: (){}
            ),
              textfield(label: "Email", onEdit: (){}
              ),
              textfield(label: "phone", onEdit: (){}
              ),
              textfield(label: "phone", onEdit: (){}
              ),
              textfield(label: "Password", onEdit: (){}
              ),
            ],
          ),
        ),
      ),
    );
  }
}
