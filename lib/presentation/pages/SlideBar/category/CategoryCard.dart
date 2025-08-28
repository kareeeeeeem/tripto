// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tripto/presentation/pages/SlideBar/category/CategoryPages/DiamondCategory.dart';
import 'package:tripto/presentation/pages/SlideBar/category/CategoryPages/CategoryGold.dart';
import 'package:tripto/presentation/pages/SlideBar/category/CategoryPages/PlatinumCategory.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../l10n/app_localizations.dart';

class CategoryCard extends StatefulWidget {
  final int initialSelectedCategory;

  const CategoryCard({super.key, this.initialSelectedCategory = -1});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

enum CategoryType { none, gold, diamond, platinum }

class _CategoryCardState extends State<CategoryCard> {
  late int _selectedCategoryIndex;

  @override
  void initState() {
    super.initState();
    // تهيئة _selectedCategoryIndex بالقيمة الأولية القادمة من RightButtons (الـ API)
    _selectedCategoryIndex = widget.initialSelectedCategory;
  }

  // ✅ تم إزالة دالة _onCategorySelected لأننا لن نسمح بالاختيار
  // لذلك لا حاجة لهذه الدالة بعد الآن.

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
                    // ✅ تم إزالة GestureDetector لمنع النقر
                    child: GoldCategory(
                      isSelected: _selectedCategoryIndex == 0,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    // ✅ تم إزالة GestureDetector لمنع النقر
                    child: DiamondCategory(
                      isSelected: _selectedCategoryIndex == 1,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    // ✅ تم إزالة GestureDetector لمنع النقر
                    child: PlatinumCategory(
                      isSelected: _selectedCategoryIndex == 2,
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
                  foregroundColor: const Color(0xFF002E70),
                  backgroundColor: const Color(0xFF002E70),
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
                    SizedBox(width: MediaQuery.of(context).size.width * 0.025),
                    Text(
                      AppLocalizations.of(context)!.customtrip,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
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
