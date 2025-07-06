import 'package:flutter/material.dart';
import 'package:tripto/core/constants/DiagonalPainter.dart';

class GoldCategory extends StatelessWidget {
  const GoldCategory({super.key});

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
            Color(0xFFFFD700), // Gold Color
            Color(0x55FFFFFF), // Transparent White
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.amber, width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Diagonal cut
            Positioned.fill(child: CustomPaint(painter: DiagonalPainter())),
            // Icon and title
            const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.diamond, size: 50, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    'Gold',
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
