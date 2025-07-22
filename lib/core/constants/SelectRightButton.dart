// lib/core/constants/SelectRightButton.dart

import 'package:flutter/material.dart';

class SelectRightButton extends StatelessWidget {
  final Widget iconWidget;
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const SelectRightButton({
    super.key,
    required this.iconWidget,
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueAccent : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              iconWidget,
              const SizedBox(height: 6),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16, // ✅ حجم الخط أكبر
                  fontWeight: FontWeight.w600, // ✅ أكثر وضوحًا
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
