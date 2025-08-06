import 'package:flutter/material.dart';
import 'package:tripto/presentation/pages/NavBar/homePage/vedio_player_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: VideoPlayerScreen(),
    );
  }
}
