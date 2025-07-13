import 'package:flutter/material.dart';
import 'package:tripto/presentation/pagess/CategoryPages/DiamondCategory.dart';
import 'package:tripto/presentation/pagess/CategoryPages/CategoryGold.dart';
import 'package:tripto/presentation/pagess/CategoryPages/PlatinumCategory.dart';
import 'package:tripto/presentation/pagess/RightButtonsPages/DateCard.dart';

class CategoryCard extends StatefulWidget {
  const CategoryCard({super.key});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  int _selectIndex = -1;

  void _onCategorySelected(int index) {
    setState(() {
      _selectIndex = index;
    });
    Future.delayed(const Duration(milliseconds: 150), () {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (BuildContext context) => const Datecard(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(-30, 0),
      child: Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: SizedBox(
            height: 200,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _onCategorySelected(0),
                    child: GoldCategory(isSelected: _selectIndex == 0),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _onCategorySelected(1),
                    child: DiamondCategory(isSelected: _selectIndex == 1),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _onCategorySelected(2),
                    child: PlatinumCategory(isSelected: _selectIndex == 2),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
