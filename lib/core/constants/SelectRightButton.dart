import 'package:flutter/material.dart';

class SelectRightButton extends StatelessWidget {
  final Widget iconWidget; // تم تغييره من IconData إلى Widget
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
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? Colors.blueAccent : Colors.transparent,
          ),
          padding: const EdgeInsets.all(6),
          child: IconButton(
            icon: iconWidget, // 👈 استخدام الودجت المخصص بدل Icon(icon)
            iconSize: 28,
            onPressed: onPressed,
          ),
        ),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}
