class Carmodel {
  final int id;
  final String carNameAr;
  final String carNameEn;
  final String color;
  final String year;
  final double price;
  final int category;
  final bool withGuide;
  final int numberOfSeats;
  final int subDestinationId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Map<String, dynamic>? subDestination;

  Carmodel({
    required this.id,
    required this.carNameAr,
    required this.carNameEn,
    required this.color,
    required this.year,
    required this.price,
    required this.category,
    required this.withGuide,
    required this.numberOfSeats,
    required this.subDestinationId,
    this.createdAt,
    this.updatedAt,
    this.subDestination,
  });

  factory Carmodel.fromJson(Map<String, dynamic> json) {
    bool parseBool(dynamic value) {
      if (value == null) return false;
      if (value is bool) return value;
      if (value is int) return value != 0;
      if (value is String) {
        return value.toLowerCase() == 'true' || value == '1';
      }
      return false;
    }

    double parseDouble(dynamic value) {
      if (value == null) return 0.0;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      return double.tryParse(value.toString()) ?? 0.0;
    }

    DateTime? parseDateTime(dynamic value) {
      if (value == null) return null;
      try {
        return DateTime.parse(value.toString());
      } catch (e) {
        return null;
      }
    }

    return Carmodel(
      id: json['id'] ?? 0,
      carNameAr: json['car_name_ar'] ?? '',
      carNameEn: json['car_name_en'] ?? '',
      color: json['color'] ?? '',
      year: json['year'] ?? '',
      price: parseDouble(json['price']),
      category: json['category'] ?? 0,
      withGuide: parseBool(json['with_guide']),
      numberOfSeats: json['number_of_seats'] ?? 0,
      subDestinationId: json['sub_destination_id'] ?? 0,
      createdAt: parseDateTime(json['created_at']),
      updatedAt: parseDateTime(json['updated_at']),
      subDestination:
          json['sub_destination'] != null && json['sub_destination'] is Map
              ? Map<String, dynamic>.from(json['sub_destination'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'car_name_ar': carNameAr,
      'car_name_en': carNameEn,
      'color': color,
      'year': year,
      'price': price,
      'category': category,
      'with_guide': withGuide ? 1 : 0,
      'number_of_seats': numberOfSeats,
      'sub_destination_id': subDestinationId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'sub_destination': subDestination,
    };
  }
}
