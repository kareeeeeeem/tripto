import 'package:flutter/material.dart';
import 'package:tripto/core/models/activityPageModel.dart';
import 'package:tripto/main.dart';
import 'package:tripto/presentation/pages/NavBar/ActivityPage/activity_details_page.dart';
import 'package:tripto/presentation/pages/SlideBar/activity/ActivityDetailsPage.dart';
import '../../../../l10n/app_localizations.dart';

class ActivityCard extends StatelessWidget {
  final GetActivityModel activity;
  final bool isSelected;
  final VoidCallback onTap;

  const ActivityCard({
    required this.activity,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                border:
                    isSelected
                        ? Border.all(color: Colors.blueAccent, width: 3)
                        : null,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Card(
                color: const Color.fromARGB(183, 255, 255, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: SizedBox(
                  height: 136,
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
                            child:
                                (activity.images.isNotEmpty &&
                                        activity.images[0].isNotEmpty)
                                    ? Image.network(
                                      activity.images[0].replaceFirst(
                                        "/storage/",
                                        "/storage/app/public/",
                                      ),
                                      fit: BoxFit.cover,
                                      errorBuilder: (
                                        context,
                                        error,
                                        stackTrace,
                                      ) {
                                        return Image.asset(
                                          "assets/images/Logo.png",
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    )
                                    : Image.asset(
                                      "assets/images/Logo.png",
                                      fit: BoxFit.cover,
                                    ),
                          ),
                        ),
                        const SizedBox(width: 25),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    Localizations.localeOf(
                                              context,
                                            ).languageCode ==
                                            'ar'
                                        ? activity.activitynamear
                                        : activity.activitynameen,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.info_outline),
                                    onPressed: () {
                                      final videoPlayerState =
                                          videoPlayerScreenKey.currentState;
                                      videoPlayerState?.pauseCurrentVideo();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (_) => ActivityDetailsPage(
                                                activity: activity,
                                              ),
                                        ),
                                      ).then((_) {
                                        videoPlayerState?.playCurrentVideo();
                                      });
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          '${AppLocalizations.of(context)!.price} :',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: ' \$',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "${activity.price}",
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Icon(
                                activity.transportation == true
                                    ? Icons.directions_car_filled_sharp
                                    : Icons.directions_walk_sharp,
                                color: Colors.grey[800],
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // ✅ أيقونة الصح في أعلى يمين الكارد
            if (isSelected)
              Positioned(
                top: 8,
                right: 8,
                child: Icon(
                  Icons.check_circle,
                  color: Colors.blueAccent,
                  size: 24,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
