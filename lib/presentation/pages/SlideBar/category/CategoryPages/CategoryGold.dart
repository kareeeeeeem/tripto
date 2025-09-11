import 'package:flutter/material.dart';
import '../../../../../l10n/app_localizations.dart';

class GoldCategory extends StatelessWidget {
  final bool isSelected;
  const GoldCategory({super.key, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context)!.gold,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.yellow.shade600.withOpacity(0.3), // خلفية دائرية خفيفة
            border: Border.all(
              color: Colors.yellow.shade600,
              width: 2,
            ),
            boxShadow: [
              if (isSelected)
                const BoxShadow(
                  color: Colors.white,
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
            ],
          ),
          child: const Center(
            child: Icon(
              Icons.diamond_outlined,
              size: 40,
              color: Colors.yellow,
            ),
          ),
        ),
      ],
    );
  }
}
