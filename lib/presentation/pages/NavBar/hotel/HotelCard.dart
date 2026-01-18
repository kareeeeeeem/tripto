import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tripto/bloc&repo/%D9%90Auth/AuthBloc.dart';
import 'package:tripto/bloc&repo/Hotel/hotelBloc.dart';
import 'package:tripto/bloc&repo/Hotel/hotelEvents.dart';
import 'package:tripto/bloc&repo/Hotel/hotelStates.dart';
// import 'package:tripto/core/constants/videoplayer_widget.dart';
// import 'package:tripto/core/models/HotelModel.dart';
import 'package:tripto/core/models/Hotels%D9%80model.dart';
// import 'package:tripto/core/models/ActivityCardModel.dart';
// import 'package:tripto/core/models/activityPageModel.dart';
import 'package:tripto/presentation/pages/SlideBar/hotel/HoteleDetailsPage.dart';
// import 'package:tripto/presentation/app/app.dart'; // تأكد من المسار الصحيح لـ App
// import 'package:http/http.dart' as http;
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// import '../../../../../../bloc&repo/ِAuth/AuthState.dart';
import '../../../../../../core/constants/Colors_Fonts_Icons.dart'; // تأكد من المسار الصحيح لـ colors
// import '../../../../../../core/routes/app_routes.dart';
import '../../../../../../l10n/app_localizations.dart';

class Hotelcard extends StatefulWidget {
  const Hotelcard({
    super.key,
    // required this.activities
  });

  @override
  State<Hotelcard> createState() => _HotelcardState();
}

class _HotelcardState extends State<Hotelcard> {
  @override
  void initState() {
    super.initState();
    // لما الصفحة تفتح نطلب الداتا
    context.read<HotelsBloc>().add(FetchAllHotels());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.hotel,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: BlocBuilder<HotelsBloc, HotelsState>(
        builder: (context, state) {
          if (state is HotelsLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF002E70)),
            );
          } else if (state is GetAllHotelsSuccess) {
            final hotels = state.hotels;
            return ListView.builder(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.12,
              ),
              itemCount: hotels.length,
              itemBuilder: (context, index) {
                final hotel = hotels[index];
                return _buildHotelCard(context, hotel);
              },
            );
          } else if (state is HotelsError) {
            return Center(child: Text("Error: ${state.message}"));
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildMediaWidget(List<String> images) {
    // 1. التحقق من فيديوهات يوتيوب
    // if (videoUrl.isNotEmpty &&
    //     (videoUrl.contains('youtube.com') || videoUrl.contains('youtu.be'))) {
    //   final videoId = YoutubePlayer.convertUrlToId(videoUrl) ?? '';
    //   // return SizedBox(
    //   //   height: MediaQuery.of(context).size.height * 0.13,
    //   //   width: MediaQuery.of(context).size.width * 0.25,
    //   //   child: Stack(
    //   //     alignment: Alignment.center,
    //   //     children: [
    //   //       YoutubePlayer(
    //   //         controller: YoutubePlayerController(
    //   //           initialVideoId: videoId,
    //   //           flags: const YoutubePlayerFlags(
    //   //             autoPlay: true,
    //   //             mute: false,
    //   //             disableDragSeek: false,
    //   //             loop: false,
    //   //             isLive: false,
    //   //             forceHD: false,
    //   //             enableCaption: true,
    //   //           ),
    //   //         ),

    //   //         // showVideoProgressIndicator: true,
    //   //         // progressIndicatorColor: Colors.white,
    //   //       ),
    //   //     ],
    //   //   ),
    //   // );
    // }

    // 2. التحقق من الفيديوهات العادية
    // if (videoUrl.isNotEmpty) {
    //   final videoExtensions = ['mp4', 'mov', 'avi', 'webm'];
    //   final extension = videoUrl.split('.').last.toLowerCase();

    //   if (videoExtensions.contains(extension)) {
    //     return SizedBox(
    //       height: MediaQuery.of(context).size.height * 0.13,
    //       width: MediaQuery.of(context).size.width * 0.25,
    //       child: VideoplayerWidget(Url: videoUrl),
    //     );
    //   }
    // }

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

  Widget _buildHotelCard(BuildContext context, HotelModel hotel) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => HotelAdelPage(hotel: hotel)),
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
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      height: double.infinity,
                      width: 100,
                      child:
                          (hotel.images.isNotEmpty &&
                                  hotel.images[0].isNotEmpty)
                              ? Image.network(
                                hotel.images[0],
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) =>
                                        Image.asset("assets/images/Logo.png"),
                                loadingBuilder: (context, child, progress) {
                                  if (progress == null) return child;
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: Color(0xFF002E70),
                                    ),
                                  );
                                },
                              )
                              : Image.asset(
                                "assets/images/Logo.png",
                                fit: BoxFit.cover,
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
                              ? hotel.nameAr
                              : hotel.nameEn,
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
                                    '${AppLocalizations.of(context)!.pricepernight} :',
                                style: TextStyle(
                                  fontSize: 14,
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
                                text: "${hotel.pricePerNight}",
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
                                        "${AppLocalizations.of(context)!.rate}: ",
                                      ),
                                      Text("${hotel.rate} "),
                                      // Text(AppLocalizations.of(context)!.min),
                                    ]
                                    : [
                                      Text(
                                        "${AppLocalizations.of(context)!.rate}: ",
                                      ),
                                      Text("${hotel.rate} "),
                                      // Text(AppLocalizations.of(context)!.min),
                                    ],
                          ),

                          // SizedBox(
                          //   height: MediaQuery.of(context).size.height * 0.015,
                          // ),
                          // Icon(
                          //   activity.transportation == true
                          //       ? Icons.directions_car_filled_sharp
                          //       : Icons.directions_walk_sharp,
                          //   color: Colors.grey[800],
                          //   size: 20,
                          // ),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => HotelAdelPage(hotel: hotel),
                            ),
                          );
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
