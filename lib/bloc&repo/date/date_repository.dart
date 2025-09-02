import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tripto/bloc&repo/GetTrip/GetTrip_model.dart';
import 'package:tripto/core/services/api.dart';

class DateRepository {
  final storage = const FlutterSecureStorage();

  Future<List<GetTripModel>> fetchAvailableDates() async {
    try {
      final token = await storage.read(key: 'token');
      final url = Uri.parse('${ApiConstants.baseUrl}dates');

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

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded is List) {
          return decoded.map((json) => GetTripModel.fromJson(json)).toList();
        }
      }
      throw Exception('فشل تحميل التواريخ');
    } catch (e) {
      debugPrint('خطأ في DateRepository: $e');
      rethrow;
    }
  }
}
