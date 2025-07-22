// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tripto/presentation/pagess/CategoryPages/DiamondCategory.dart';
import 'package:tripto/presentation/pagess/CategoryPages/CategoryGold.dart';
import 'package:tripto/presentation/pagess/CategoryPages/PlatinumCategory.dart';
import 'package:tripto/presentation/pagess/SlideBar/DateCard.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../l10n/app_localizations.dart';

class CategoryCard extends StatefulWidget {
  const CategoryCard({super.key});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

enum CategoryType { none, gold, diamond, platinum }

class _CategoryCardState extends State<CategoryCard> {
  int _selectIndex = -1;

  void _onCategorySelected(int index) async {
    setState(() {
      _selectIndex = index;
    });

    CategoryType selectedType = CategoryType.none;

    if (index == 0) {
      selectedType = CategoryType.gold;
    } else if (index == 1) {
      selectedType = CategoryType.diamond;
    } else if (index == 2) {
      selectedType = CategoryType.platinum;
    }

    // ✅ Pop with selected value then await DateCard
    Future.delayed(const Duration(milliseconds: 150), () async {
      Navigator.pop<CategoryType>(context, selectedType); // Pop value
      await showDialog(
        context: context,
        builder: (BuildContext context) => const Datecard(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isRTL = Directionality.of(context) == TextDirection.rtl;

    return Transform.translate(
      offset: Offset(isRTL ? 30 : -30, 0),
      child: Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.023),
              ElevatedButton(
                onPressed: () async {
                  const phoneNumber = '201028476944';
                  final message = Uri.encodeComponent(
                    AppLocalizations.of(context)!.customTripMessage,
                  );
                  final url = 'https://wa.me/$phoneNumber?text=$message';

                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(
                      Uri.parse(url),
                      mode: LaunchMode.externalApplication,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          AppLocalizations.of(context)!.cannotOpenWhatsapp,
                        ),
                      ),
                    );
                  }
                },

                style: ElevatedButton.styleFrom(
                  foregroundColor: Color(0xFF002E70),
                  backgroundColor: Color(0xFF002E70),
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.zero,
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Image.asset(
                    //   'assets/images/whatsapp.png',
                    //   width: 30, // ✅ حجم الصورة
                    //   height: 30,
                    //   fit: BoxFit.contain,
                    // ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.025,
                    ), // ✅ مسافة متجاوبة
                    Text(
                      AppLocalizations.of(context)!.customtrip,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20, // ✅ حجم الخط
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
