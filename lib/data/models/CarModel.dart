// carmodel.dart
import 'package:flutter/material.dart';

class Carmodel {
  final String image;
  final String title;
  final int colorValue; // استخدمنا int عشان قيم الألوان Hex
  final int person;

  const Carmodel({
    required this.image,
    required this.title,
    required this.colorValue,
    required this.person,
  });
}

final List<Carmodel> carsList = [
  const Carmodel(
    image: 'assets/images/carphoto.png', // تأكد إن المسار ده صح
    title: 'Toyota Corolla', // اسم العربية في الصورة
    colorValue: 0xFF2196F3, // ده لون أزرق قريب من اللي في الصورة
    person: 4, // عدد الركاب في الصورة
  ),
  const Carmodel(
    image: 'assets/images/carphoto.png',
    title: 'Hyundai Tucson', // اسم العربية في الصورة
    colorValue: 0xFFD32F2F, // أحمر كمثال
    person: 6,
  ),
  const Carmodel(
    image: 'assets/images/carphoto.png',
    title: 'Mercedes C180', // اسم العربية في الصورة
    colorValue: 0xFF424242, // أسود غامق كمثال
    person: 4,
  ),
  const Carmodel(
    image: 'assets/images/carphoto.png',
    title: 'GMC', // اسم العربية في الصورة
    colorValue: 0xFF9E9E9E, // رمادي كمثال
    person: 6,
  ),
  // لو عندك عربيات تانية في قائمتك الأصلية، ضيفها هنا
  // مثلاً:
  // Carmodel(
  //   image: 'assets/images/carphoto.png',
  //   title: 'Honda Civic',
  //   colorValue: 0xFF283593,
  //   person: 5,
  // ),
];
