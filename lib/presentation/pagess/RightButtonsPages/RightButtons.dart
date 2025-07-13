import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tripto/core/constants/SelectRightButton.dart';
import 'package:tripto/core/models/CarModel.dart';
import 'package:tripto/presentation/pagess/RightButtonsPages/CarSelectionDialog.dart';
import 'package:tripto/presentation/pagess/RightButtonsPages/CategoryCard.dart';
import 'package:tripto/presentation/pagess/RightButtonsPages/DateCard.dart';
import 'package:tripto/presentation/pagess/RightButtonsPages/Hotels.dart';
import '../../../core/models/Hotels_details_model.dart';
import 'InfoCard.dart';

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
      return const Color(0xFFC0C0C0);
    default:
      return Colors.grey;
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
    final Color defaultIconColor = Colors.white;
    final Color selectedIconColor = Colors.blue;

    final List<_ButtonData> _buttons = [
      _ButtonData(
        iconWidget: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()..scale(-1.0, 1.0), // عكس أفقي
          child: Icon(
            Icons.local_offer,
            color:
                selectedIndex == 0
                    ? Colors.white
                    : _getColorForCategory(selectedCategoryType),
          ),
        ),

        label: 'Category',
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
              size: 30,
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
        label: 'Date',
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
        label: 'Hotel',
        onPressed: () async {
          await showDialog(
            context: context,
            builder:
                (context) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child:  Hotels(),
            ),
          );
        },
      ),
      _ButtonData(
        iconWidget: Icon(
          Icons.directions_car,
          color: selectedIndex == 3 ? selectedIconColor : defaultIconColor,
        ),
        label: 'Car',
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
          Icons.bookmark_border,
          color: selectedIndex == 4 ? selectedIconColor : defaultIconColor,
        ),
        label: 'Save',
        onPressed: () {
          debugPrint('Save pressed');
        },
      ),
      _ButtonData(
        iconWidget: Icon(
          Icons.share,
          color: selectedIndex == 5 ? selectedIconColor : defaultIconColor,
        ),
        label: 'Share',
        onPressed: () {
          debugPrint('Share pressed');
        },
      ),
      _ButtonData(
        iconWidget: Icon(
          Icons.info_outline,
          color: selectedIndex == 6 ? selectedIconColor : defaultIconColor,
        ),
        label: 'Info',
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
