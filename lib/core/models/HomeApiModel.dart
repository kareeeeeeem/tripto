class HomeApiModel {
  final String destinationNameEn;
  final String subDestinationNameEn;
  final int category;
  final bool hasHotel;
  final bool hasCar;
  final bool hasFly;
  final bool hasActivity;
  final int price;
  final int pricePerPerson;
  final String fromDate;
  final String toDate;
  final String companyNameEn;
  final String companyDesEn;
  final String videoUrl;
  final int maxPersons;

  HomeApiModel({
    required this.destinationNameEn,
    required this.subDestinationNameEn,
    required this.category,
    required this.hasHotel,
    required this.hasCar,
    required this.hasFly,
    required this.hasActivity,
    required this.price,
    required this.pricePerPerson,
    required this.fromDate,
    required this.toDate,
    required this.companyNameEn,
    required this.companyDesEn,
    required this.videoUrl,
    required this.maxPersons,
  });

  factory HomeApiModel.fromJson(Map<String, dynamic> json) {
    return HomeApiModel(
      destinationNameEn: json['destination_name_en'],
      subDestinationNameEn: json['sub_destination_name_en'],
      category: json['category'],
      hasHotel: json['has_hotel'],
      hasCar: json['has_car'],
      hasFly: json['has_fly'],
      hasActivity: json['has_activity'],
      price: json['price'],
      pricePerPerson: json['price_per_person'],
      fromDate: json['from_date'],
      toDate: json['to_date'],
      companyNameEn: json['company_name_en'],
      companyDesEn: json['company_des_en'],
      videoUrl: json['video_url'],
      maxPersons: json['max_persons'],
    );
  }
}
