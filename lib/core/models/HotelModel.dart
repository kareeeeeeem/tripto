// // model to create hotel

// import 'dart:io';

// enum CategoryType { Gold, Platinum, Diamond }

// int _mapCategoryToInt(CategoryType category) {
//   switch (category) {
//     case CategoryType.Gold:
//       return 0;
//     case CategoryType.Platinum:
//       return 1;
//     case CategoryType.Diamond:
//       return 2;
//   }
// }

// CategoryType _mapIntToCategory(int value) {
//   switch (value) {
//     case 0:
//       return CategoryType.Gold;
//     case 1:
//       return CategoryType.Platinum;
//     case 2:
//       return CategoryType.Diamond;
//     default:
//       throw Exception("قيمة غير معروفة: $value");
//   }
// }

// enum RoomType { single, double, trio, quad }

// // نوع الاوضه
// int _mapRoomToInt(RoomType room) {
//   switch (room) {
//     case RoomType.single:
//       return 0;
//     case RoomType.double:
//       return 1;
//     case RoomType.trio:
//       return 2;
//     case RoomType.quad:
//       return 3;
//   }
// }

// RoomType _mapIntToRoom(int room) {
//   switch (room) {
//     case 0:
//       return RoomType.single;
//     case 1:
//       return RoomType.double;
//     case 2:
//       return RoomType.trio;
//     case 3:
//       return RoomType.quad;
//     default:
//       return RoomType.single; // default fallback
//   }
// }

// // نوع السكن
// enum PropertyType { hotel, unit, villa }

// int _mappropertyTypeToInt(PropertyType property) {
//   switch (property) {
//     case PropertyType.hotel:
//       return 0;
//     case PropertyType.unit:
//       return 1;
//     case PropertyType.villa:
//       return 2;
//   }
// }

// PropertyType mapIntToPropertyType(int value) {
//   switch (value) {
//     case 0:
//       return PropertyType.hotel;
//     case 1:
//       return PropertyType.unit;
//     case 2:
//       return PropertyType.villa;
//     default:
//       throw Exception("قيمة غير معروفة: $value");
//   }
// }

// class HotelModel {
//   final int SubdestinationId;
//   final int? id;
//   final String placeen;
//   final String placear;
//   final String hotelnamear;
//   final String hotelnameen;
//   final String hoteldescriptionar;
//   final String hoteldescriptionen;
//   final String location;
//   final double pricepernight;
//   final String videourl;
//   final RoomType roomType;
//   final CategoryType category;
//   final PropertyType property;
//   final bool wifi;
//   final bool parking;
//   final bool pool;
//   final bool gym;
//   final bool spa;
//   final bool resturant;
//   final bool petfriendly;
//   final bool roomservice;
//   // final List<File> images;
//   final List<File> imagesFiles; // للإرسال للباك اند
//   final List<String> imagesUrls; // للعرض من الـ JSON
//   final int HotelRating;

//   HotelModel({
//     this.id,
//     required this.placear,
//     required this.placeen,
//     required this.roomservice,
//     required this.HotelRating,
//     // required this.images,
//     required this.imagesFiles,
//     required this.imagesUrls,
//     required this.wifi,
//     required this.parking,
//     required this.pool,
//     required this.property,
//     required this.gym,
//     required this.spa,
//     required this.resturant,
//     required this.petfriendly,
//     required this.roomType,
//     required this.pricepernight,
//     required this.location,
//     required this.SubdestinationId,
//     required this.hotelnamear,
//     required this.hotelnameen,
//     required this.hoteldescriptionar,
//     required this.hoteldescriptionen,
//     required this.videourl,
//     //  required this.roomType,
//     required this.category,
//   });

//   factory HotelModel.fromJson(Map<String, dynamic> json) {
//     return HotelModel(
//       // images: List<String>.from(json['images'] ?? []),
//       id: json["id"],
//       wifi: json['wifiAvailable'],
//       parking: json['parkingAvailable'],
//       pool: json['poolAvailable'],
//       gym: json['gymAvailable'],
//       spa: json['spaAvailable'],
//       resturant: json['restaurantAvailable'],
//       petfriendly: json['petFriendly'],

//       // roomType:
//       //     json['room_type'] != null ? _mapIntToRoom(json['room_type']) : null,
//       // roomType: json['room_type'] ?? 0,
//       // pricepernight: (json['price_per_night'] ?? 0).toDouble(),
//       // roomType:
//       //     json['room_type'] != null
//       //         ? _mapIntToRoom(json['room_type'] as int)
//       //         : null,
//       pricepernight: double.tryParse(json['price_per_night'].toString()) ?? 0.0,

//       location: json['map_location'] ?? "",
//       SubdestinationId: json['sub_destination_id'] ?? 0,
//       hotelnamear: json['name_ar'] ?? "",
//       hotelnameen: json['name_en'] ?? "",
//       hoteldescriptionar: json['description_ar'] ?? "",
//       hoteldescriptionen: json['description_en'] ?? "",
//       videourl: json['video_url'] ?? "",
//       HotelRating: (json['rate'] ?? 0),
//       roomservice: json['roomServiceAvailable'] ?? false,
//       placear: json['place_ar'] ?? "",
//       placeen: json['place_en'] ?? "",
//       imagesFiles: [], // لما تجيب من JSON مش محتاج File

//       imagesUrls: List<String>.from(json['images'] ?? []),
//       roomType:
//           json['room_type'] != null
//               ? _mapIntToRoom(json['room_type'] as int)
//               : RoomType.single,

//       property: mapIntToPropertyType(
//         int.tryParse(json['type'].toString()) ?? 0,
//       ),
//       category: _mapIntToCategory(
//         int.tryParse(json['category'].toString()) ?? 0,
//       ),
//       //  category: int.tryParse(json['category'].toString()) ?? 0;

//       // : mapIntToPropertyType(json['type'] as int),
//       // category: _mapIntToCategory(json['category'] as int), // default
//     );
//   }
// }
