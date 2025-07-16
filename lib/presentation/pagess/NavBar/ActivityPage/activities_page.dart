import 'package:flutter/material.dart';
import 'package:tripto/core/models/activityPageModel.dart';
import 'package:tripto/presentation/app/app.dart'; // تأكد من المسار الصحيح لـ App

import '../../../../core/constants/colors.dart'; // تأكد من المسار الصحيح لـ colors
import '../../../../core/routes/app_routes.dart'; // تأكد من المسار الصحيح لـ routes

class ActivityPage extends StatelessWidget {
  // تم تغيير الاسم هنا إلى ActivityPage
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Activities",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            // العودة إلى App وإزالة جميع المسارات السابقة
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const App()),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(
          bottom:
              MediaQuery.of(context).size.height *
              0.12, // تقريبًا 12% من الشاشة
        ),
        itemCount: exmactivities.length,
        itemBuilder: (context, index) {
          final activity = exmactivities[index];
          // استدعاء الويدجت الفرعي الذي يعرض تفاصيل النشاط
          return _buildActivityCard(context, activity);
        },
      ),
    );
  }

  // دالة مساعدة لإنشاء بطاقة النشاط الفردي
  Widget _buildActivityCard(BuildContext context, Activitymodel activity) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
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
                        "assets/images/museum.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 25), // زيادة المسافة لتناسب المحتوى
                  // تفاصيل النشاط (العنوان والسعر)
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
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Price: ',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const TextSpan(
                                text: '\$',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: '${activity.price.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // التقييم، المدة، والأيقونة، وزر الحجز
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end, // محاذاة لليمين
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(' ⭐ ${activity.rate} '),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.0001,
                          ),
                          Text('For: ${activity.duration} min'),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.001,
                          ),
                          const Icon(
                            Icons.directions_car_filled_sharp,
                            size: 20,
                          ),
                        ],
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(110, 37),
                          backgroundColor: btn_background_color_gradiant,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.paymentOption);
                        },
                        child: const Text(
                          'Book',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
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
