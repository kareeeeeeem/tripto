import 'package:flutter/material.dart';
import 'package:tripto/core/models/CarModel.dart';
import 'package:tripto/presentation/pages/widget/CarDetials.dart';
import 'package:tripto/presentation/pages/SlideBar/ActivitiesCard.dart';

import '../../../l10n/app_localizations.dart'; // مهم فيه ActivityCard و openActivitiesCard

class CarSelectionPage extends StatefulWidget {
  final List<VoidCallback> nextSteps;
  final bool hasActivity; // أضف هذه الخاصية

  const CarSelectionPage({
    super.key,
    this.nextSteps = const [],
    required this.hasActivity, // اجعلها مطلوبة
  });

  @override
  State<CarSelectionPage> createState() => _CarSelectionPageState();
}

class _CarSelectionPageState extends State<CarSelectionPage> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    const double itemHeight = 85;
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
          maxHeight: maxHeight + 80,
          minHeight: itemHeight * 2,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed:
                    selectedIndex != null
                        ? () async {
                          Navigator.of(context).pop(carsList[selectedIndex!]);

                          // افتح صفحة الأنشطة فقط إذا كانت متوفرة
                          if (widget.hasActivity) {
                            await showDialog(
                              context: context,
                              builder:
                                  (context) => const ActivitiesListDialog(),
                            );
                          }

                          // تشغيل nextSteps سواء كانت هناك أنشطة أم لا
                          Future.delayed(const Duration(milliseconds: 100), () {
                            if (widget.nextSteps.isNotEmpty) {
                              widget.nextSteps.first();
                            }
                          });
                        }
                        : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF002E70),
                  foregroundColor: Colors.white,
                  minimumSize: Size(
                    MediaQuery.of(context).size.width * 0.7,
                    45,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
