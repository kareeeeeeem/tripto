// lib/presentation/pagess/RightButtonsPages/CarCard.dart
import 'package:flutter/material.dart';
import 'package:tripto/data/models/CarModel.dart';

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
    final subtitleColor = isSelected ? Colors.white70 : Colors.grey[700];
    final displayColor = colorNames[car.colorValue] ?? 'N/A';

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[700] : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border:
              isSelected
                  ? null
                  : Border.all(color: Colors.grey[200]!, width: 1),
          boxShadow:
              isSelected
                  ? [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                  : [],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                car.image,
                width: 45,
                height: 45,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    car.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: textColor,
                    ),
                  ),
                  Text(
                    'Year: ${car.year ?? "N/A"}',
                    style: TextStyle(fontSize: 14, color: subtitleColor),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Color: $displayColor',
                  style: TextStyle(fontSize: 14, color: textColor),
                ),
                Row(
                  children: [
                    Text(
                      '${car.person}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    Icon(Icons.person, color: textColor, size: 18),
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
