import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as _storage;
import 'package:tripto/core/models/activityPageModel.dart';
import 'package:tripto/core/services/api.dart';

class AuthRepository {
  final storage = FlutterSecureStorage();

  Future<Map<String, dynamic>> register(
    String name,
    String email,
    String phone,
    String password,
    String confirmPassword,
  ) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'password_confirmation': confirmPassword,
      }),
    );

    final data = json.decode(response.body);
    debugPrint('Register response: ${response.body}');

    if (response.statusCode == 201) {
      return data;
    } else {
      // ارجع بيانات الخطأ مباشرة
      return {
        'error': true,
        'message': data['message'],
        'errors': data['errors'] ?? {},
      };
    }
  }

  Future<Map<String, dynamic>> login(String phone, String password) async {
    final response = await http
        .post(
          Uri.parse('${ApiConstants.baseUrl}login'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode({'phone': phone, 'password': password}),
        )
        .timeout(const Duration(seconds: 100));

    debugPrint('Login status: ${response.statusCode}');
    debugPrint('Login body: ${response.body}');
    debugPrint('Request phone: $phone');
    debugPrint('Request password: $password');

    final data = json.decode(response.body);

    // بدل Exception، نرجع JSON فيه حقل error لو فيه مشكلة
    if (response.statusCode == 200) {
      if (data['token'] != null) {
        await storage.write(key: 'jwt_token', value: data['token']);
      }
      if (data['user'] != null) {
        await storage.write(key: 'user_data', value: jsonEncode(data['user']));
      }
      return data;
    } else {
      // رجع رسالة الخطأ بشكل منسق
      return {
        'error': true,
        'message': data['message_en'] ?? data['message'] ?? 'Login failed',
        'errors': data['errors'] ?? {},
      };
    }
  }

  Future<void> logout() async {
    await storage.delete(key: 'token');
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  Future<List<GetActivityModel>> getActivities() async {
    final token = await storage.read(key: 'token');

    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}activities'),
      headers: {'Authorization': 'bearer $token', 'Accept': 'application/json'},
    );
    debugPrint('Login status: ${response.statusCode}');
    debugPrint('Login body: ${response.body}');

    print("Response status: ${response.statusCode}");
    print("Raw response body: ${response.body}");
    if (response.statusCode == 200) {
      final List<dynamic> activitesList = json.decode(response.body);

      return activitesList
          .map((json) => GetActivityModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load activites');
    }
  }
}
