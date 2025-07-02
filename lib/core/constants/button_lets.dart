import 'package:flutter/material.dart';

class ConstButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;

  const ConstButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,   // يمكن تحديده من الخارج
    this.height,  // يمكن تحديده من الخارج
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8), // خفف الزوايا ليكون أقرب للمستطيل
      child: Container(
        width: width ?? 333, // ← العرض الكامل أو قيمة مخصصة
        height: height ?? 50,            // ← ارتفاع افتراضي لو مش محدد
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF2196F3),
              Color(0xFF42A5F5),
              Color(0xFF00BCD4),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(0),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
            letterSpacing: 1.1,
          ),
        ),
      ),
    );
  }
}
