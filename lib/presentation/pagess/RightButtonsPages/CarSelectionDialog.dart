// lib/presentation/pagess/RightButtonsPages/car_selection_dialog.dart
import 'package:flutter/material.dart';
import 'package:tripto/data/models/CarModel.dart';
import 'package:tripto/presentation/pagess/RightButtonsPages/CarCard.dart'; // استيراد CarCard

class CarSelectionDialog extends StatefulWidget {
  const CarSelectionDialog({super.key});

  @override
  State<CarSelectionDialog> createState() => _CarSelectionDialogState();
}

class _CarSelectionDialogState extends State<CarSelectionDialog> {
  Carmodel? _selectedCar; // لتتبع السيارة التي اختارها المستخدم داخل الـ Dialog

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white, //

      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8, // عرض 80% من
        height: MediaQuery.of(context).size.height * 0.6,
        child: ListView.builder(
          itemCount: carsList.length,
          itemBuilder: (context, index) {
            final carItem = carsList[index];
            return CarCard(
              car: carItem,
              isSelected: _selectedCar == carItem, // تحديد الكارد الأزرق
              onTap: () {
                setState(() {
                  _selectedCar = carItem; // تحديث السيارة المختارة
                });
                // يمكن إغلاق الـ dialog تلقائيا عند الاختيار هنا إذا أردت
                // Navigator.of(context).pop(_selectedCar);
              },
            );
          },
        ),
      ),
      // actions: [
      //   TextButton(
      //     onPressed: () {
      //       // عند الضغط على "Select"، نرجع السيارة المختارة
      //       Navigator.of(context).pop(_selectedCar);
      //     },
      //     child: const Text('Select'),
      //   ),
      //   TextButton(
      //     onPressed: () {
      //       // عند الإلغاء، نرجع null
      //       Navigator.of(context).pop(null);
      //     },
      //     child: const Text('Cancel'),
      //   ),
      // ],
    );
  }
}
