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
    _selectedCategoryIndex = widget.initialSelectedCategory;
  }

  // 💡 الويدجت الجذري (الـ Root Widget) تم تغييره من Dialog إلى Padding
  // وتمت إزالة Transform.translate
  @override
  Widget build(BuildContext context) {
    // تحديد عرض أقصى للحاوية على الويب لجعلها تبدو منظمة في الوسط (مثل 500 بكسل)
    final double maxWidth = MediaQuery.of(context).size.width > 600 ? 500.0 : double.infinity;

    return Center(
      // تحديد عرض أقصى لـ Column على الويب
      child: SizedBox(
        width: maxWidth,
        child: Padding(
          // يمكنك تعديل الهوامش الجانبية لتكون متجاوبة (مثلاً 16.0)
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
          child: Column(
            // يجب أن يكون mainAxisSize.min إذا كان سيتم وضعه داخل Center أو Column
            mainAxisSize: MainAxisSize.min,
            children: [
              // 1. بطاقات الفئات (Gold, Diamond, Platinum)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GoldCategory(
                      isSelected: _selectedCategoryIndex == 0,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DiamondCategory(
                      isSelected: _selectedCategoryIndex == 1,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: PlatinumCategory(
                      isSelected: _selectedCategoryIndex == 2,
                    ),
                  ),
                ],
              ),
              
              // 2. تباعد ثابت بدلاً من استخدام نسبة مئوية من ارتفاع الشاشة
              const SizedBox(height: 20), 
              
              // 3. زر Custom Trip
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
                  // 💡 يجب إزالة foregroundColor وتحديد color في TextStyle
                  backgroundColor: const Color(0xFF002E70), 
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  // تحديد ارتفاع الزر بشكل ثابت
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0), 
                  elevation: 0,
                  minimumSize: const Size(double.infinity, 50), // لضمان أخذ أقصى عرض متاح
                ),
                child: Center( // 💡 Center لتوسيط المحتوى
  child: ConstrainedBox( // 💡 ConstrainedBox لتحديد أقصى عرض (200 بكسل)
    constraints: const BoxConstraints(
      maxWidth: 200, 
    ),
    child: Text( // 💡 الـ Widget النصي الفعلي
      AppLocalizations.of(context)!.customtrip,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
),
              ),
            ],
          ),
        ),
      ),
    );
  }
}