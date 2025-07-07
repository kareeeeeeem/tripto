import 'package:flutter/material.dart';

class SelectRightButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const SelectRightButton({
    super.key,
    required this.icon,
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
            // لون الخلفية يعتمد على ما إذا كان الزر محدداً أم لا
            color: isSelected ? Colors.blueAccent : Colors.transparent,
          ),
          padding: const EdgeInsets.all(8),
          child: IconButton(
            icon: Icon(icon, size: 28, color: Colors.white),
            onPressed: onPressed,
          ),
        ),
        const SizedBox(height: 1), // مسافة صغيرة بين الأيقونة والنص
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}
