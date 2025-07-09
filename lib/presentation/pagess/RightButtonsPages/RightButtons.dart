// lib/presentation/pagess/RightButtons.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tripto/core/constants/SelectRightButton.dart';
import 'package:tripto/data/models/CarModel.dart';
import 'package:tripto/presentation/pagess/RightButtonsPages/CarSelectionDialog.dart';
import 'package:tripto/presentation/pagess/RightButtonsPages/CategoryCard.dart';
import 'package:tripto/presentation/pagess/RightButtonsPages/DateCard.dart';
import 'InfoCard.dart'; // تأكد أن هذا المسار صحيح

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
  late FocusScopeNode _focusScopeNode;

  @override
  void initState() {
    super.initState();
    _focusScopeNode = FocusScopeNode();
    _focusScopeNode.addListener(() {
      if (!_focusScopeNode.hasFocus && selectedIndex != -1) {
        setState(() {
          selectedIndex = -1;
        });
      }
    });
  }

  @override
  void dispose() {
    _focusScopeNode.dispose();
    super.dispose();
  }

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
          final result = await showDialog<Map<String, DateTime?>>(
            context: context,
            builder: (BuildContext context) {
              return const Datecard();
            },
          );
          if (result != null) {
            final DateTime? startDate = result['start'];
            final DateTime? endDate = result['end'];
            if (startDate != null && endDate != null) {
              debugPrint(
                'Selected Range: ${DateFormat('d MMM').format(startDate)} - ${DateFormat('d MMM').format(endDate)}',
              );
            } else if (startDate != null) {
              debugPrint(
                'Selected Single Day: ${DateFormat('d MMM').format(startDate)}',
              );
            }
          } else {
            debugPrint('Date selection cancelled or no date selected.');
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
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const InfoCard(),
              );
            },
          );
        },
      ),
    ];

    const double _verticalSpacing = 2.0;

    return Positioned(
      right: 12,
      bottom: 150,
      child: FocusScope(
        node: _focusScopeNode,
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
                  _focusScopeNode.requestFocus();
                  setState(() => selectedIndex = index);
                  buttonData.onPressed?.call();
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}
