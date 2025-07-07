// lib/data/models/car_model.dart
import 'package:flutter/material.dart';

/// --- تعريف كلاس Carmodel ---
/// هذا الكلاس يمثل بيانات سيارة واحدة.
class Carmodel {
  final String image;
  final String title;
  // تم حذف 'year' بناءً على التعديلات الأخيرة في الكود الذي أرسلته
  final double
  color; // يُفترض أن هذا يمثل قيمة سداسية عشرية (hex color) كرقم عشري
  final int person;

  // Constructor مع معاملات مُسماة لسهولة القراءة
  const Carmodel({
    required this.image,
    required this.title,
    required this.color,
    required this.person,
  });

  // دالة مساعدة لتحويل قيمة اللون الـ double إلى كائن Color
  Color get flutterColor {
    return Color(color.toInt());
  }

  @override
  String toString() {
    return 'Carmodel(title: $title, image: $image, color: $color, person: $person)';
  }

  // إضافة هذه الدالة للمقارنة بين كائنات Carmodel
  // ضروري لـ isSelected في CarSelectionDialog
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Carmodel &&
        other.image == image &&
        other.title == title &&
        other.color == color &&
        other.person == person;
  }

  @override
  int get hashCode {
    return Object.hash(image, title, color, person);
  }
}

// قائمة بيانات السيارات الجاهزة للاستخدام
final List<Carmodel> carsList = [
  Carmodel(
    image: 'assets/images/carphoto.png', // تأكد أن هذه المسارات صحيحة
    title: 'Honda Civic',
    color: 0xFF283593.toDouble(), // لون أزرق داكن (Deep Indigo)
    person: 5,
  ),
  Carmodel(
    image: 'assets/images/carphoto.png',
    title: 'Toyota Camry',
    color: 0xFF4CAF50.toDouble(), // لون أخضر
    person: 5,
  ),
  Carmodel(
    image: 'assets/images/carphoto.png',
    title: 'Mercedes-Benz C-Class',
    color: 0xFF9E9E9E.toDouble(), // لون رمادي
    person: 4,
  ),
  Carmodel(
    image: 'assets/images/carphoto.png',
    title: 'BMW X5',
    color: 0xFF424242.toDouble(), // لون أسود داكن
    person: 7,
  ),
  Carmodel(
    image: 'assets/images/carphoto.png',
    title: 'Audi A4',
    color: 0xFFBDBDBD.toDouble(), // لون رمادي فاتح
    person: 5,
  ),
  Carmodel(
    image: 'assets/images/carphoto.png',
    title: 'Ford Mustang',
    color: 0xFFD32F2F.toDouble(), // لون أحمر
    person: 2,
  ),
  Carmodel(
    image: 'assets/images/carphoto.png',
    title: 'Tesla Model 3',
    color: 0xFF2196F3.toDouble(), // لون أزرق
    person: 5,
  ),
  Carmodel(
    image: 'assets/images/carphoto.png',
    title: 'Nissan Altima',
    color: 0xFFFFC107.toDouble(), // لون كهرماني (Amber)
    person: 5,
  ),
  Carmodel(
    image: 'assets/images/carphoto.png',
    title: 'Hyundai Elantra',
    color: 0xFF795548.toDouble(), // لون بني
    person: 5,
  ),
  Carmodel(
    image: 'assets/images/carphoto.png',
    title: 'Kia Sportage',
    color: 0xFF607D8B.toDouble(), // لون أزرق رمادي
    person: 5,
  ),
];
