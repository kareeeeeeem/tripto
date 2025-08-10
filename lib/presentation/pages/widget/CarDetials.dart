import 'package:flutter/material.dart';
import 'package:tripto/core/models/CarModel.dart';

import '../../../l10n/app_localizations.dart';

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
    final locale = Localizations.localeOf(context);
    final carName = locale.languageCode == 'en' ? car.carNameEn : car.carNameAr;

    final textColor = isSelected ? Colors.white : Colors.black;
    final subtitleColor = isSelected ? Colors.white70 : Colors.grey[600];
    final displayColor = car.color;

    // Format price with 2 decimals and currency symbol (تقدر تعدل العملة لو حبيت)
    final priceText = '${car.price.toStringAsFixed(2)}';

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
                    carName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: textColor,
                    ),
                  ),
                  Text(
                    '${AppLocalizations.of(context)!.year}: ${car.year ?? "N/A"}',
                    style: TextStyle(fontSize: 13, color: subtitleColor),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${AppLocalizations.of(context)!.price}: $priceText',
                    style: TextStyle(fontSize: 13, color: subtitleColor),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  AppLocalizations.of(context)!.color + ': $displayColor',
                  style: TextStyle(fontSize: 13, color: textColor),
                ),
                Row(
                  children: [
                    Text(
                      '${car.numberOfSeats}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                    Icon(Icons.person, color: textColor, size: 16),
                    SizedBox(width: 8),
                    if (car.withGuide)
                      Tooltip(
                        message: 'مرشد سياحي متوفر',
                        child: Icon(
                          Icons.person_pin,
                          color: Colors.greenAccent,
                          size: 30,
                        ),
                      ),
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
