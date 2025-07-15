import 'package:flutter/material.dart';
import 'package:tripto/core/models/CarModel.dart';
import 'package:tripto/presentation/pagess/SlideBar/InfoCard.dart';

const Map<int, String> colorNames = {
  0xFF2196F3: 'Blue',
  0xFFD32F2F: 'Red',
  0xFF424242: 'Black',
  0xFF9E9E9E: 'Silver',
};

class CarCard extends StatelessWidget {
  final Carmodel car;
  final bool isSelected;
  final VoidCallback? onTap;

  const CarCard({
    super.key,
    required this.car,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = isSelected ? Colors.white : Colors.black;
    final subtitleColor = isSelected ? Colors.white70 : Colors.grey[600];
    final displayColor = colorNames[car.colorValue] ?? 'N/A';

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[700] : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: isSelected ? null : Border.all(color: Colors.grey.shade300),
          boxShadow:
              isSelected
                  ? [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                  : [],
        ),
        child: Row(
          children: [
            Icon(Icons.directions_car, size: 30, color: textColor),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    car.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: textColor,
                    ),
                  ),
                  Text(
                    'Year: ${car.year ?? "N/A"}',
                    style: TextStyle(fontSize: 13, color: subtitleColor),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Color: $displayColor',
                  style: TextStyle(fontSize: 13, color: textColor),
                ),
                Row(
                  children: [
                    Text(
                      '${car.person}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                    Icon(Icons.person, color: textColor, size: 16),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
