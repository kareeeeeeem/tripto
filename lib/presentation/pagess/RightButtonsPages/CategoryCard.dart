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
      child: Padding(
        padding: const EdgeInsets.all(16.0), // مساحة داخلية حول المحتوى
        child: Column(
          mainAxisSize:
              MainAxisSize.min, // لجعل العمود يأخذ أقل مساحة ممكنة عموديًا
          children: [
            const Row(
              mainAxisSize:
                  MainAxisSize.min, // لجعل الصف يأخذ أقل مساحة ممكنة أفقيًا
              children: [
                // هنا لديك عناصر الفئات.
                // ستحتاج إلى جعلها قابلة للنقر وتمرير الفئة المختارة عند النقر.
                // في هذا المثال، نفترض أنها مجرد نصوص.
                // لاحقًا يمكنك جعلها أزرارًا أو بطاقات حقيقية.
                GoldCategory(), // افترض أن هذا يمثل فئة الذهب
                SizedBox(width: 4),
                DiamondCategory(), // افترض أن هذا يمثل فئة الماس
                SizedBox(width: 4),
                PlatinumCategory(), // افترض أن هذا يمثل فئة البلاتين
              ],
            ),
            const SizedBox(height: 20), // مسافة فاصلة بين الصف والزر
            ElevatedButton(
              onPressed: () {
                // عند الضغط على زر التأكيد، نقوم بإغلاق مربع الحوار.
                // يمكنك هنا تمرير الفئة التي تم اختيارها (إذا كان هناك نظام اختيار).
                Navigator.of(context).pop();
              },
              child: const Text('ok'), // زر التأكيد
            ),
          ],
        ),
      ),
    );
  }
}
