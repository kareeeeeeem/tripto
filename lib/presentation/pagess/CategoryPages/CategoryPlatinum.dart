import 'package:flutter/material.dart';
import 'package:tripto/core/constants/DiagonalPainter.dart';

class PlatinumCategory extends StatelessWidget {
  const PlatinumCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFE0E0E0), // Platinum Silver-ish
            Color(0x55FFFFFF),
          ],
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.white70,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.white70, width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned.fill(child: CustomPaint(painter: DiagonalPainter())),
            const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.diamond_outlined, size: 50, color: Colors.black87),
                  SizedBox(height: 10),
                  Text(
                    'Platinum',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
