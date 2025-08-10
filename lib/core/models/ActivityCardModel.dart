class Activitymodel {
  final int id;
  final String activityNameAr;
  final String activityNameEn;
  final String activityDuration;
  final int category;
  final double price;
  final double pricePerPerson;
  final bool hasTransportation;
  final int subDestinationId;

  Activitymodel({
    required this.id,
    required this.activityNameAr,
    required this.activityNameEn,
    required this.activityDuration,
    required this.category,
    required this.price,
    required this.pricePerPerson,
    required this.hasTransportation,
    required this.subDestinationId,
  });

  factory Activitymodel.fromJson(Map<String, dynamic> json) {
    return Activitymodel(
      id: json['id'] ?? 0,
      activityNameAr: json['activity_name_ar'] ?? '',
      activityNameEn: json['activity_name_en'] ?? '',
      activityDuration: json['activity_duration'] ?? '',
      category: json['category'] ?? 0,
      price: (json['price'] ?? 0).toDouble(),
      pricePerPerson: (json['price_per_person'] ?? 0).toDouble(),
      hasTransportation:
          (json['has_transportation'] ?? false) == true ||
          json['has_transportation'] == 1,
      subDestinationId: json['sub_destination_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'activity_name_ar': activityNameAr,
      'activity_name_en': activityNameEn,
      'activity_duration': activityDuration,
      'category': category,
      'price': price,
      'price_per_person': pricePerPerson,
      'has_transportation': hasTransportation ? 1 : 0,
      'sub_destination_id': subDestinationId,
    };
  }
}
