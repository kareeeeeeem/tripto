import 'package:flutter/material.dart';

class splashpage extends StatelessWidget {
  const splashpage ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Stack(
    children: [
      SizedBox(
      child: Image.asset("assets/images/splash.png"),
      )
],
    ),
    );
  }
}