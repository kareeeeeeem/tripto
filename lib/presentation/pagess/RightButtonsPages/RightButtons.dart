import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tripto/core/constants/SelectRightButton.dart';
import 'package:tripto/data/models/CarModel.dart';

import 'package:tripto/presentation/pagess/RightButtonsPages/CarSelectionDialog.dart';
import 'package:tripto/presentation/pagess/RightButtonsPages/CategoryCard.dart';
import 'package:tripto/presentation/pagess/RightButtonsPages/DateCard.dart';

<<<<<<< HEAD
=======
import '../../../data/models/info_details_model.dart';
import 'infocard.dart';

// تأكد من المسارات الصحيحة للـ CategoryCard و Datecard و SelectRightButton
// كلاس مساعد لتخزين بيانات الزر الواحد
>>>>>>> 0d239c34d2fb85929190fe07b0076ff1eae25341
class _ButtonData {
  final IconData? icon;
  final Widget? iconWidget;
  final String label;
  final VoidCallback? onPressed;

  _ButtonData({
    this.icon,
    this.iconWidget,
    required this.label,
    this.onPressed,
  });
}

class RightButtons extends StatefulWidget {
  const RightButtons({super.key});

  @override
  State<RightButtons> createState() => _RightButtonsState();
}

class _RightButtonsState extends State<RightButtons> {
  int selectedIndex = -1;

<<<<<<< HEAD
  void openbottomsheet(BuildContext context) {
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
=======

>>>>>>> 0d239c34d2fb85929190fe07b0076ff1eae25341

  @override
  Widget build(BuildContext context) {
    final List<_ButtonData> _buttons = [
      _ButtonData(
        icon: Icons.local_offer,
        label: 'Category',
        onPressed: () async {
          final selectedCategory = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return const CategoryCard();
            },
          );
          if (selectedCategory != null) {
            debugPrint('Selected Category: $selectedCategory');
          }
        },
      ),

      // ✅ الزر المعدل لأيقونة التاريخ مع الرقم الحالي
      _ButtonData(
        iconWidget: Stack(
          alignment: Alignment.center,
          children: [
            const Icon(Icons.calendar_today, size: 30, color: Colors.white),
            Text(
              DateFormat('d').format(DateTime.now()),
              style: const TextStyle(
                fontSize: 10,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        label: 'Date',
        onPressed: () async {
          final DateTime? selectedDate = await showDialog<DateTime>(
            context: context,
            builder: (BuildContext context) {
              return const Datecard();
            },
          );
          if (selectedDate != null) {
            debugPrint('Selected Date: ${selectedDate.toLocal()}');
          }
        },
      ),

      _ButtonData(
        icon: Icons.directions_car,
        label: 'Car',
        onPressed: () async {
          final Carmodel? selectedCar = await showDialog<Carmodel>(
            context: context,
            builder: (BuildContext context) {
              return const CarSelectionDialog();
            },
          );
          if (selectedCar != null) {
            debugPrint('Selected Car: ${selectedCar.title}');
          } else {
            debugPrint('Car selection cancelled or no car selected.');
          }
        },
      ),

      _ButtonData(
        icon: Icons.bookmark_border,
        label: 'Save',
        onPressed: () {
          debugPrint('Save button pressed');
        },
      ),

      _ButtonData(
        icon: Icons.share,
        label: 'Share',
        onPressed: () {
          debugPrint('Share button pressed');
        },
      ),

      _ButtonData(
        icon: Icons.info_outline,
        label: 'Info',
<<<<<<< HEAD
        onPressed: () {
=======
        onPressed: ()  {
>>>>>>> 0d239c34d2fb85929190fe07b0076ff1eae25341
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
              iconWidget: buttonData.iconWidget ?? Icon(buttonData.icon),
              label: buttonData.label,
              isSelected: selectedIndex == index,
              onPressed: () {
                setState(() => selectedIndex = index);
                buttonData.onPressed?.call();
              },
            ),
          );
        }),
      ),
    );
  }
}
