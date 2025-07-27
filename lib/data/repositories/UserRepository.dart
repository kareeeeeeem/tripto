import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tripto/core/services/api.dart';

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
}
