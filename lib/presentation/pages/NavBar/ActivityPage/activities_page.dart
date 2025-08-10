import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto/bloc/%D9%90Auth/AuthBloc.dart';
import 'package:tripto/bloc/%D9%90Auth/AuthEvent.dart';
import 'package:tripto/core/models/ActivityCardModel.dart';
import 'package:tripto/core/models/activityPageModel.dart';
import 'package:tripto/presentation/app/app.dart'; // تأكد من المسار الصحيح لـ App

import '../../../../bloc/ِAuth/AuthState.dart';
import '../../../../core/constants/Colors_Fonts_Icons.dart'; // تأكد من المسار الصحيح لـ colors
import '../../../../core/routes/app_routes.dart';
import '../../../../l10n/app_localizations.dart'; // تأكد من المسار الصحيح لـ routes

class ActivityPage extends StatefulWidget {
  // تم تغيير الاسم هنا إلى ActivityPage
  // قائمة الأنشطة
  // final GetActivityModel activities;

  const ActivityPage({
    super.key,
    // required this.activities
  });

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  void initState() {
    super.initState();
    // لما الصفحة تفتح نطلب الداتا
    context.read<AuthBloc>().add(FetchAcvtivites());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.activities,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetAllActivitiesSuccess) {
            final activities = state.activities;
            return ListView.builder(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.12,
              ),
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final activity = activities[index];
                return _buildActivityCard(context, activity);
              },
            );
          } else if (state is AuthFailure) {
            return Center(child: Text("Error: ${state.error}"));
          }
          return const SizedBox();
        },
      ),
    );
  }

  // دالة مساعدة لإنشاء بطاقة النشاط الفردي
  Widget _buildActivityCard(BuildContext context, GetActivityModel activity) {
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
          color: Colors.white,
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
                      child:
                          activity.images.isNotEmpty &&
                                  activity.images[0] != null
                              ? Image.network(
                                activity.images[0],
                                fit: BoxFit.cover,
                              )
                              : Image.asset(
                                "assets/images/Logo.png",
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
                          Localizations.localeOf(context).languageCode == 'ar'
                              ? activity.activitynamear
                              : activity.activitynameen,
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
                                text:
                                    AppLocalizations.of(context)!.price + ' :',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const TextSpan(
                                text: ' \$',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: "${activity.price}",
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
                          // Text(' ⭐ ${activity.rate} '),
                          // SizedBox(
                          //   height: MediaQuery.of(context).size.height * 0.0001,
                          // ),
                          Row(
                            children:
                                Localizations.localeOf(context).languageCode ==
                                        'ar'
                                    ? [
                                      Text(
                                        " ${AppLocalizations.of(context)!.duration}" +
                                            ": ",
                                      ),
                                      Text("${activity.activityduration} "),
                                      // Text(AppLocalizations.of(context)!.min),
                                    ]
                                    : [
                                      Text(
                                        "${AppLocalizations.of(context)!.duration}" +
                                            ": ",
                                      ),
                                      Text("${activity.activityduration} "),
                                      // Text(AppLocalizations.of(context)!.min),
                                    ],
                          ),
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
                        child: Text(
                          AppLocalizations.of(context)!.book,
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
