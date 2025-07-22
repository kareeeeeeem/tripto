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
              // const SizedBox(height: ),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 20, // الحجم اللي إنت عايزه
                  fontWeight: FontWeight.w700, // الوزن اللي إنت عايزه
                  color: Colors.white, // اللون اللي انت عايزه
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
