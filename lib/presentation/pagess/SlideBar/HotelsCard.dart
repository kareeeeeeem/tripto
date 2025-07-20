// ignore_for_file: file_names, prefer_const_constructors
import 'package:flutter/material.dart';
import '../../../core/models/Hotels_details_model.dart';
import '../../../l10n/app_localizations.dart';
import 'CarCard.dart';

class Hotels extends StatefulWidget {
  const Hotels({super.key});

  @override
  State<Hotels> createState() => _HotelsState();
}

class _HotelsState extends State<Hotels> {
  int? selectedHotelIndex;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),

                child: SingleChildScrollView(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(4, (index) {
                        // final hotel = bookinghotels[index];
                        // final isSelected = selectedHotelIndex == index;
                        final hotel = bookinghotels[0]; // نفس العنصر 4 مرات
                        final isSelected = selectedHotelIndex == index;
                        return KeyedSubtree(
                          key: ValueKey(index),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedHotelIndex = index;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        isSelected
                                            ? Colors.blue[50]
                                            : Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color:
                                          isSelected
                                              ? Colors.blue
                                              : Colors.grey.shade300,
                                      width: isSelected ? 2 : 1,
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          hotel.image,
                                          width: 100,
                                          height: 50,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              hotel.title,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            const Text(
                                              "This is the description of the company. This is the description of the company This is the description of the company",
                                            ),
                                            const SizedBox(height: 8),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Text(
                                                "${AppLocalizations.of(context)!.price}: \$150",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(thickness: 1, color: Colors.grey),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.02, // 2% من الارتفاع
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                        // width: MediaQuery.of(context).size.width * 0.20,   // 110 من عرض 390 تقريبًا
                        height: MediaQuery.of(context).size.height * 0.055, // 46 من ارتفاع 800 تقريبًا

                        child: ElevatedButton(
                          onPressed:
                              selectedHotelIndex != null
                                  ? () {
                                    //  final selectedHotel = bookinghotels[selectedHotelIndex!];
                                    final selectedHotel = bookinghotels[0];
                                    Navigator.pop(context);
                                    showDialog(
                                      context: context,
                                      builder:
                                          (BuildContext context) =>
                                              const CarSelectionPage(),
                                    );
                                  }
                                  : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(
                              0xFF002E70,
                            ), // ✅ اللون الموحد
                            foregroundColor: Colors.white,
                          //   minimumSize: Size(
                          //   MediaQuery.of(context).size.width * 0.7,
                          //   45,
                          // ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child:  Text(
                            AppLocalizations.of(context)!.selectacar,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
