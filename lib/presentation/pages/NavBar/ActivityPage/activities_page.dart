import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto/bloc/%D9%90Auth/AuthBloc.dart';
import 'package:tripto/bloc/%D9%90Auth/AuthEvent.dart';
import 'package:tripto/core/constants/videoplayer_widget.dart';
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
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF002E70)),
            );
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

  Widget buildMediaWidget(String videoUrl, List<String> images) {
    // حالة الفيديو
    if (videoUrl.isNotEmpty) {
      final videoExtension = videoUrl.split('.').last.toLowerCase();
      final videoExtensions = ['mp4', 'mov', 'avi', 'webm'];
      if (videoExtensions.contains(videoExtension)) {
        return SizedBox(
          height:
              MediaQuery.of(context).size.height * 0.13, // 13% من ارتفاع الشاشة
          width: MediaQuery.of(context).size.width * 0.25, // 25% من عرض الشاشة

          child: VideoplayerWidget(Url: videoUrl),
        );
      }
    }

    // حالة الصورة (لو الفيديو مش متاح أو مش صحيح)
    if (images.isNotEmpty) {
      String firstImageUrl = images[0];
      if (firstImageUrl.isNotEmpty) {
        final imageExtension = firstImageUrl.split('.').last.toLowerCase();
        final imageExtensions = ['jpg', 'jpeg', 'png', 'gif'];
        if (imageExtensions.contains(imageExtension)) {
          final fixedUrl = firstImageUrl.replaceFirst(
            "/storage/",
            "/storage/app/public/",
          );
          return Image.network(
            fixedUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset("assets/images/Logo.png", fit: BoxFit.cover);
            },
          );
        }
      }
    }

    // الحالة الافتراضية لو مفيش فيديو ولا صورة
    return Image.asset("assets/images/Logo.png", fit: BoxFit.cover);
  }

  // Widget buildMediaWidget(String mediaUrl) {
  //   if (mediaUrl.isEmpty) {
  //     return Image.asset("assets/images/Logo.png", fit: BoxFit.cover);
  //   }

  //   final extension = mediaUrl.split('.').last.toLowerCase();
  //   final videoExtensions = ['mp4', 'mov', 'avi', 'webm'];

  //   if (videoExtensions.contains(extension)) {
  //     return SizedBox(
  //       height: 100, // الحجم المناسب حسب تصميم الكارد
  //       width: 100,
  //       child: VideoplayerWidget(Url: mediaUrl),
  //     );
  //   } else {
  //     return Image.network(
  //       mediaUrl.replaceFirst("/storage/", "/storage/app/public/"),
  //       fit: BoxFit.cover,
  //       errorBuilder: (context, error, stackTrace) {
  //         return Image.asset("assets/images/Logo.png", fit: BoxFit.cover);
  //       },
  //     );
  //   }
  // }

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
            height: MediaQuery.of(context).size.height * 0.15,
            width:
                double.infinity, // استخدام double.infinity ليأخذ العرض المتاح
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: double.infinity,
                      width: 100,
                      child: buildMediaWidget(
                        activity.videoUrl ?? '', // الفيديو
                        activity.images ?? [], // صور النشاط كلها
                      ),
                    ),
                  ),

                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(12),
                  //   child: Container(
                  //     height: double.infinity,
                  //     width: 100,
                  //     child: buildMediaWidget(
                  //       // print('Video URL: ${activity.videoUrl}');
                  //       // print('Images list: ${activity.images}');
                  //       (activity.videoUrl.isNotEmpty)
                  //           ? activity.videoUrl
                  //           : (activity.images.isNotEmpty &&
                  //               activity.images[0].isNotEmpty)
                  //           ? activity.images[0]
                  //           : '',
                  //     ),
                  //   ),
                  // ),

                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(12),
                  //   child: Container(
                  //     height: double.infinity,
                  //     width: 100,
                  //     child: buildMediaWidget(
                  //       activity.videoUrl, // تحط لينك فيديو من عندك
                  //     ),
                  //   ),
                  // ),

                  // الصورة
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(12),
                  //   child: Container(
                  //     height: double.infinity,
                  //     width: 100,
                  //     child:
                  //         (activity.images.isNotEmpty &&
                  //                 activity.images[0].isNotEmpty)
                  //             ? buildMediaWidget(activity.images[0])
                  //             : Image.asset(
                  //               "assets/images/Logo.png",
                  //               fit: BoxFit.cover,
                  //             ),
                  //   ),
                  // ),

                  //     child:

                  //         (activity.images.isNotEmpty &&
                  //                 activity.images[0] != null &&
                  //                 activity.images[0].isNotEmpty)
                  //             ? Image.network(
                  //                       activity.images[0].replaceFirst("/storage/", "/storage/app/public/"),

                  //               // activity.images[0],
                  //               fit: BoxFit.cover,
                  //               errorBuilder: (context, error, stackTrace) {
                  //                 // لو حصل خطأ في تحميل الصورة (مثلاً 404 أو 403)
                  //                 return Image.asset(
                  //                   "assets/images/Logo.png",
                  //                   fit: BoxFit.cover,
                  //                 );
                  //               },
                  //             )
                  //             : Image.asset(
                  //               "assets/images/Logo.png",
                  //               fit: BoxFit.cover,
                  //             ),
                  //   ),
                  // ),
                  // const SizedBox(width: 25),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.03),

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
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.015,
                        ),
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

                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
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
                            height: MediaQuery.of(context).size.height * 0.015,
                          ),
                          Icon(
                            activity.transportation == true
                                ? Icons.directions_car_filled_sharp
                                : Icons.directions_walk_sharp,
                            color: Colors.grey[800],
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
