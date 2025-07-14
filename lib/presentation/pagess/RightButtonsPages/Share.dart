import 'package:flutter/material.dart';

class Share extends StatefulWidget {
  const Share({super.key});

  @override
  State<Share> createState() => _ShareState();
}

class _ShareState extends State<Share> {
  @override
  Widget build(BuildContext context) {
    // استخدم Dialog لعرض مربع حوار عائم
    return Dialog(
      // شكل مربع الحوار بحواف دائرية
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      // يسمح بقص المحتوى الزائد إذا خرج عن الحواف الدائرية
      clipBehavior: Clip.antiAlias,
      // خلفية شفافة لتظهر الخلفية الأصلية للصفحة
      backgroundColor: Colors.transparent,
      child: Container(
        // زخرفة الحاوية الداخلية (اللون والخلفية الدائرية)
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95), // لون أبيض شبه شفاف
          borderRadius: BorderRadius.circular(16),
        ),
        // عرض مربع الحوار (90% من عرض الشاشة)
        width: MediaQuery.of(context).size.width * 0.9,
        // قيود الارتفاع: يمكنك ضبطها حسب الحاجة
        // هنا يمكنك وضع أي قيود تريدها لمربع الحوار الخاص بك
        // على سبيل المثال، ارتفاع ثابت أو ارتفاع نسبي
        constraints: BoxConstraints(
          maxHeight:
              MediaQuery.of(context).size.height *
              0.5, // مثلاً 50% من ارتفاع الشاشة
          minHeight:
              MediaQuery.of(context).size.height *
              0.3, // مثلاً 30% من ارتفاع الشاشة
        ),
        // هنا ستضع المحتوى الخاص بك
        child: const Center(
          // يمكنك استبدال Placeholder بمحتواك الفعلي
          child: Placeholder(
            color: Colors.grey, // لون افتراضي للمربع الفارغ
          ),
        ),
      ),
    );
  }
}
