import 'package:flutter/material.dart';
import 'package:tripto/core/constants/Expanded_text.dart';
import 'package:tripto/core/constants/videoplayer_widget.dart';
import 'package:tripto/core/models/activityPageModel.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../core/constants/Colors_Fonts_Icons.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../l10n/app_localizations.dart';

class ActivityDetailsPage extends StatefulWidget {
  final GetActivityModel activity;

  const ActivityDetailsPage({super.key, required this.activity});

  @override
  State<ActivityDetailsPage> createState() => _ActivityDetailsPageState();
}

class _ActivityDetailsPageState extends State<ActivityDetailsPage> {
  int _numberOfPeople = 1;

  Widget _buildMediaWidget(String videoUrl, List<String> images) {
    // اول حاجه هيتاكد في لإيديوهات يوتيوب ولا لا
    if (videoUrl.isNotEmpty &&
        (videoUrl.contains('youtube.com') || videoUrl.contains('youtu.be'))) {
      final videoId = YoutubePlayer.convertUrlToId(videoUrl) ?? '';
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.25,
        width: MediaQuery.of(context).size.width * 0.9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: YoutubePlayer(
            controller: YoutubePlayerController(
              initialVideoId: videoId,
              flags: const YoutubePlayerFlags(
                autoPlay: false,
                mute: false,
                disableDragSeek: false,
                loop: false,
                isLive: false,
                forceHD: false,
                enableCaption: true,
              ),
            ),
            showVideoProgressIndicator: true,
            progressIndicatorColor: Color(0xFF002E70),
          ),
        ),
      );
    }

    // لو مفيش لإيديوهات يويتوب هيتأكد فيه لإيديوهات عاديه فيها الامتدادات دي ولا لا
    if (videoUrl.isNotEmpty) {
      final videoExtensions = ['mp4', 'mov', 'avi', 'webm'];
      final extension = videoUrl.split('.').last.toLowerCase();

      if (videoExtensions.contains(extension)) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width * 0.9,

          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: VideoplayerWidget(Url: videoUrl),
          ),
        );
      }
    }

    // لو برده ملقاش فيديو هيبص علي الصور
    if (images.isNotEmpty) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.25,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.02,
          ),
          itemCount: images.length,
          separatorBuilder:
              (context, index) =>
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
          itemBuilder: (context, index) {
            final fixedUrl = images[index].replaceFirst(
              "/storage/",
              "/storage/app/public/", // استبدل بالمسار الصحيح
            );

            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                margin: EdgeInsets.symmetric(horizontal: 4),
                child: Image.network(
                  fixedUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF002E70),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    // print('Error loading image: $error');
                    return Image.asset(
                      "assets/images/Logo.png",
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.25,
                    );
                  },
                ),
              ),
            );
          },
          //   catch (e) {
          //     print('Error processing image: $e');
          //   }
          // }
        ),
      );
    }
    // لو مفيش صورة هيعرض الصورة اللي انا مختارها
    return Image.asset(
      "assets/images/Logo.png",
      fit: BoxFit.cover,
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.25,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.activity.activitynameen,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Localizations.localeOf(context).languageCode == 'ar'
                ? Icons.keyboard_arrow_right_outlined
                : Icons.keyboard_arrow_left_outlined,
            size: 35,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: _buildMediaWidget(
                    widget.activity.videoUrl,
                    widget.activity.images,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.03,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.01,
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.destination + " : ",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(width: MediaQuery.of(context).size.width * 0.002),
                    Text(
                      Localizations.localeOf(context).languageCode == 'ar'
                          ? widget.activity.activitynamear
                          : widget.activity.activitynameen,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                    // Text(
                    //   '⭐ ${widget.activity.rate}',
                    //   style: const TextStyle(
                    //     fontSize: 20,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ExpandedText(
                      text:
                          Localizations.localeOf(context).languageCode == 'ar'
                              ? widget.activity.activitydescriptionar
                              : widget.activity.activitydescriptionen,

                      // "This is the description of the company.This is the description of the companyThis is the description of the company",
                      maxLines: 2,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.numberofpeople + " :",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 5),

                      const Spacer(),
                      Row(
                        children: [
                          Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              iconSize: 20,
                              onPressed: () {
                                setState(() {
                                  _numberOfPeople++;
                                });
                              },
                              icon: const Icon(Icons.add, color: Colors.black),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "$_numberOfPeople",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              iconSize: 20,
                              onPressed: () {
                                setState(() {
                                  if (_numberOfPeople > 1) {
                                    _numberOfPeople--;
                                  }
                                });
                              },
                              icon: const Icon(
                                Icons.remove,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(Icons.person_2_outlined),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.category + " :",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      Text(
                        widget.activity.category == CategoryType.Platinum
                            ? AppLocalizations.of(context)!.platinum
                            : widget.activity.category == CategoryType.Diamond
                            ? AppLocalizations.of(context)!.diamond
                            : AppLocalizations.of(context)!.gold,
                        style: TextStyle(
                          color:
                              widget.activity.category == CategoryType.Platinum
                                  ? Color.fromARGB(255, 144, 143, 142)
                                  : widget.activity.category ==
                                      CategoryType.Diamond
                                  ? Color.fromARGB(255, 132, 214, 241)
                                  : Color(0xFFF1B31C),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.price + " :",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                      Text(
                        "${widget.activity.price * _numberOfPeople} \$",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.paymentOption);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: btn_background_color_gradiant,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            AppLocalizations.of(context)!.confirm,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
