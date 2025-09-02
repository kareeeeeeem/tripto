import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tripto/bloc&repo/GetTrip/GetTrip_model.dart';
import 'package:tripto/core/services/api.dart';

class TripRepository {
  final storage = const FlutterSecureStorage();
  // جلب الرحلات كلها
  Future<List<GetTripModel>> fetchTrips() async {
    try {
      final token = await storage.read(key: 'token');
      final url = Uri.parse('${ApiConstants.baseUrl}trips');

      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
      };

      final response = await http
          .get(url, headers: headers)
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded is List) {
          return decoded.map((json) => GetTripModel.fromJson(json)).toList();
        } else if (decoded is Map && decoded.containsKey('data')) {
          return (decoded['data'] as List)
              .map((json) => GetTripModel.fromJson(json))
              .toList();
        }
      }
      throw Exception('فشل في جلب الرحلات: ${response.statusCode}');
    } catch (e) {
      debugPrint('خطأ في TripRepository: $e');
      rethrow;
    }
  }
}
