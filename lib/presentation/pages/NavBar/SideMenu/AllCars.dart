import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tripto/bloc&repo/car/car_bloc.dart';
import 'package:tripto/bloc&repo/car/car_state.dart';
import 'package:tripto/bloc&repo/car/car_event.dart';
import 'package:tripto/core/models/CarModel.dart';
import 'package:tripto/core/routes/app_routes.dart';

import '../../../../../../core/constants/Colors_Fonts_Icons.dart'; // تأكد من المسار الصحيح لـ colors
import '../../../../../../l10n/app_localizations.dart'; // تأكد من المسار الصحيح لـ routes

class CarCard extends StatefulWidget {
  const CarCard({
    super.key,
    // required this.activities
  });

  @override
  State<CarCard> createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  @override
  void initState() {
    super.initState();
    // لما الصفحة تفتح نطلب الداتا
    context.read<CarBloc>().add(LoadAllCars());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.cars,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: BlocBuilder<CarBloc, CarState>(
        builder: (context, state) {
          if (state is CarLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF002E70)),
            );
          } else if (state is GetAllCarsSuccess) {
            final allCars = state.allcars;
            return ListView.builder(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.12,
              ),
              itemCount: allCars.length,
              itemBuilder: (context, index) {
                final Car = allCars[index];
                return _buildCarCard(context, Car);
              },
            );
          } else if (state is CarError) {
            return Center(child: Text("Error: ${state.message}"));
          }
          return const SizedBox();
        },
      ),
    );
  }

  // Widget _buildMediaWidget(List<String> images) {
  //   // 1. التحقق من فيديوهات يوتيوب
  //   // if (videoUrl.isNotEmpty &&
  //   //     (videoUrl.contains('youtube.com') || videoUrl.contains('youtu.be'))) {
  //   //   final videoId = YoutubePlayer.convertUrlToId(videoUrl) ?? '';
  //   //   // return SizedBox(
  //   //   //   height: MediaQuery.of(context).size.height * 0.13,
  //   //   //   width: MediaQuery.of(context).size.width * 0.25,
  //   //   //   child: Stack(
  //   //   //     alignment: Alignment.center,
  //   //   //     children: [
  //   //   //       YoutubePlayer(
  //   //   //         controller: YoutubePlayerController(
  //   //   //           initialVideoId: videoId,
  //   //   //           flags: const YoutubePlayerFlags(
  //   //   //             autoPlay: true,
  //   //   //             mute: false,
  //   //   //             disableDragSeek: false,
  //   //   //             loop: false,
  //   //   //             isLive: false,
  //   //   //             forceHD: false,
  //   //   //             enableCaption: true,
  //   //   //           ),
  //   //   //         ),

  //   //   //         // showVideoProgressIndicator: true,
  //   //   //         // progressIndicatorColor: Colors.white,
  //   //   //       ),
  //   //   //     ],
  //   //   //   ),
  //   //   // );
  //   // }

  //   // 2. التحقق من الفيديوهات العادية
  //   // if (videoUrl.isNotEmpty) {
  //   //   final videoExtensions = ['mp4', 'mov', 'avi', 'webm'];
  //   //   final extension = videoUrl.split('.').last.toLowerCase();

  //   //   if (videoExtensions.contains(extension)) {
  //   //     return SizedBox(
  //   //       height: MediaQuery.of(context).size.height * 0.13,
  //   //       width: MediaQuery.of(context).size.width * 0.25,
  //   //       child: VideoplayerWidget(Url: videoUrl),
  //   //     );
  //   //   }
  //   // }

  //   // 3. التحقق من الصور
  //   if (images.isNotEmpty && images[0].isNotEmpty) {
  //     final imageExtensions = ['jpg', 'jpeg', 'png', 'gif'];
  //     final extension = images[0].split('.').last.toLowerCase();

  //     if (imageExtensions.contains(extension)) {
  //       final fixedUrl = images[0].replaceFirst(
  //         "/storage/",
  //         "/storage/app/public/",
  //       );
  //       return Image.network(
  //         fixedUrl,
  //         fit: BoxFit.cover,
  //         errorBuilder: (context, error, stackTrace) {
  //           return Image.asset("assets/images/Logo.png", fit: BoxFit.cover);
  //         },
  //       );
  //     }
  //   }

  //   // 4. الصورة الافتراضية
  //   return Image.asset("assets/images/Logo.png", fit: BoxFit.cover);

  //   // Widget _buildDefaultPlaceholder() {
  //   //   return Image.asset("assets/images/Logo.png", fit: BoxFit.cover);
  //   // }
  // }

  Widget _buildCarCard(BuildContext context, Carmodel allCars) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        color: const Color.fromARGB(183, 255, 255, 255),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.20,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(8),
                //   child: SizedBox(
                //     height: double.infinity,
                //     width: 100,
                //     child:
                //         (allCars.images.isNotEmpty &&
                //                 hotel.images[0].isNotEmpty)
                //             ? Image.network(
                //               hotel.images[0],
                //               fit: BoxFit.cover,
                //               errorBuilder:
                //                   (context, error, stackTrace) =>
                //                       Image.asset("assets/images/Logo.png"),
                //               loadingBuilder: (context, child, progress) {
                //                 if (progress == null) return child;
                //                 return const Center(
                //                   child: CircularProgressIndicator(
                //                     color: Color(0xFF002E70),
                //                   ),
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
                  child: Row(
                    children: [
                      Icon(Icons.directions_car, size: 40, color: Colors.black),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.050,
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                Localizations.localeOf(context).languageCode ==
                                        'ar'
                                    ? allCars.carNameAr
                                    : allCars.carNameEn,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2, // لضمان عدم تجاوز السطرين
                                overflow:
                                    TextOverflow
                                        .ellipsis, // لإضافة ... إذا كان النص طويلاً
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.015,
                          ),

                          // Text(
                          //   Localizations.localeOf(context).languageCode == 'ar'
                          //       ? allCars.color
                          //       : allCars.color,
                          //   style: const TextStyle(
                          //     fontSize: 14,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          //   maxLines: 2, // لضمان عدم تجاوز السطرين
                          //   overflow:
                          //       TextOverflow
                          //           .ellipsis, // لإضافة ... إذا كان النص طويلاً
                          // ),
                          // SizedBox(
                          //   height: MediaQuery.of(context).size.height * 0.015,
                          // ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      '${AppLocalizations.of(context)!.year} :',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),

                                TextSpan(
                                  text: "${allCars.year}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
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
                                  text: "${allCars.price}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.015,
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      '${AppLocalizations.of(context)!.color} :',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),

                                TextSpan(
                                  text: "${allCars.color}",
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
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.09,
                          ),
                          child: Text(
                            '${allCars.numberOfSeats}',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Icon(Icons.person, color: Color(0xFF002E70), size: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        if (allCars.withGuide)
                          Tooltip(
                            message: 'مرشد سياحي متوفر',
                            child: Icon(
                              Icons.person_pin,
                              color: Colors.greenAccent,
                              size: 25,
                            ),
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
    );
  }
}
