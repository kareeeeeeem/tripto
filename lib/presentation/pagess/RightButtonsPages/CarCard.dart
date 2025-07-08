// lib/presentation/pagess/RightButtonsPages/CarCard.dart
import 'package:flutter/material.dart';
import 'package:tripto/data/models/CarModel.dart'; // استيراد الموديل

class CarCard extends StatelessWidget {
  final Carmodel car;
  final bool isSelected; // لتحديد ما إذا كانت الكارد مختارة (زرقاء) أم لا
  final VoidCallback? onTap; // حدث عند الضغط على الكارد

  const CarCard({
    super.key,
    required this.car,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // تحديد ألوان النصوص والأيقونات بناءً على ما إذا كان الكارد مختارًا أم لا
    final textColor = isSelected ? Colors.white : Colors.black;
    final subtitleColor = isSelected ? Colors.white70 : Colors.grey[700];

    // تحويل قيمة اللون الـHex إلى اسم لون للعرض
    String displayColor;
    switch (car.colorValue) {
      case 0xFF2196F3:
        displayColor = 'Blue';
        break;
      case 0xFFD32F2F:
        displayColor = 'Red';
        break;
      case 0xFF424242:
        displayColor = 'Black';
        break;
      case 0xFF9E9E9E:
        displayColor = 'Silver';
        break;
      case 0xFF283593:
        displayColor = 'Deep Blue';
        break; // مثال من قائمتك الأصلية
      case 0xFF4CAF50:
        displayColor = 'Green';
        break; // مثال من قائمتك الأصلية
      case 0xFFBDBDBD:
        displayColor = 'Light Gray';
        break; // مثال من قائمتك الأصلية
      default:
        displayColor = 'N/A';
        break; // لو اللون مش معرف
    }

    return GestureDetector(
      // لاستقبال حدث الضغط على الكارد
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? Colors.blue[700]
                  : Colors.white, // خلفية زرقاء إذا كانت مختارة
          borderRadius: BorderRadius.circular(10), // حواف دائرية
          border:
              isSelected
                  ? null
                  : Border.all(
                    color: Colors.grey[200]!,
                    width: 1,
                  ), // border خفيف
        ),
        child: Row(
          children: [
            // عرض صورة السيارة من الموديل
            Image.asset(
              car.image,
              width: 30, // حجم الصورة
              height: 30,
              // color: isSelected ? Colors.white : null, // لو عايز تلون الصورة لما تكون مختارة
            ),
            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    car.title, // اسم العربية من الموديل
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: textColor,
                    ),
                  ),
                  Text(
                    'Year: N/A', // بما أن "year" غير موجود في الموديل
                    style: TextStyle(fontSize: 14, color: subtitleColor),
                  ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Color : $displayColor', // عرض اسم اللون
                  style: TextStyle(fontSize: 14, color: textColor),
                ),
                Row(
                  children: [
                    Text(
                      '${car.person}', // عدد الركاب من الموديل
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
