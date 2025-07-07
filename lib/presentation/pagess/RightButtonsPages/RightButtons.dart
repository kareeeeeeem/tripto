// lib/presentation/pagess/RightButtons.dart
import 'package:flutter/material.dart';
import 'package:tripto/core/constants/SelectRightButton.dart';
import 'package:tripto/data/models/CarModel.dart';
// import 'package:tripto/data/models/info_details_model.dart'; // لم تعد بحاجة لهذا الاستيراد هنا لـ Carmodel إذا فصلتها
import 'package:tripto/presentation/pagess/RightButtonsPages/CarCard.dart';
import 'package:tripto/presentation/pagess/RightButtonsPages/CarSelectionDialog.dart';
import 'package:tripto/presentation/pagess/RightButtonsPages/CategoryCard.dart';
import 'package:tripto/presentation/pagess/RightButtonsPages/DateCard.dart';

// تأكد من المسارات الصحيحة للـ CategoryCard و Datecard و SelectRightButton
// كلاس مساعد لتخزين بيانات الزر الواحد
class _ButtonData {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed; // دالة يتم تنفيذها عند الضغط على الزر

  _ButtonData({required this.icon, required this.label, this.onPressed});
}

class RightButtons extends StatefulWidget {
  const RightButtons({super.key});

  @override
  State<RightButtons> createState() => _RightButtonsState();
}

class _RightButtonsState extends State<RightButtons> {
  int selectedIndex = -1; // لتتبع الزر المحدد، -1 يعني لا يوجد زر محدد

  // دالة مساعدة لفتح الـ bottom sheet (إذا كانت موجودة في مكان آخر)
  void openbottomsheet(BuildContext context) {
    // مثال لـ Bottom Sheet بسيط
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          color: Colors.white,
          child: const Center(
            child: Text(
              'Info Details will go here!',
              style: TextStyle(color: Colors.black),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // تعريف قائمة الأزرار مع الإجراءات الخاصة بكل زر
    final List<_ButtonData> _buttons = [
      _ButtonData(
        icon: Icons.category,
        label: 'Category',
        onPressed: () async {
          // عرض CategoryCard كـ Dialog
          final dynamic selectedCategory = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return const CategoryCard(); // استخدم CategoryCard التي تم تعديلها لتكون Dialog
            },
          );
          // هنا يمكنك التعامل مع selectedCategory إذا كنت ترجع قيمة من CategoryCard
          if (selectedCategory != null) {
            debugPrint('Selected Category: $selectedCategory');
            // يمكنك تحديث حالة في الشاشة الرئيسية بناءً على الفئة المختارة
          }
        },
      ),

      _ButtonData(
        icon: Icons.calendar_today, // أيقونة لزر التاريخ
        label: 'Date',
        onPressed: () async {
          // عرض Datecard كـ Dialog
          final DateTime? selectedDate = await showDialog<DateTime>(
            context: context,
            builder: (BuildContext context) {
              return const Datecard(); // استخدم Datecard التي تم تعديلها لتكون Dialog
            },
          );
          // هنا يمكنك التعامل مع التاريخ المحدد
          if (selectedDate != null) {
            debugPrint('Selected Date: ${selectedDate.toLocal()}');
            // يمكنك تحديث حالة في الشاشة الرئيسية بناءً على التاريخ المختار
          }
        },
      ),
      _ButtonData(
        icon: Icons.car_rental_outlined,
        label: 'car',
        onPressed: () async {
          // **التصحيح هنا:** استدعاء CarSelectionDialog
          final Carmodel? selectedCar = await showDialog<Carmodel>(
            // نحدد نوع القيمة المرتجعة
            context: context,
            builder: (BuildContext context) {
              return const CarSelectionDialog(); // <--- يتم عرض هذا الـ Dialog الآن
            },
          );
          // هنا يتم التعامل مع السيارة التي تم اختيارها بعد إغلاق الـ Dialog
          if (selectedCar != null) {
            debugPrint('Selected Car: ${selectedCar.title}');
            // يمكنك هنا تحديث أي حالة في شاشتك الرئيسية بناءً على السيارة المختارة.
          } else {
            debugPrint('Car selection cancelled or no car selected.');
          }
        },
      ),

      _ButtonData(
        icon: Icons.bookmark_border,
        label: 'Save',
        onPressed: () {
          // منطق زر الحفظ
          debugPrint('Save button pressed');
        },
      ),

      _ButtonData(
        icon: Icons.share,
        label: 'Share',
        onPressed: () {
          // منطق زر المشاركة
          debugPrint('Share button pressed');
        },
      ),

      _ButtonData(
        icon: Icons.info_outline,
        label: 'Info',
        onPressed: () async {
          openbottomsheet(context);
        },
      ),
    ];

    const double _verticalSpacing = 2.0;

    return Positioned(
      right: 12,
      bottom: 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(_buttons.length, (index) {
          final buttonData = _buttons[index];
          return Padding(
            padding: EdgeInsets.only(top: index == 0 ? 0 : _verticalSpacing),
            child: SelectRightButton(
              // هنا بنستخدم الـ Widget اللي انت عاملها
              icon: buttonData.icon,
              label: buttonData.label,
              isSelected: selectedIndex == index,
              onPressed: () {
                setState(() => selectedIndex = index); // تحديث الزر المحدد
                buttonData.onPressed?.call(); // تنفيذ الدالة الخاصة بالزر
              },
            ),
          );
        }),
      ),
    );
  }
}
