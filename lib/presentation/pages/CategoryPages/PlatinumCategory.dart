import 'package:flutter/material.dart';
import 'package:tripto/core/constants/DiagonalPainter.dart';

import '../../../l10n/app_localizations.dart';

class PlatinumCategory extends StatelessWidget {
  final bool isSelected;
  const PlatinumCategory({super.key, this.isSelected = false});

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
            Color(0xFFE1E1E1), // Light Silver
            Color.fromARGB(255, 247, 248, 250), // Slight darker
          ],
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
          color: isSelected ? Colors.blueAccent : Colors.white70,
          width: isSelected ? 3 : 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned.fill(child: CustomPaint(painter: DiagonalPainter())),
             Positioned(
              top: 10,
              left: 10,
              child: Text(
                AppLocalizations.of(context)!.platinum,
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
                color: Color(0xFFE1E1E1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
