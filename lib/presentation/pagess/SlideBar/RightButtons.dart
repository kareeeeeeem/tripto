// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tripto/core/constants/SelectRightButton.dart';
import 'package:tripto/core/models/CarModel.dart';
import 'package:tripto/presentation/pagess/SlideBar/ActivitiesCard.dart';
import 'package:tripto/presentation/pagess/SlideBar/CarCard.dart';
import 'package:tripto/presentation/pagess/SlideBar/CategoryCard.dart';
import 'package:tripto/presentation/pagess/SlideBar/DateCard.dart';
import 'package:tripto/presentation/pagess/SlideBar/HotelsCard.dart';
import 'package:tripto/presentation/pagess/SlideBar/InfoCard.dart';

import '../../../l10n/app_localizations.dart';

class _ButtonData {
  final Widget iconWidget;
  final String label;
  final VoidCallback? onPressed;

  _ButtonData({required this.iconWidget, required this.label, this.onPressed});
}

Color _getColorForCategory(CategoryType type) {
  switch (type) {
    case CategoryType.gold:
      return const Color(0xFFF1B31C);
    case CategoryType.diamond:
      return const Color(0xFF70D0E0);
    case CategoryType.platinum:
      return const Color(0xFF6A6969);
    default:
      return Colors.white;
  }
}

class RightButtons extends StatefulWidget {
  const RightButtons({super.key});

  @override
  State<RightButtons> createState() => _RightButtonsState();
}

class _RightButtonsState extends State<RightButtons> {
  int selectedIndex = -1;
  late FocusScopeNode _focusScopeNode;

  // ✅ لحفظ نوع الفئة المختارة
  CategoryType selectedCategoryType = CategoryType.none;

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
    const Color defaultIconColor = Colors.white;
    const Color selectedIconColor = Colors.blue;

    final List<_ButtonData> _buttons = [
      _ButtonData(
        iconWidget: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()..scale(-1.0, 1.0), // عكس أفقي
          child: Icon(
            Icons.diamond_outlined,
              color: selectedCategoryType == null
                  ? Colors.white
                  : (selectedIndex == 0
                  ? Colors.white
                  : _getColorForCategory(selectedCategoryType!)),
//              سب الفئة
          ),
        ),
        label: AppLocalizations.of(context)!.category,
        onPressed: () async {
          final selectedCategory = await showDialog<CategoryType>(
            context: context,
            builder: (context) => const CategoryCard(),
          );
          if (selectedCategory != null) {
            setState(() {
              selectedIndex = 0;
              selectedCategoryType = selectedCategory;
            });
          }
        },
      ),

      _ButtonData(
        iconWidget: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.calendar_today,
              size: 60,
              color: selectedIndex == 1 ? selectedIconColor : defaultIconColor,
            ),
            Text(
              DateFormat('d').format(DateTime.now()),
              style: TextStyle(
                fontSize: 10,
                color: selectedIndex == 1 ? defaultIconColor : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        label: AppLocalizations.of(context)!.date,
        onPressed: () async {
          final result = await showDialog<Map<String, DateTime?>>(
            context: context,
            builder: (context) => const Datecard(),
          );
          if (result != null) {
            final start = result['start'];
            final end = result['end'];
            if (start != null && end != null) {
              debugPrint(
                'Range: ${DateFormat('d MMM').format(start)} - ${DateFormat('d MMM').format(end)}',
              );
            } else if (start != null) {
              debugPrint('Day: ${DateFormat('d MMM').format(start)}');
            }
          }
        },
      ),
      _ButtonData(
        iconWidget: Icon(
          Icons.hotel,
          color: selectedIndex == 2 ? selectedIconColor : defaultIconColor,
        ),
        label: AppLocalizations.of(context)!.hotel,
        onPressed: () async {
          await showDialog(
            context: context,
            builder:
                (context) => Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Hotels(),
                ),
          );
        },
      ),

      _ButtonData(
        iconWidget: Icon(
          Icons.directions_car,
          color: selectedIndex == 3 ? selectedIconColor : defaultIconColor,
        ),
        label: AppLocalizations.of(context)!.car,
        onPressed: () async {
          final Carmodel? selectedCar = await showDialog(
            context: context,
            builder: (context) => const CarSelectionPage(),
          );
          if (selectedCar != null) {
            debugPrint('Selected Car: ${selectedCar.title}');
          }
        },
      ),

      _ButtonData(
        iconWidget: Icon(
          Icons.category_outlined,
          color: selectedIndex == 4 ? selectedIconColor : defaultIconColor,
        ),
        label: AppLocalizations.of(context)!.activities,
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) => const ActivitiesListDialog(), // ✅ الحل الصحيح
          );
        },
      ),

      _ButtonData(
        iconWidget: Icon(
          Icons.bookmark_border,
          color: selectedIndex == 5 ? selectedIconColor : defaultIconColor,
        ),
        label: AppLocalizations.of(context)!.save,
        onPressed: () {
          debugPrint('Save pressed');
        },
      ),

      // _ButtonData(
      //   iconWidget: Icon(
      //     Icons.share,
      //     color: selectedIndex == 6 ? selectedIconColor : defaultIconColor,
      //   ),
      //   label: 'Share',
      //   onPressed: () async {
      //     await showDialog(
      //       context: context,
      //       builder: (context) => const Share(),
      //     ); // هذا الجزء صحيح
      //     debugPrint('Share pressed'); // هذا سيعمل بعد إغلاق الـ dialog
      //   },
      // ),
      _ButtonData(
        iconWidget: Icon(
          Icons.info_outline,
          color: selectedIndex == 7 ? selectedIconColor : defaultIconColor,
        ),
        label: AppLocalizations.of(context)!.info,
        onPressed: () async {
          await showDialog(
            context: context,
            builder:
                (context) => Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const InfoCard(),
                ),
          );
        },
      ),
    ];

    const double _verticalSpacing = 2.0;

    return FocusScope(
      node: _focusScopeNode,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: List.generate(_buttons.length, (index) {
          final buttonData = _buttons[index];
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: index == 0 ? 0 : _verticalSpacing),
              child: SelectRightButton(
                iconWidget: buttonData.iconWidget,
                label: buttonData.label,
                isSelected: selectedIndex == index,
                onPressed: () {
                  _focusScopeNode.requestFocus();
                  setState(() => selectedIndex = index);
                  buttonData.onPressed?.call();
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}
