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
    final response = await http
        .post(
          Uri.parse('${ApiConstants.baseUrl}register'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'name': name,
            'email': email,
            'phone': phone,
            'password': password,
            'password_confirmation': confirmPassword,
          }),
        )
        .timeout(const Duration(seconds: 10)); // أضف هذا

    debugPrint('Register response: ${response.body}');
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      return data;
    } else {
      throw Exception(data['message'] ?? 'Registration failed');
    }
  }

  Future<Map<String, dynamic>> login(String phone, String password) async {
    final response = await http
        .post(
          Uri.parse('${ApiConstants.baseUrl}login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'phone': phone, 'password': password}),
        )
        .timeout(const Duration(seconds: 100)); // أضف هذا السطر

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      await storage.write(key: 'token', value: data['token']);
      return data;
    } else {
      throw Exception('Login failed: ${response.statusCode}');
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
