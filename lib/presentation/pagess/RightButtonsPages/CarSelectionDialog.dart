import 'package:flutter/material.dart';
import 'package:tripto/core/models/CarModel.dart';
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
    // حساب أقصى عدد للعرض بدون Scroll — مثلاً 4 كروت × ارتفاع الكارت = تقريبي
    const double itemHeight = 85; // تقريبي لكل CarCard
    final int maxVisibleItems = 4;
    final double maxHeight =
        (carsList.length > maxVisibleItems)
            ? itemHeight * maxVisibleItems
            : itemHeight * carsList.length;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      clipBehavior: Clip.antiAlias,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(16),
        ),
        width: MediaQuery.of(context).size.width * 0.9,
        constraints: BoxConstraints(
          maxHeight: maxHeight + 30, // + بعض الفراغ فوق/تحت
          minHeight: itemHeight * 2,
        ),
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10),
          shrinkWrap: true,
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
    );
  }
}
