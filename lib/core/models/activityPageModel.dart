enum CategoryType { Platinum, Diamond, Gold }

int _mapCategoryToInt(CategoryType category) {
  switch (category) {
    case CategoryType.Gold:
      return 0;
    case CategoryType.Platinum:
      return 1;
    case CategoryType.Diamond:
      return 2;
  }
}

class GetActivityModel {
  final int id;
  final String activitynamear;
  final String activitynameen;
  final String activitydescriptionar;
  final String activitydescriptionen;
  final String activityduration;
  final CategoryType category;
  final int price;
  final int priceperperson;
  final bool transportation;
  final int SubdestinationId;
  final List<String> images; // List of image URLs or paths
  final String videoUrl;

  GetActivityModel({
    required this.id,
    required this.transportation,
    required this.priceperperson,
    required this.activitynamear,
    required this.activitynameen,
    required this.activitydescriptionar,
    required this.activitydescriptionen,
    required this.activityduration,
    required this.category,
    required this.price,
    required this.SubdestinationId,
    required this.images,
    required this.videoUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "sub_destination_id": SubdestinationId,
      "activity_name_ar": activitynamear,
      "activity_name_en": activitynameen,
      "activity_description_ar": activitydescriptionar,
      "activity_description_en": activitydescriptionen,
      "activity_duration": activityduration,
      "category": _mapCategoryToInt(category),
      "price": price,
      "price_per_person": priceperperson,
      "has_transportation": transportation,
      "images": images, // Assuming images are stored as URLs or paths
      "video_url": videoUrl, // New field for video URL
    };
  }

  factory GetActivityModel.fromJson(Map<String, dynamic> json) {
    return GetActivityModel(
      id: json['id'],
      SubdestinationId: json['sub_destination_id'],
      activitynamear: json['activity_name_ar'],
      activitynameen: json['activity_name_en'],
      activitydescriptionar: json['activity_description_ar'],
      activitydescriptionen: json['activity_description_en'],
      activityduration: json['activity_duration'],
      category: CategoryType.values[json['category']],
      price: double.tryParse(json['price'].toString())?.toInt() ?? 0,
      priceperperson:
          double.tryParse(json['price_per_person'].toString())?.toInt() ?? 0,

      transportation: json['has_transportation'] ?? false,
      images: List<String>.from(json['images'] ?? []),
      videoUrl: json['video_url'] ?? '', // New field for video URL
    );
  }
}
