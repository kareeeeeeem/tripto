// lib/presentation/pagess/RightButtonsPages/CarSelectionPage.dart
import 'package:flutter/material.dart';
import 'package:tripto/data/models/CarModel.dart';
import 'package:tripto/presentation/pagess/RightButtonsPages/CarCard.dart';

class CarSelectionPage extends StatefulWidget {
  const CarSelectionPage({super.key});

  @override
  State<CarSelectionPage> createState() => _CarSelectionPageState();
}

class _CarSelectionPageState extends State<CarSelectionPage> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // إضافة شكل (shape) للحوار لجعل حوافه دائرية.
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      // clipBehavior: Clip.antiAlias يضمن أن المحتوى داخل الـ Dialog يتبع نفس حدود الشكل الدائري.
      clipBehavior: Clip.antiAlias,
      // نستخدم Container لتحديد أبعاد الـ Dialog.
      child: Container(
        // عرض الـ Dialog سيكون 90% من عرض الشاشة.
        width: MediaQuery.of(context).size.width * 0.9,
        // BoxConstraints لتحديد الحد الأقصى والحد الأدنى لارتفاع الـ Dialog.
        constraints: BoxConstraints(
          // الحد الأقصى لارتفاع الـ Dialog هو 70% من ارتفاع الشاشة.
          maxHeight: MediaQuery.of(context).size.height * 0.7,
          // الحد الأدنى لارتفاع الـ Dialog (اختياري، يضمن ألا يكون صغيراً جداً).
          minHeight: MediaQuery.of(context).size.height * 0.4,
        ),
        // داخل الـ Container، نضع الـ Scaffold.
        child: Scaffold(
          // نجعل خلفية الـ Scaffold شفافة لنرى شكل الـ Dialog الدائري وخلفيته.
          backgroundColor: Colors.transparent,
          body: Column(
            // MainAxisSize.min يجعل الـ Column يأخذ أقل مساحة ممكنة عمودياً.
            mainAxisSize: MainAxisSize.min, // هذا مهم جداً
            children: [
              Expanded(
                // ListView.builder يعرض قائمة السيارات.
                // shrinkWrap: true مهم جداً لكي يعمل ListView بشكل صحيح داخل Column بـ mainAxisSize.min.
                child: ListView.builder(
                  shrinkWrap: true, // هذا مهم جداً
                  itemCount: carsList.length,
                  itemBuilder: (context, index) {
                    final car = carsList[index];
                    final isSelected = selectedIndex == index;

                    return CarCard(
                      car: car,
                      isSelected: isSelected,
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
