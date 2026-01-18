class ContactusModel {
  final String name;
  final String email;
  final String phone;
  final String messagebody;
  final String subject;

  ContactusModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.messagebody,
    required this.subject,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "phone_number": phone,
      "message": messagebody,
      "subject": subject,
    };
  }
}
