class HotelModel {
  final int id;
  final int subDestinationId;
  final String nameEn;
  final String nameAr;
  final String descriptionEn;
  final String descriptionAr;
  final List<String> images;
  final String videoUrl;
  final String mapLocation;
  final String placeEn;
  final String placeAr;
  final int rate;
  final double pricePerNight;
  final int roomType;

  // الخدمات المتاحة
  final bool wifiAvailable;
  final bool parkingAvailable;
  final bool poolAvailable;
  final bool gymAvailable;
  final bool spaAvailable;
  final bool restaurantAvailable;
  final bool roomServiceAvailable;
  final bool petFriendly;

  HotelModel({
    required this.id,
    required this.subDestinationId,
    required this.nameEn,
    required this.nameAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.images,
    required this.videoUrl,
    required this.mapLocation,
    required this.placeEn,
    required this.placeAr,
    required this.rate,
    required this.pricePerNight,
    required this.roomType,
    required this.wifiAvailable,
    required this.parkingAvailable,
    required this.poolAvailable,
    required this.gymAvailable,
    required this.spaAvailable,
    required this.restaurantAvailable,
    required this.roomServiceAvailable,
    required this.petFriendly,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      id: json['id'],
      subDestinationId: json['sub_destination_id'],
      nameEn: json['name_en'] ?? '',
      nameAr: json['name_ar'] ?? '',
      descriptionEn: json['description_en'] ?? '',
      descriptionAr: json['description_ar'] ?? '',
      images:
          (json['images'] as List<dynamic>? ?? [])
              .map(
                (path) =>
                    "https://tripto.blueboxpet.com${path.replaceFirst("/storage/", "/storage/app/public/")}",
              )
              .toList(),

      videoUrl: json['video_url'] ?? '',
      mapLocation: json['map_location'] ?? '',
      placeEn: json['place_en'] ?? '',
      placeAr: json['place_ar'] ?? '',
      rate: json['rate'] ?? 0,
      pricePerNight: double.tryParse(json['price_per_night'].toString()) ?? 0.0,
      roomType: json['room_type'] ?? 0,
      wifiAvailable: json['wifiAvailable'] ?? false,
      parkingAvailable: json['parkingAvailable'] ?? false,
      poolAvailable: json['poolAvailable'] ?? false,
      gymAvailable: json['gymAvailable'] ?? false,
      spaAvailable: json['spaAvailable'] ?? false,
      restaurantAvailable: json['restaurantAvailable'] ?? false,
      roomServiceAvailable: json['roomServiceAvailable'] ?? false,
      petFriendly: json['petFriendly'] ?? false,
    );
  }
}
