// // lib/core/keep_alive_video.dart

// import 'package:flutter/material.dart';
// import 'package:tripto/presentation/pages/NavBar/home/homepage/VedioPlayerPage.dart'; // تأكد من المسار الصحيح
// import 'package:tripto/presentation/pages/screens/leftSide/PersonCounterWithPrice.dart';

// // يجب أن تكون هذه المعلمات قابلة للتمرير
// class KeepAliveVideo extends StatefulWidget {
//   final GlobalKey<VideoPlayerScreenState> videoPlayerScreenKey;
//   final Function(
//     int tripId,
//     int category,
//     GlobalKey<PersonCounterWithPriceState> personCounterKey,
//     String? tripSummary,
//     int? hotelId,
//     double hotelPrice,
//     int? carId,
//     double carPrice,
//     int? activityId,
//     double activityPrice,
//   ) onTripChanged;
//   final VoidCallback onSearchPressed;
//   final Function(bool?) onToggleFullscreen;
//   final bool isCurrentlyFullscreen;

//   const KeepAliveVideo({
//     super.key,
//     required this.videoPlayerScreenKey,
//     required this.onTripChanged,
//     required this.onSearchPressed,
//     required this.onToggleFullscreen,
//     required this.isCurrentlyFullscreen,
//   });

//   @override
//   State<KeepAliveVideo> createState() => _KeepAliveVideoState();
// }

// class _KeepAliveVideoState extends State<KeepAliveVideo> with AutomaticKeepAliveClientMixin {
  
//   @override
//   bool get wantKeepAlive => true; // 💡 هذا هو مفتاح الحل

//   @override
//   Widget build(BuildContext context) {
//     super.build(context); // يجب استدعاء هذه الدالة
    
//     return VideoPlayerScreen(
//       key: widget.videoPlayerScreenKey,
//       onTripChanged: widget.onTripChanged,
//       onSearchPressed: widget.onSearchPressed,
//       onToggleFullscreen: widget.onToggleFullscreen,
//       isCurrentlyFullscreen: widget.isCurrentlyFullscreen,
//     );
//   }
// }