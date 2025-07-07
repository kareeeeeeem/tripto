// lib/presentation/pagess/RightButtonsPages/CarCard.dart
import 'package:flutter/material.dart';
import 'package:tripto/data/models/CarModel.dart';

class CarCard extends StatelessWidget {
  final Carmodel car;
  final bool
  isSelected; // لتحديد ما إذا كان الكارد هو الكارد الأزرق المحدد أم لا
  final VoidCallback? onTap; // عشان لو عايز الكارد يبقى قابل للضغط

  const CarCard({
    super.key,
    required this.car,
    this.isSelected = false,
    this.onTap,
  });

  // دالة مساعدة لتحويل كائن اللون (Color object) إلى اسم نصي
  String _getColorName(Color color) {
    if (color == const Color(0xFF424242)) return 'Black'; // Black
    if (color == const Color(0xFFD32F2F)) return 'Red'; // Red
    if (color == const Color(0xFF607D8B))
      return 'Sliver'; // Blue Grey (Sliver-like)
    if (color == const Color(0xFF9E9E9E)) return 'Grey'; // Grey
    if (color == Colors.white) return 'White';
    if (color == const Color(0xFF283593))
      return 'Deep Indigo'; // Added specific color
    if (color == const Color(0xFF4CAF50))
      return 'Green'; // Added specific color
    if (color == const Color(0xFFBDBDBD))
      return 'Light Grey'; // Added specific color
    if (color == const Color(0xFF2196F3)) return 'Blue'; // Added specific color
    if (color == const Color(0xFFFFC107))
      return 'Amber'; // Added specific color
    if (color == const Color(0xFF795548))
      return 'Brown'; // Added specific color

    return 'Unknown'; // في حال لم يتم التعرف على اللون
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // GestureDetector عشان الكارد يبقى قابل للضغط
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
        elevation: isSelected ? 8 : 2, // ظل أكبر للكارد المحدد
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        // لون الكارد يعتمد على ما إذا كان محدداً (أزرق) أو غير محدد (أبيض)
        color: isSelected ? const Color(0xFF3F51B5) : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // --- أيقونة السيارة (أو صورة مصغرة) ---
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  // لون خلفية الأيقونة يعتمد على حالة التحديد
                  color:
                      isSelected
                          ? Colors.white.withOpacity(0.2)
                          : Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(
                  // استخدام Image.asset لعرض الصورة من Carmodel
                  car.image,
                  width: 30,
                  height: 30,
                  color:
                      isSelected
                          ? Colors.white
                          : Colors.grey[700], // لون الصورة
                ),
              ),
              const SizedBox(width: 16), // مسافة بين الأيقونة والتفاصيل
              // --- تفاصيل السيارة (العنوان فقط) ---
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      car.title, // اسم العربية فقط (تم إزالة year)
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color:
                            isSelected
                                ? Colors.white
                                : Colors.black, // لون النص
                      ),
                    ),
                    // لو في تفاصيل تانية عايز تحطها تحت العنوان
                    // Text('مثال لتفاصيل إضافية', style: TextStyle(color: isSelected ? Colors.white70 : Colors.grey[600])),
                  ],
                ),
              ),

              // --- تفاصيل اللون وعدد الركاب على اليمين ---
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        'Color : ',
                        style: TextStyle(
                          fontSize: 14,
                          color: isSelected ? Colors.white70 : Colors.grey[700],
                        ),
                      ),
                      Text(
                        _getColorName(
                          car.flutterColor,
                        ), // اسم اللون (Black, Red, Sliver)
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(width: 4), // مسافة صغيرة
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color:
                              car.flutterColor, // لون الدائرة هو لون السيارة الفعلي
                          shape: BoxShape.circle,
                          border: Border.all(
                            color:
                                isSelected
                                    ? Colors.white54
                                    : Colors.grey.shade400,
                            width: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4), // مسافة بين السطرين
                  Row(
                    children: [
                      Text(
                        '${car.person}', // عدد الركاب
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(width: 4), // مسافة صغيرة
                      Icon(
                        Icons.person, // أيقونة شخص
                        size: 18,
                        color:
                            isSelected
                                ? Colors.white
                                : Colors.black, // لون الأيقونة
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
