import 'package:flutter/material.dart';
import 'package:tripto/core/models/Hotelsـmodel.dart';
import 'package:video_player/video_player.dart';

class HotelAdelPage extends StatefulWidget {
  final HotelModel hotel;

  const HotelAdelPage({super.key, required this.hotel});

  @override
  State<HotelAdelPage> createState() => _HotelAdelPageState();
}

class _HotelAdelPageState extends State<HotelAdelPage> {
  PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;
  // VideoPlayerController? _videoController;

  // @override
  // void initState() {
  //   super.initState();
  //   if (widget.hotel.videoUrl.isNotEmpty) {
  //     _videoController = VideoPlayerController.network(widget.hotel.videoUrl)
  //       ..initialize().then((_) {
  //         setState(() {});
  //       });
  //   }
  // }

  @override
  void dispose() {
    _pageController.dispose();
    // _videoController?.dispose();
    super.dispose();
  }

  String getRoomType(int type) {
    switch (type) {
      case 1:
        return "Single";
      case 2:
        return "Double";
      case 3:
        return "Triple";
      case 4:
        return "Quad";
      default:
        return "Unknown";
    }
  }

  Widget _buildServiceIcon(bool available, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: available ? Colors.green : Colors.grey, size: 28),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: available ? Colors.black : Colors.grey,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final hotel = widget.hotel;

    final mediaItems = [
      ...hotel.images.map(
        (img) => Image.network(
          img,
          fit: BoxFit.cover,
          errorBuilder:
              (_, __, ___) =>
                  Image.asset("assets/images/Logo.png", fit: BoxFit.cover),
        ),
      ),
      // if (_videoController != null && _videoController!.value.isInitialized)
      //   AspectRatio(
      //     aspectRatio: _videoController!.value.aspectRatio,
      //     child: VideoPlayer(_videoController!),
      //   ),
    ];

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
                      height: 280,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: mediaItems.length,
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return AnimatedBuilder(
                            animation: _pageController,
                            builder: (context, child) {
                              double value = 1.0;
                              if (_pageController.position.haveDimensions) {
                                value = _pageController.page! - index;
                                value = (1 - (value.abs() * 0.3)).clamp(
                                  0.0,
                                  1.0,
                                );
                              }
                              return Transform.scale(
                                scale: value,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 8, // خفيف زيادة
                                        offset: Offset(
                                          0,
                                          6,
                                        ), // الظل ييجي من تحت
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: mediaItems[index],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    // Indicators
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        mediaItems.length,
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
                    // Hotel name
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
                                "\$${hotel.pricePerNight.toStringAsFixed(2)}/night",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Hotel description
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
                            child: Text(
                              hotel.mapLocation,
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
                            Icons.meeting_room,
                            color: Colors.blueAccent,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "Room Type: ${getRoomType(hotel.roomType)}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Services
                      const Text(
                        "Services",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      GridView.count(
                        crossAxisCount: 4,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          _buildServiceIcon(
                            hotel.wifiAvailable,
                            Icons.wifi,
                            "WiFi",
                          ),
                          _buildServiceIcon(
                            hotel.parkingAvailable,
                            Icons.local_parking,
                            "Parking",
                          ),
                          _buildServiceIcon(
                            hotel.poolAvailable,
                            Icons.pool,
                            "Pool",
                          ),
                          _buildServiceIcon(
                            hotel.gymAvailable,
                            Icons.fitness_center,
                            "Gym",
                          ),
                          _buildServiceIcon(
                            hotel.spaAvailable,
                            Icons.spa,
                            "Spa",
                          ),
                          _buildServiceIcon(
                            hotel.restaurantAvailable,
                            Icons.restaurant,
                            "Restaurant",
                          ),
                          _buildServiceIcon(
                            hotel.roomServiceAvailable,
                            Icons.room_service,
                            "Room Service",
                          ),
                          _buildServiceIcon(
                            hotel.petFriendly,
                            Icons.pets,
                            "Pet Friendly",
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
            top: 40,
            left: 16,
            child: CircleAvatar(
              backgroundColor: Colors.black45,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
