import 'package:flutter/material.dart';
import 'package:tripto/core/constants/DiagonalPainter.dart';

class GoldCategory extends StatelessWidget {
  final bool isSelected;
  const GoldCategory({super.key, this.isSelected = false});

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
          colors: [Color(0xFFF1B31C), Color(0xFFCCA66B)],
        ),
        boxShadow: [
          if (isSelected)
            const BoxShadow(
              color: Colors.blueAccent,
              blurRadius: 10,
              spreadRadius: 2,
            ),
        ],
        border: Border.all(
          color: isSelected ? Colors.blueAccent : Colors.amber,
          width: isSelected ? 3 : 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned.fill(child: CustomPaint(painter: DiagonalPainter())),
            const Positioned(
              top: 10,
              left: 10,
              child: Text(
                'Gold',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const Center(
              child: Icon(
                Icons.diamond_outlined,
                size: 50,
                color: Color(0xFFF1B31C),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
