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
        // يمكنك تحديد عرض ثابت هنا إذا كنت ترغب في تثبيت عرض الأزرار،
        // وإلا فسيأخذ العرض المتاح له من الأب.
        // مثال: width: 60,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueAccent : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        // **هنا بنضيف FittedBox لحل مشكلة التجاوز**
        child: FittedBox(
          fit: BoxFit.scaleDown, // بيصغر المحتوى لو أكبر من اللازم
          alignment: Alignment.center, // بيخلي المحتوى في المنتصف
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // بيوسّط الأيقونة والنص عموديًا
            mainAxisSize:
                MainAxisSize
                    .min, // بيخلي الـ Column ياخد أقل مساحة ممكنة لمحتواه
            children: [
              iconWidget,
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(
                  // استخدم const مع TextStyle إذا كانت القيم ثابتة
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center, // وسّط النص أفقيًا
              ),
            ],
          ),
        ),
      ),
    );
  }
}
