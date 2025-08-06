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
    // تحديد أبعاد ثابتة للزر
    const double buttonSize = 80.0;
    const double iconSize = 30.0;
    const double fontSize = 12.0;

    return SizedBox(
      width: buttonSize,
      height: buttonSize,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 4.0,
          ), // تباعد ثابت بين الأزرار
          decoration: BoxDecoration(
            color: isSelected ? Colors.blueAccent : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: iconSize,
                height: iconSize,
                child: FittedBox(child: iconWidget),
              ),
              const SizedBox(height: 4.0),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
