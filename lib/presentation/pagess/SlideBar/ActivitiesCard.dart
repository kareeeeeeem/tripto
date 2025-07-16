import 'package:flutter/material.dart';
import 'package:tripto/core/models/activityPageModel.dart';

// تأكد من المسارات الصحيحة لـ AppRoutes
import '../../../../core/routes/app_routes.dart';

class ActivityCard extends StatelessWidget {
  // تم تغيير الاسم إلى ActivityCard
  final Activitymodel activity; // Activitymodel الآن هي معلمة مطلوبة

  const ActivityCard({required this.activity, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          // عند النقر، يتم الانتقال إلى صفحة تفاصيل النشاط
          Navigator.pushNamed(
            context,
            AppRoutes.activityDetailsPageRoute,
            arguments: activity,
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: SizedBox(
            height: 136,
            width:
                double.infinity, // استخدام double.infinity ليأخذ العرض المتاح
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // الصورة
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: double.infinity,
                      width: 100,
                      child: Image.asset(
                        "assets/images/museum.png", // استخدام صورة المتحف
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 25), // زيادة المسافة لتناسب المحتوى
                  // تفاصيل النشاط (العنوان فقط)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          activity.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2, // لضمان عدم تجاوز السطرين
                          overflow:
                              TextOverflow
                                  .ellipsis, // لإضافة ... إذا كان النص طويلاً
                        ),
                        const SizedBox(height: 6),
                        // تم إزالة عرض السعر هنا
                      ],
                    ),
                  ),

                  // التقييم فقط
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end, // محاذاة لليمين
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(' ⭐ ${activity.rate} '), // عرض التقييم
                          // تم إزالة عرض المدة وصورة السيارة هنا
                        ],
                      ),
                      // تم إزالة زر الحجز هنا
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ActivitiesListDialog extends StatelessWidget {
  const ActivitiesListDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        height: 600,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'activities',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(6),
                itemCount: exmactivities.length,
                itemBuilder: (context, index) {
                  return ActivityCard(activity: exmactivities[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
