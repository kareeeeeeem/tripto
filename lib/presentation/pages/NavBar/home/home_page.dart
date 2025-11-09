import 'package:flutter/material.dart';
import 'package:tripto/presentation/pages/NavBar/home/homepage/VedioPlayerPage.dart';
import 'package:tripto/main.dart'; // ⚠️ هذا السطر مهم جداً لاستيراد المفتاح

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: VideoPlayerScreen(key: videoPlayerScreenKey),
    );
  }
}
