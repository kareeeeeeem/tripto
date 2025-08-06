class GetTripModel {
  final int id;
  final int destinationId;
  final int subDestinationId;
  final int category;
  final bool hasHotel;
  final bool hasCar;
  final bool hasFly;
  final bool hasActivity;
  final double price;
  final double pricePerPerson;
  final String fromDate;
  final String toDate;
  final String? companyNameAr;
  final String? companyNameEn;
  final String? companyDesAr;
  final String? companyDesEn;
  final String videoUrl;
  final int maxPersons;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Map<String, dynamic> destination;
  final Map<String, dynamic> subDestination;

  GetTripModel({
    required this.id,
    required this.destinationId,
    required this.subDestinationId,
    required this.category,
    required this.hasHotel,
    required this.hasCar,
    required this.hasFly,
    required this.hasActivity,
    required this.price,
    required this.pricePerPerson,
    required this.fromDate,
    required this.toDate,
    this.companyNameAr,
    this.companyNameEn,
    this.companyDesAr,
    this.companyDesEn,
    required this.videoUrl,
    required this.maxPersons,
    this.createdAt,
    this.updatedAt,
    required this.destination,
    required this.subDestination,
  });

  factory GetTripModel.fromJson(Map<String, dynamic> json) {
    return GetTripModel(
      id: json['id'] as int,
      destinationId: json['destination_id'] as int,
      subDestinationId: json['sub_destination_id'] as int,
      category: int.tryParse(json['category'].toString()) ?? 0,
      hasHotel: json['has_hotel'] == 1 || json['has_hotel'] == true,
      hasCar: json['has_car'] == 1 || json['has_car'] == true,
      hasFly: json['has_fly'] == 1 || json['has_fly'] == true,
      hasActivity: json['has_activity'] == 1 || json['has_activity'] == true,
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      pricePerPerson:
          double.tryParse(json['price_per_person'].toString()) ?? 0.0,
      fromDate: json['from_date'] as String, // تم التصحيح هنا
      toDate: json['to_date'] as String, // تم التصحيح هنا
      companyNameAr: json['company_name_ar'],
      companyNameEn: json['company_name_en'],
      companyDesAr: json['company_des_ar'],
      companyDesEn: json['company_des_en'],
      videoUrl: json['video_url'] ?? '',
      maxPersons: json['max_persons'] as int,
      createdAt:
          json['created_at'] != null
              ? DateTime.parse(json['created_at'])
              : null,
      updatedAt:
          json['updated_at'] != null
              ? DateTime.parse(json['updated_at'])
              : null,
      destination:
          json['destination'] is Map
              ? Map<String, dynamic>.from(json['destination'])
              : {},
      subDestination:
          json['sub_destination'] is Map
              ? Map<String, dynamic>.from(json['sub_destination'])
              : {},
    );
  }

  // دوال مساعدة للوصول إلى البيانات بسهولة
  String get destinationNameAr => destination['name_ar'] as String? ?? '';
  String get destinationNameEn => destination['name_en'] as String? ?? '';
  String get subDestinationNameAr => subDestination['name_ar'] as String? ?? '';
  String get subDestinationNameEn => subDestination['name_en'] as String? ?? '';

  Map<String, dynamic> toVideoPlayerJson() {
    return {
      'id': id,
      'destination': destination, // أضف هذا السطر
      'sub_destination': subDestination, // أضف هذا السطر
      'destination_name_ar': destinationNameAr,
      'destination_name_en': destinationNameEn,
      'sub_destination_name_ar': subDestinationNameAr,
      'sub_destination_name_en': subDestinationNameEn,
      'price': price,
      'price_per_person': pricePerPerson,
      'video_url': videoUrl,
      'from_date': fromDate,
      'to_date': toDate,
    };
  }
}
