import 'package:flutter/material.dart';
import 'package:tripto/core/constants/DiagonalPainter.dart';

class DiamondCategory extends StatelessWidget {
  const DiamondCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFE9F1F1), // Diamond Light Blue
            Color(0x55BAE0EB),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.cyanAccent, width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // ✅ الجزء العلوي بلون قوي
            Positioned.fill(child: CustomPaint(painter: DiagonalPainter())),

            // ✅ نص Diamond داخل الجزء العلوي الملون
            const Positioned(
              top: 10,
              left: 10,
              child: Text(
                'Dimond',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),

            // ✅ أيقونة في الوسط
            const Center(
              child: Icon(
                Icons.diamond_outlined,
                size: 50,
                color: Color(0xFFE9F1F1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
