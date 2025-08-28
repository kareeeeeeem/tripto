import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tripto/bloc/GetTrip/GetTrip_model.dart';
import 'package:tripto/core/models/CarModel.dart';
import 'package:tripto/core/services/api.dart';

class TripsRepository {
  final storage = const FlutterSecureStorage();

  Future<List<GetTripModel>> fetchTrips() async {
    try {
      final token = await storage.read(key: 'token');
      debugPrint('Trips repository token: $token');

      final url = Uri.parse('${ApiConstants.baseUrl}trips');
      debugPrint('Request URL: $url');

      // لو فيه توكن ضيفه، لو مفيش سيب الطلب عادي
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
      };

      final response = await http
          .get(url, headers: headers)
          .timeout(const Duration(seconds: 15));

      debugPrint('=== معلومات الرد من السيرفر ===');
      debugPrint('الحالة: ${response.statusCode}');
      debugPrint('الرأسيات: ${response.headers}');
      debugPrint('المحتوى: ${response.body}');
      debugPrint('============================');

      if (response.body.trim().startsWith('<!DOCTYPE html>') ||
          response.body.trim().startsWith('<html>')) {
        throw Exception('الخادم أعاد صفحة HTML بدلاً من JSON');
      }

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);

        if (decoded is List) {
          return decoded.map((json) => GetTripModel.fromJson(json)).toList();
        } else if (decoded is Map && decoded.containsKey('data')) {
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

class CarRepository {
  final storage = const FlutterSecureStorage();

  Future<List<Carmodel>> fetchCars({
    int? subDestinationId,
    int? category,
  }) async {
    final token = await storage.read(key: 'token');
    // if (token == null || token.isEmpty) {
    //   throw Exception('لم يتم العثور على رمز الدخول (Token)');
    // }

    final uri = Uri.parse('${ApiConstants.baseUrl}cars').replace(
      queryParameters: {
        if (subDestinationId != null)
          'sub_destination_id': subDestinationId.toString(),
        if (category != null) 'category': category.toString(),
      },
    );

    debugPrint('Car request URL: $uri');

    final response = await http
        .get(
          uri,
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        )
        .timeout(const Duration(seconds: 15));

    debugPrint('Car response status: ${response.statusCode}');
    debugPrint('Car response body: ${response.body}');

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      debugPrint('Decoded response: $decoded');

      List<dynamic>? carList;

      if (decoded is List) {
        carList = decoded;
      } else if (decoded is Map<String, dynamic>) {
        if (decoded['cars'] is List) {
          carList = decoded['cars'];
        } else if (decoded['data'] is List) {
          carList = decoded['data'];
        }
      }

      if (carList == null) {
        throw Exception('بيانات السيارات غير موجودة أو ليست قائمة.');
      }

      return carList
          .map((e) => Carmodel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('فشل في تحميل السيارات: ${response.statusCode}');
    }
  }
}
