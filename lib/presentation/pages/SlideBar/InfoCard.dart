// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tripto/core/constants/Expanded_text.dart';
import 'package:tripto/core/constants/Colors_Fonts_Icons.dart';
import 'package:tripto/core/models/info_details_model.dart';
import 'package:tripto/bloc/GetTrip/GetTrip_model.dart';
import '../../../core/routes/app_routes.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../l10n/app_localizations.dart';

class InfoCard extends StatelessWidget {
  final GetTripModel trip;

  const InfoCard({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.80,
      height: MediaQuery.of(context).size.height * 0.20,
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // شركة الرحلات
                      Text(
                        AppLocalizations.of(context)!.tourismcompany,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              "assets/images/tourism.png",
                              width: 100,
                              height: 50,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isArabic
                                      ? trip.companyNameAr ?? ''
                                      : trip.companyNameEn ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                ExpandedText(
                                  text:
                                      isArabic
                                          ? trip.companyDesAr ?? ''
                                          : trip.companyDesEn ?? '',
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // const SizedBox(height: 16),

                      /*
                      // باقي الأقسام معلقين مؤقتًا

                      Text(
                        AppLocalizations.of(context)!.flyingcompany,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/egyptair.png",
                            width: 100,
                            height: 50,
                            fit: BoxFit.fill,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "EgyptAir",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                ExpandedText(
                                  text: "Flight provided by EgyptAir.",
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const Divider(thickness: 1, color: Colors.grey),
                      const SizedBox(height: 16),

                      Text(
                        AppLocalizations.of(context)!.reserveacar,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/kia.png",
                            width: 100,
                            height: 50,
                            fit: BoxFit.fill,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Kia Rental",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                ExpandedText(
                                  text: "Car reservation service available.",
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const Divider(thickness: 1, color: Colors.grey),
                      const SizedBox(height: 16),

                      Text(
                        AppLocalizations.of(context)!.bookinghotel,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/hilton.png",
                            width: 100,
                            height: 50,
                            fit: BoxFit.fill,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Hilton Hotel",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                ExpandedText(
                                  text: "Hotel booking service available.",
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      */
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
