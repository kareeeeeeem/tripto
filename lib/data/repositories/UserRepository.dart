import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tripto/core/services/api.dart';
import '../../core/models/ActivityCardModel.dart';
import '../../core/models/HomeApiModel.dart';

class UserRepository {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // 🔧 دالة مساعدة لإنشاء رسالة خطأ من الـ API
  String _getErrorMessage(Map<String, dynamic> data, int statusCode) {
    if (data.containsKey('errors')) {
      final errors = data['errors'] as Map<String, dynamic>;
      final messages = <String>[];

      errors.forEach((key, value) {
        if (value is List) {
          messages.addAll(value.map((e) => e.toString()));
        } else {
          messages.add(value.toString());
        }
      });

      return messages.join('\n');
    }

    return data['message'] ?? 'حدث خطأ غير متوقع (رمز: $statusCode)';
  }

  /// 🚀 التسجيل
  Future<Map<String, dynamic>> registerUser(
    String name,
    String email,
    String phoneNumber,
    String password,
    String confirmPassword,
  ) async {
    final url = Uri.parse('${ApiConstants.baseUrl}register');
    final bodyData = {
      'name': name,
      'email': email,
      'phone': phoneNumber,
      'password': password,
      'password_confirmation': confirmPassword,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(bodyData),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (data['token'] != null) {
          await _storage.write(key: 'jwt_token', value: data['token']);
          await _storage.write(
            key: 'user_data',
            value: json.encode(data['user']),
          );
        }

        return data;
      } else {
        throw Exception(_getErrorMessage(data, response.statusCode));
      }
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  /// 🚀 تسجيل الدخول
  Future<Map<String, dynamic>> loginUser(
    String phoneNumber,
    String password,
  ) async {
    final url = Uri.parse('${ApiConstants.baseUrl}login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phone': phoneNumber, 'password': password}),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (data['token'] != null) {
          await _storage.write(key: 'jwt_token', value: data['token']);
          await _storage.write(
            key: 'user_data',
            value: json.encode(data['user']),
          );
        }

        return data;
      } else {
        throw Exception(_getErrorMessage(data, response.statusCode));
      }
    } catch (e) {
      throw Exception('error');
    }
  }

  /// 📥 تحميل بيانات الصفحة الرئيسية
  Future<HomeApiModel> fetchHomeApiModel() async {
    final url = Uri.parse('${ApiConstants.baseUrl}trips');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${await _storage.read(key: 'jwt_token')}',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        return HomeApiModel.fromJson(data);
      } else {
        final data = json.decode(response.body);
        throw Exception(_getErrorMessage(data, response.statusCode));
      }
    } catch (e) {
      throw Exception('📛 Home Fetch Error: $e');
    }
  }

  /// 🎯 الحصول على الأنشطة
  // Future<List<ActivityCardmodel>> getActivities() async {
  //   final url = Uri.parse('${ApiConstants.baseUrl}activities');
  //   try {
  //     final response = await http.get(url);

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final List<dynamic> data = json.decode(response.body);
  //       return data.map((json) => ActivityCardmodel.fromJson(json)).toList();
  //     } else {
  //       throw Exception('❌ Failed to load activities');
  //     }
  //   } catch (e) {
  //     throw Exception('📛 Activity Fetch Error: $e');
  //   }
  // }
}
