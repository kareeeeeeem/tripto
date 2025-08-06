import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tripto/bloc/GetTrip/GetTrip_model.dart';
import 'package:tripto/core/services/api.dart';

class TripsRepository {
  final storage = const FlutterSecureStorage();

  Future<List<GetTripModel>> fetchTrips() async {
    try {
      // 1. الحصول على التوكن
      final token = await storage.read(key: 'token');
      debugPrint(
        'Ttrip repository token: $token',
      ); // طباعة التوكن للتأكد من صحته

      if (token == null || token.isEmpty) {
        throw Exception('لم يتم العثور على رمز الدخول (Token)');
      }

      // 2. إرسال الطلب إلى السيرفر
      final url = Uri.parse('${ApiConstants.baseUrl}trips');
      debugPrint('Request URL: $url'); // طباعة URL للتحقق

      final response = await http
          .get(
            url,
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 15));

      // 3. تسجيل تفاصيل الرد للسيرفر
      debugPrint('=== معلومات الرد من السيرفر ===');
      debugPrint('الحالة: ${response.statusCode}');
      debugPrint('الرأسيات: ${response.headers}');
      debugPrint('المحتوى: ${response.body}');
      debugPrint('============================');

      // 4. التحقق من أن الرد ليس صفحة HTML
      if (response.body.trim().startsWith('<!DOCTYPE html>') ||
          response.body.trim().startsWith('<html>')) {
        throw Exception('الخادم أعاد صفحة HTML بدلاً من JSON');
      }

      // 5. معالجة الرد
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);

        // الحالة الأولى: الرد هو قائمة مباشرة
        if (decoded is List) {
          return decoded.map((json) => GetTripModel.fromJson(json)).toList();
        }
        // الحالة الثانية: الرد مغلف داخل كائن يحتوي على data
        else if (decoded is Map && decoded.containsKey('data')) {
          final data = decoded['data'];
          if (data is List) {
            return data.map((json) => GetTripModel.fromJson(json)).toList();
          }
        }

        throw Exception('تنسيق الرد غير صالح');
      } else {
        throw Exception('فشل في جلب الرحلات: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('حدث خطأ في fetchTrips: $e');
      rethrow;
    }
  }
}
