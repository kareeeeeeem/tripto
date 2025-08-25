import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AccountRepository {
  final String baseUrl = "https://tripto.blueboxpet.com/api";
  final storage = const FlutterSecureStorage();

  // فقط إرسال طلب اللوج أوت
  Future<http.Response> logoutRequest(String token) async {
    return await http.post(
      Uri.parse("$baseUrl/logout"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }

  // حذف التوكن وبيانات المستخدم بعد النجاح
  Future<void> clearUserData() async {
    await storage.delete(key: 'jwt_token');
    await storage.delete(key: 'user_data');
  }
}
