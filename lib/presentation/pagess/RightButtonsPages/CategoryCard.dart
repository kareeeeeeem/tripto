import 'package:flutter/material.dart';
import 'package:tripto/presentation/pagess/CategoryPages/CategoryDiamond.dart';
import 'package:tripto/presentation/pagess/CategoryPages/CategoryGold.dart';
import 'package:tripto/presentation/pagess/CategoryPages/CategoryPlatinum.dart';

// حول CategoryCard إلى StatefulWidget إذا كنت تريد تتبع الفئة المختارة داخلها
// أو لتبسيط المثال، سنجعلها تعرض كـ Dialog فقط.
class CategoryCard extends StatelessWidget {
  // لا نحتاج onClose هنا لأن Dialog سيتعامل مع الإغلاق تلقائيًا
  // أو يمكنك إرجاع قيمة عند الإغلاق.
  const CategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // شكل وحواف دائرية لمربع الحوار
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      // المحتوى الداخلي لمربع الحوار
      child: const Padding(
        padding: EdgeInsets.all(8.0), // مساحة داخلية حول المحتوى
        child: Column(
          mainAxisSize:
              MainAxisSize.min, // لجعل العمود يأخذ أقل مساحة ممكنة عموديًا
          children: [
            Row(
              mainAxisSize:
                  MainAxisSize.min, // لجعل الصف يأخذ أقل مساحة ممكنة أفقيًا
              children: [
                GoldCategory(), // افترض أن هذا يمثل فئة الذهب
                SizedBox(width: 2),
                DiamondCategory(), // افترض أن هذا يمثل فئة الماس
                SizedBox(width: 2),
                PlatinumCategory(), // افترض أن هذا يمثل فئة البلاتين
              ],
            ),
          ],
        ),
      ),
    );
  }
}
