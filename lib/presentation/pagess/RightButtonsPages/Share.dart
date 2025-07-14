// lib/presentation/pagess/RightButtonsPages/Share.dart
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      clipBehavior: Clip.antiAlias,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95), // لون أبيض شبه شفاف
          borderRadius: BorderRadius.circular(16),
        ),
        width: MediaQuery.of(context).size.width * 0.9,
        // يمكنك ضبط قيود الارتفاع هنا حسب المحتوى الذي ستضعه لاحقًا
        constraints: BoxConstraints(
          maxHeight:
              MediaQuery.of(context).size.height *
              0.3, // مثلاً 50% من ارتفاع الشاشة
          minHeight:
              MediaQuery.of(context).size.height *
              0.3, // مثلاً 30% من ارتفاع الشاشة
        ),
        child: const Center(
          // هذا هو المحتوى الداخلي لمربع الحوار
          // يمكنك استبدال Placeholder بمحتوى صفحة المشاركة الفعلية
          child: Column(),
        ),
      ),
    );
  }
}
