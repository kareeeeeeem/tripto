import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tripto/bloc&repo/ProfileUserDate/Edit/EditModel.dart';

class UserRepository {
  final String baseUrl = "https://tripto.blueboxpet.com/api";
  final storage = const FlutterSecureStorage();

  Future<User> updateUser({
    required int id, // لازم ID المستخدم
    required String name,
    required String email,
    required String phone,
  }) async {
    final token = await storage.read(key: 'token');

    final response = await http.put(
      Uri.parse("$baseUrl/users/$id"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({"name": name, "email": email, "phone": phone}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final user = User.fromJson(data['user']);

      // ✅ نحفظ البيانات الجديدة في التخزين
      await storage.write(key: 'user_data', value: jsonEncode(data['user']));

      return user;
    } else {
      throw Exception('Failed to update user');
    }
  }
}
