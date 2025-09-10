import 'package:flutter/material.dart';
import '../../../../../l10n/app_localizations.dart';

class DiamondCategory extends StatelessWidget {
  final bool isSelected;
  const DiamondCategory({super.key, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context)!.diamond,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.lightBlueAccent.withOpacity(0.3), // خلفية دائرية خفيفة
            border: Border.all(
              color: Colors.lightBlueAccent,
              width: 2,
            ),
            boxShadow: [
              if (isSelected)
                const BoxShadow(
                  color: Colors.blueAccent,
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
            ],
          ),
          child: const Center(
            child: Icon(
              Icons.diamond_outlined,
              size: 40,
              color: Color(0xFFE9F1F1), // لون الجوهره الأصلي
            ),
          ),
        ),
      ],
    );
  }
}
