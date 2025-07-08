import 'package:flutter/material.dart';
import 'package:tripto/core/constants/DiagonalPainter.dart';

class PlatinumCategory extends StatelessWidget {
  const PlatinumCategory({super.key});

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
            Color(0xFFDADADA0), // Platinum Silver-ish
            Color(0x55C2C3C7),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.white70, width: 2),
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
                'Platinum',
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
                color: Color(0xFFDADADA0), // ✅ صحيح
              ),
            ),
          ],
        ),
      ),
    );
  }
}
