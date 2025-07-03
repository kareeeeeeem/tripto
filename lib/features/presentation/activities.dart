import 'package:flutter/material.dart';


class activities extends StatelessWidget {
  const activities({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Activities",
          style: TextStyle(fontWeight: FontWeight.bold)) ,
            centerTitle : true,
          backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,


          ),

        );
  }
}
