import 'package:flutter/material.dart';
import 'package:tripto/core/constants/nav_bar.dart';
import 'package:tripto/features/presentation/vedio_player_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children:  [
          Expanded(child: VideoPlayerPage()),
         ],
      ),
    );
  }
}
