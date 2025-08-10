class GetTripModel {
  final int id;
  final int? destinationId;
  final int? subDestinationId;
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
  final Map<String, dynamic>? destination;
  final Map<String, dynamic>? subDestination;

  GetTripModel({
    required this.id,
    this.destinationId,
    this.subDestinationId,
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
    this.destination,
    this.subDestination,
  });

  factory GetTripModel.fromJson(Map<String, dynamic> json) {
    // معالجة category لتحويلها من String إلى int إذا لزم الأمر
    final categoryValue = json['category']?.toString();
    final parsedCategory =
        categoryValue != null ? int.tryParse(categoryValue) ?? 0 : 0;

    // معالجة التواريخ
    DateTime? parseDateTime(dynamic date) {
      if (date == null) return null;
      if (date is DateTime) return date;
      return DateTime.tryParse(date.toString());
    }

    // معالجة القيم المنطقية
    bool parseBool(dynamic value) {
      if (value == null) return false;
      if (value is bool) return value;
      if (value is num) return value != 0;
      if (value is String) {
        return value.toLowerCase() == 'true' || value == '1';
      }
      return false;
    }

    // معالجة القيم العشرية
    double parseDouble(dynamic value) {
      if (value == null) return 0.0;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      return double.tryParse(value.toString()) ?? 0.0;
    }

    // معالجة القيم الصحيحة
    int parseInt(dynamic value) {
      if (value == null) return 0;
      if (value is int) return value;
      if (value is double) return value.toInt();
      return int.tryParse(value.toString()) ?? 0;
    }

    return GetTripModel(
      id: parseInt(json['id']),
      destinationId: parseInt(json['destination_id']),
      subDestinationId: parseInt(json['sub_destination_id']),
      category: parsedCategory,
      hasHotel: parseBool(json['has_hotel']),
      hasCar: parseBool(json['has_car']),
      hasFly: parseBool(json['has_fly']),
      hasActivity: parseBool(json['has_activity']),
      price: parseDouble(json['price']),
      pricePerPerson: parseDouble(json['price_per_person']),
      fromDate: json['from_date']?.toString() ?? '',
      toDate: json['to_date']?.toString() ?? '',
      companyNameAr: json['company_name_ar']?.toString(),
      companyNameEn: json['company_name_en']?.toString(),
      companyDesAr: json['company_des_ar']?.toString(),
      companyDesEn: json['company_des_en']?.toString(),
      videoUrl: json['video_url']?.toString() ?? '',
      maxPersons: parseInt(json['max_persons']),
      createdAt: parseDateTime(json['created_at']),
      updatedAt: parseDateTime(json['updated_at']),
      destination:
          json['destination'] is Map
              ? Map<String, dynamic>.from(json['destination'])
              : null,
      subDestination:
          json['sub_destination'] is Map
              ? Map<String, dynamic>.from(json['sub_destination'])
              : null,
    );
  }

  // Getters للتعامل مع القيم الفارغة
  DateTime get safeFromDate {
    try {
      return DateTime.parse(fromDate).toLocal();
    } catch (e) {
      return DateTime.now();
    }
  }

  DateTime get safeToDate {
    try {
      return DateTime.parse(toDate).toLocal();
    } catch (e) {
      return DateTime.now().add(const Duration(days: 7));
    }
  }

  bool get hasValidDates =>
      safeFromDate.isBefore(safeToDate) ||
      safeFromDate.isAtSameMomentAs(safeToDate);

  String get destinationNameAr => destination?['name_ar']?.toString() ?? '';
  String get destinationNameEn => destination?['name_en']?.toString() ?? '';
  String get subDestinationNameAr =>
      subDestination?['name_ar']?.toString() ?? '';
  String get subDestinationNameEn =>
      subDestination?['name_en']?.toString() ?? '';

  Map<String, dynamic> toVideoPlayerJson() {
    return {
      'id': id,
      'destination': destination ?? {},
      'sub_destination': subDestination ?? {},
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
