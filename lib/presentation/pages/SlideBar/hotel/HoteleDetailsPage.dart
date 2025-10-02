import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:tripto/core/models/Hotelsـmodel.dart';
import 'package:tripto/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

// تعريف نوع بيانات للتعامل مع الصور والفيديوهات
class MediaItem {
  final String url;
  final bool isVideo;
  VideoPlayerController? videoController;
  ChewieController? chewieController; 

  MediaItem({required this.url, required this.isVideo});
}

class HotelAdelPage extends StatefulWidget {
  final HotelModel hotel;

  const HotelAdelPage({super.key, required this.hotel});

  @override
  State<HotelAdelPage> createState() => _HotelAdelPageState();
}

class _HotelAdelPageState extends State<HotelAdelPage> {
  final PageController _pageController = PageController(viewportFraction: 1.0); 
  int _currentPage = 0;
  List<MediaItem> _mediaList = []; 
  bool _isInitializing = true; 

  @override
  void initState() {
    super.initState();
    _initializeMediaList();
    
    _pageController.addListener(() {
      if (_pageController.page != null) {
        final newPageIndex = _pageController.page!.round();
        if (_currentPage != newPageIndex) {
           _onPageChanged(newPageIndex);
        }
        setState(() {
          _currentPage = newPageIndex;
        });
      }
    });
  }

  void _initializeMediaList() async {
    // 1. دمج الصور
    _mediaList.addAll(widget.hotel.images.map((url) => MediaItem(url: url, isVideo: false)));
    
    // 2. دمج الفيديو المفرد وتهيئة المتحكمات
    if (widget.hotel.videoUrl.isNotEmpty) {
      String originalUrl = widget.hotel.videoUrl;
      
      // 💡 منطق تحويل رابط جوجل درايف: تحويل رابط المعاينة إلى رابط مباشر
      if (originalUrl.contains('drive.google.com') && originalUrl.contains('/view')) {
          final fileIdMatch = RegExp(r'/d/([^/]+)/view').firstMatch(originalUrl);
          if (fileIdMatch != null) {
              final fileId = fileIdMatch.group(1);
              originalUrl = 'https://drive.google.com/uc?export=download&id=$fileId';
              print("🔗 Converted Google Drive URL to Direct Link: $originalUrl");
          } else {
              print("🛑 Could not extract File ID from Google Drive URL.");
          }
      }
      
      final item = MediaItem(url: originalUrl, isVideo: true);
      
      item.videoController = VideoPlayerController.networkUrl(Uri.parse(originalUrl));
      
      try {
        await item.videoController!.initialize();
        item.chewieController = ChewieController(
          videoPlayerController: item.videoController!,
          autoPlay: false, 
          looping: true,
          showControls: true, 
          showControlsOnInitialize: true,
          allowFullScreen: true,
          
          // نستخدم أبعاد الفيديو الأصلية للمتحكم
          aspectRatio: item.videoController!.value.aspectRatio, 
          
          errorBuilder: (context, errorMessage) {
            return Center(
              child: Text(
                AppLocalizations.of(context)?.videoNotAvailable ?? 'Video failed to load.',
                style: const TextStyle(color: Colors.white),
              ),
            );
          },
        );
        // تم التهيئة بنجاح، أضف العنصر إلى القائمة
        _mediaList.add(item);
        print("✅ Video initialized successfully: ${item.url}");

      } catch (error) {
        // إذا فشلت التهيئة
        print("🛑 Video Initialization FAILED for URL: ${item.url}");
        print("🛑 Error: $error");
      }
    }
    
    // بعد الانتهاء من تهيئة كل شيء، نقوم بتحديث الـ State
    if (mounted) {
      setState(() {
        _isInitializing = false; 
        _currentPage = 0; 
      });
    }
  }
  
  void _onPageChanged(int newPageIndex) {
    final previousPage = _mediaList[_currentPage];
    if (previousPage.isVideo) {
        previousPage.chewieController?.pause();
        previousPage.videoController?.seekTo(Duration.zero);
    }
  }


  @override
  void dispose() {
    _pageController.dispose();
    for (var item in _mediaList) {
      if (item.isVideo) {
        item.chewieController?.dispose();
        item.videoController?.dispose();
      }
    }
    super.dispose();
  }

  // الدوال المساعدة الأخرى (getRoomType و _buildServiceIcon) كما هي...
  String getRoomType(BuildContext context, int type) {
    switch (type) {
      case 1:
        return AppLocalizations.of(context)!.single;
      case 2:
        return AppLocalizations.of(context)!.double;
      case 3:
        return AppLocalizations.of(context)!.triple;
      case 4:
        return AppLocalizations.of(context)!.quad;
      default:
        return AppLocalizations.of(context)!.unknown;
    }
  }

  Widget _buildServiceIcon(bool available, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: available ? Colors.blue : Colors.grey, size: 28),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.03,
            color: available ? Colors.black : Colors.grey,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final hotel = widget.hotel;

    if (_isInitializing) {
        return const Scaffold(
            body: Center(
                child: CircularProgressIndicator(),
            ),
        );
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image/Video slider
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.55, 
                      width: MediaQuery.of(context).size.width,
                        
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: _mediaList.length,
                        itemBuilder: (context, index) {
                          final item = _mediaList[index];
                          Widget child;

                          if (item.isVideo) {
                            // التحقق من أن المتحكم قد تمت تهيئته بنجاح
                            if (item.chewieController != null && item.chewieController!.videoPlayerController.value.isInitialized) {
                              
                              // 💡 استخدام FittedBox و SizedBox لملء المنطقة (BoxFit.cover)
                              child = FittedBox(
                                fit: BoxFit.cover, // يضمن ملء الـ SizedBox الخارجي (55% من الشاشة)
                                child: SizedBox(
                                  // نحدد أبعاد الفيديو لجعله يملأ الـ FittedBox
                                  width: item.videoController!.value.size.width,
                                  height: item.videoController!.value.size.height,
                                  child: Chewie(controller: item.chewieController!),
                                ),
                              );

                            } else {
                              // إذا لم يتم تهيئته لأي سبب بعد المحاولة
                              child = Center(
                                child: Text(
                                  AppLocalizations.of(context)?.videoNotAvailable ?? 'Video failed to load.',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              );
                            }
                          } else {
                            // الصور
                            child = Image.network(
                              item.url,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  Image.asset("assets/images/Logo.png", fit: BoxFit.cover),
                            );
                          }

                          return Container(
                            margin: EdgeInsets.zero, 
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 8,
                                  offset: Offset(0, 6),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0), 
                              child: child,
                            ),
                          );
                        },
                      ),
                    ),
                              const SizedBox(height: 16), // يمكنك تغيير القيمة 16 حسب حاجتك

                    // Indicators
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _mediaList.length,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentPage == index ? 12 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color:
                                _currentPage == index
                                    ? Colors.blue
                                    : Colors.grey[400],
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Hotel name and description
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Localizations.localeOf(context).languageCode == 'ar'
                                ? hotel.nameAr
                                : hotel.nameEn,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const SizedBox(width: 8),

                              Text(
                                Localizations.localeOf(context).languageCode ==
                                        'ar'
                                    ? (hotel.descriptionAr.isNotEmpty
                                        ? hotel.descriptionAr
                                        : "لا يوجد وصف متاح")
                                    : (hotel.descriptionEn.isNotEmpty
                                        ? hotel.descriptionEn
                                        : "No description available"),
                                style: const TextStyle(
                                  fontSize: 16,
                                  height: 1.5,
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
              // بقية محتوى الصفحة
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Ratings & Price Card
                      Card(
                        color: Colors.white,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: List.generate(7, (index) {
                                  return Icon(
                                    index < hotel.rate
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: Colors.amber,
                                  );
                                }),
                              ),
                              Text(
                                AppLocalizations.of(context)!.pricePerNight(
                                  hotel.pricePerNight.toStringAsFixed(2),
                                ),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Hotel location and map link
                      Row(
                        children: [
                          const Icon(
                            Icons.location_city_outlined,
                            color: Colors.redAccent,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              Localizations.localeOf(context).languageCode ==
                                      'ar'
                                  ? hotel.placeAr
                                  : hotel.placeEn,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(
                            Icons.place_outlined,
                            color: Colors.redAccent,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                final Uri url = Uri.parse(hotel.mapLocation);
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url, mode: LaunchMode.externalApplication);
                                } else {
                                  if (mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Could not launch ${hotel.mapLocation}')),
                                      );
                                  }
                                }
                              },
                              child: Text(
                                hotel.mapLocation,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            )

                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Room type
                      Row(
                        children: [
                          const Icon(
                            Icons.meeting_room,
                            color: Colors.blueAccent,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "${AppLocalizations.of(context)!.roomType}: ${getRoomType(context, hotel.roomType)}",

                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      // Services
                      Text(
                        AppLocalizations.of(context)!.services,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 1),
                      GridView.count(
                        crossAxisCount: 4,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          _buildServiceIcon(
                            hotel.wifiAvailable,
                            Icons.wifi,
                            AppLocalizations.of(context)!.wifi,
                          ),
                          _buildServiceIcon(
                            hotel.parkingAvailable,
                            Icons.local_parking,
                            AppLocalizations.of(context)!.parking,
                          ),
                          _buildServiceIcon(
                            hotel.poolAvailable,
                            Icons.pool,
                            AppLocalizations.of(context)!.pool,
                          ),
                          _buildServiceIcon(
                            hotel.gymAvailable,
                            Icons.fitness_center,
                            AppLocalizations.of(context)!.gym,
                          ),
                          _buildServiceIcon(
                            hotel.spaAvailable,
                            Icons.spa,
                            AppLocalizations.of(context)!.spa,
                          ),
                          _buildServiceIcon(
                            hotel.restaurantAvailable,
                            Icons.restaurant,
                            AppLocalizations.of(context)!.restaurant,
                          ),
                          _buildServiceIcon(
                            hotel.roomServiceAvailable,
                            Icons.room_service,
                            AppLocalizations.of(context)!.roomService,
                          ),
                          _buildServiceIcon(
                            hotel.petFriendly,
                            Icons.pets,
                            AppLocalizations.of(context)!.petFriendly,
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Back button
          Positioned(
            top: MediaQuery.of(context).size.height * 0.05, 
            left: Localizations.localeOf(context).languageCode == 'ar'
                ? null
                : MediaQuery.of(context).size.width * 0.04,
            right: Localizations.localeOf(context).languageCode == 'ar'
                ? MediaQuery.of(context).size.width * 0.04
                : null,
            child: CircleAvatar(
              backgroundColor: Colors.black45,
              child: IconButton(
                icon: Icon(
                    Localizations.localeOf(context).languageCode == 'ar'
                        ? Icons.arrow_forward
                        : Icons.arrow_back,
                    color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}