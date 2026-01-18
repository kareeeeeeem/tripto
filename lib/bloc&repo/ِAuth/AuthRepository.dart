import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tripto/core/models/activityPageModel.dart';
import 'package:tripto/core/services/api.dart';

class AuthRepository {
  static final storage = const FlutterSecureStorage();

  // تسجيل مستخدم جديد
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
      if (data['token'] != null) {
        await storage.write(key: 'token', value: data['token']);
      }
      if (data['user'] != null) {
        await storage.write(key: 'user_data', value: jsonEncode(data['user']));
      }
      return data;
    } else {
      return {
        'error': true,
        'message': data['message'],
        'errors': data['errors'] ?? {},
      };
    }
  }

  // تسجيل الدخول
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
        .timeout(const Duration(seconds: 30));

    debugPrint('Login status: ${response.statusCode}');
    debugPrint('Login body: ${response.body}');

    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      // خزن التوكن لو موجود
      final token = data['token'];
      if (token != null) {
        await storage.write(key: 'token', value: token);
        debugPrint('🔑 Saved token: $token'); // 👈 اطبع التوكن بعد التخزين
      }

      // لو في يوزر جوا الريسبونس
      final user = data['user'];
      if (user != null) {
        await storage.write(key: 'name', value: user['name'] ?? '');
        await storage.write(key: 'email', value: user['email'] ?? '');
        await storage.write(key: 'phone', value: user['phone'] ?? '');
        await storage.write(key: 'number', value: user['number'] ?? '');

        await storage.write(key: 'userId', value: user['userId'] ?? '');

        // خزن نسخة كاملة من بيانات اليوزر
        await storage.write(key: 'userId', value: user['id'].toString());
      }

      return data;
    } else {
      return {
        'error': true,
        'message': data['message_en'] ?? data['message'] ?? 'Login failed',
        'errors': data['errors'] ?? {},
      };
    }
  }

  // تسجيل الخروج
  Future<void> logout() async {
    final token = await storage.read(key: 'token');

    if (token != null) {
      try {
        final response = await http.post(
          Uri.parse('${ApiConstants.baseUrl}logout'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({}),
        );
        debugPrint('Logout status: ${response.statusCode}');
      } catch (e) {
        debugPrint('Logout request failed: $e');
      }
    }

    // امسح البيانات في كل الحالات
    await clearUserData();
  }

  // مسح بيانات المستخدم
  Future<void> clearUserData() async {
    await storage.delete(key: 'token');
    await storage.delete(key: 'user_data');

    await storage.delete(key: 'userId'); // ✨ مهم عشان الـ MyTrips
  }

  // جلب التوكن
  static Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  // جلب بيانات المستخدم
  Future<Map<String, dynamic>?> getUserData() async {
    final jsonStr = await storage.read(key: 'user_data');
    if (jsonStr != null) {
      return jsonDecode(jsonStr);
    }
    return null;
  }

  // مثال: جلب الأنشطة
  Future<List<GetActivityModel>> getActivities() async {
    final token = await getToken();

    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}activities'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    debugPrint('Activities status: ${response.statusCode}');
    debugPrint('Activities body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> activitesList = json.decode(response.body);
      return activitesList
          .map((json) => GetActivityModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load activities');
    }
  }

  Future<void> deleteAccount(String token) async {
    try {
      final token = await storage.read(key: 'token');

      if (token == null) {
        debugPrint('❌ No token found, user may not be logged in.');
        throw Exception('No token found');
      }
      final response = await http.put(
        Uri.parse('${ApiConstants.baseUrl}users/delete'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      debugPrint('Delete account status: ${response.statusCode}');
      debugPrint('Delete account response: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        await clearUserData(); // 🧹 امسح البيانات المحلية بعد الحذف
        debugPrint("✅ Account deleted successfully");
      } else {
        // اطبع الخطأ الحقيقي من السيرفر
        debugPrint("❌ Delete account failed: ${response.body}");
        throw Exception('Delete account failed: ${response.body}');
      }
    } catch (e) {
      debugPrint('❌ Delete account request failed: $e');
      rethrow;
    }
  }
}
