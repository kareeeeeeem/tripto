import 'package:flutter/material.dart';

class PaymentOptionCard extends StatelessWidget {
  final String imagePath;
  final String label;
  final String value;
  final String groupValue;
  final ValueChanged<String?> onChanged;

  const PaymentOptionCard({
    required this.imagePath,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(imagePath, width: 30),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(fontSize: 16 ,color: Colors.black)),
          const Spacer(),
          Radio<String>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
            activeColor: Color(0xFF002E70),
          ),
        ],
      ),
    );
  }
}
