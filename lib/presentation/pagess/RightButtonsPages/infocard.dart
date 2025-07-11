// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tripto/core/constants/Expanded_text.dart';
import 'package:tripto/core/constants/colors.dart';
import 'package:tripto/core/models/info_details_model.dart';
import '../../../core/routes/app_routes.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Tourism Company",
                        style: TextStyle(
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
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      tourismcompanies[0].title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const Text(' ⭐ 4.9'),
                                  ],
                                ),
                                const ExpandedText(
                                  text:
                                      "This is the description of the company.This is the description of the companyThis is the description of the company",
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(thickness: 1, color: Colors.grey),
                      const SizedBox(height: 16),
                      const Text(
                        "Flying Company",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              "assets/images/egyptair.png",
                              width: 100,
                              height: 50,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  flyingcompanies[0].title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                // Text(
                                //   "This is the description of the company.This is the description of the companyThis is the description of the company",
                                //   style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                                //   maxLines: 2,
                                //   overflow: TextOverflow.ellipsis,
                                // ),
                                const ExpandedText(
                                  text:
                                      "This is the description of the company.This is the description of the companyThis is the description of the company",
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(thickness: 1, color: Colors.grey),
                      const SizedBox(height: 16),
                      const Text(
                        "Reserve a Car",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              "assets/images/kia.png",
                              width: 100,
                              height: 50,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  reservecars[0].title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const ExpandedText(
                                  text:
                                      "This is the description of the company.This is the description of the companyThis is the description of the company",
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(thickness: 1, color: Colors.grey),
                      const SizedBox(height: 16),
                      const Text(
                        "Booking Hotels",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              "assets/images/hilton.png",
                              width: 100,
                              height: 50,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  bookinghotels[0].title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const ExpandedText(
                                  text:
                                      "This is the description of the company.This is the description of the companyThis is the description of the company",
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),

            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 110,
                      height: 46,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.paymentOption);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: const Color(0xFF002E70),
                        ),
                        child: const Text(
                          "Next",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 139,
                      height: 46,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: btn_background_color_gradiant,
                        ),
                        child: Text(
                          "Custom Trip",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          // style: TextStyle
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
