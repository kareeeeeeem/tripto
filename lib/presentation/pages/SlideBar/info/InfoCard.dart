// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tripto/core/constants/Expanded_text.dart';
import 'package:tripto/bloc&repo/GetTrip/GetTrip_model.dart';
import '../../../../l10n/app_localizations.dart';

class InfoCard extends StatelessWidget {
  final GetTripModel trip;

  const InfoCard({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.80,
      height: MediaQuery.of(context).size.height * 0.20,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // عنوان الشركة
                Text(
                  AppLocalizations.of(context)!.tourismcompany,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 2, 4, 62),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                // بيانات الشركة
                Text(
                  isArabic
                      ? trip.companyNameAr ?? ''
                      : trip.companyNameEn ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),

                ExpandedText(
                  text:
                      isArabic
                          ? trip.companyDesAr ?? ''
                          : trip.companyDesEn ?? '',
                  maxLines: 5, // زوّد عدد السطور عشان النص يظهر كامل
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
