import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto/bloc&repo/%D9%90Auth/AuthBloc.dart';
import 'package:tripto/bloc&repo/%D9%90Auth/AuthEvent.dart';
import 'package:tripto/core/constants/videoplayer_widget.dart';
// import 'package:tripto/core/models/ActivityCardModel.dart';
import 'package:tripto/core/models/activityPageModel.dart';
// import 'package:tripto/presentation/app/app.dart'; // تأكد من المسار الصحيح لـ App
// import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../bloc&repo/ِAuth/AuthState.dart';
import '../../../../core/constants/Colors_Fonts_Icons.dart'; // تأكد من المسار الصحيح لـ colors
import '../../../../core/routes/app_routes.dart';
import '../../../../l10n/app_localizations.dart'; // تأكد من المسار الصحيح لـ routes

class ActivityPage extends StatefulWidget {
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
      backgroundColor: Colors.white,

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

  Widget _buildMediaWidget(String videoUrl, List<String> images) {
    // 1. التحقق من فيديوهات يوتيوب
    if (videoUrl.isNotEmpty &&
        (videoUrl.contains('youtube.com') || videoUrl.contains('youtu.be'))) {
      final videoId = YoutubePlayer.convertUrlToId(videoUrl) ?? '';
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.13,
        width: MediaQuery.of(context).size.width * 0.25,
        child: Stack(
          alignment: Alignment.center,
          children: [
            YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: videoId,
                flags: const YoutubePlayerFlags(
                  autoPlay: true,
                  mute: false,
                  disableDragSeek: false,
                  loop: false,
                  isLive: false,
                  forceHD: false,
                  enableCaption: true,
                ),
              ),

              // showVideoProgressIndicator: true,
              // progressIndicatorColor: Colors.white,
            ),
          ],
        ),
      );
    }

    // 2. التحقق من الفيديوهات العادية
    if (videoUrl.isNotEmpty) {
      final videoExtensions = ['mp4', 'mov', 'avi', 'webm'];
      final extension = videoUrl.split('.').last.toLowerCase();

      if (videoExtensions.contains(extension)) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.13,
          width: MediaQuery.of(context).size.width * 0.25,
          child: VideoplayerWidget(Url: videoUrl),
        );
      }
    }

    // 3. التحقق من الصور
    if (images.isNotEmpty && images[0].isNotEmpty) {
      final imageExtensions = ['jpg', 'jpeg', 'png', 'gif'];
      final extension = images[0].split('.').last.toLowerCase();

      if (imageExtensions.contains(extension)) {
        final fixedUrl = images[0].replaceFirst(
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

    // 4. الصورة الافتراضية
    return Image.asset("assets/images/Logo.png", fit: BoxFit.cover);

    // Widget _buildDefaultPlaceholder() {
    //   return Image.asset("assets/images/Logo.png", fit: BoxFit.cover);
    // }
  }

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
          color: const Color.fromARGB(183, 255, 255, 255),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      height: double.infinity,
                      width: 100,
                      child: _buildMediaWidget(
                        activity.videoUrl ?? '',
                        activity.images ?? [],
                      ),
                    ),
                  ),

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
                                    '${AppLocalizations.of(context)!.price} :',
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
  children: Localizations.localeOf(context).languageCode == 'ar'
      ? [
          Text(
            "${AppLocalizations.of(context)!.duration}: ",
          ),
          Text("${activity.activityduration} "),
          // Text(AppLocalizations.of(context)!.min),
        ]
      : [
          Text(
            "${AppLocalizations.of(context)!.duration}: ",
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
