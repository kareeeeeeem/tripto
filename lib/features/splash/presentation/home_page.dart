import 'package:flutter/material.dart';
import 'package:tripto/features/splash/presentation/vedio_player_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox.expand(
        child: VideoPlayerPage(),  // ← دي اللي هتعرض الفيديوهات بالحجم الكامل
      ),
    );
  }
}
