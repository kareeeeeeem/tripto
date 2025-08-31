class ContactusModel {
  final String Name;
  final String email;
  final int phone;
  final String messagebody;

  ContactusModel({
    required this.Name,
    required this.email,
    required this.phone,
    required this.messagebody,
  });

  Map<String, dynamic> toJson() {
    return {
      // "car_name_ar": Name,
      // "car_name_en": email,
      // "color": phone,
      // "year": messagebody,
    };
  }
}
