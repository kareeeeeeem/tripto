import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tripto/core/models/CarModel.dart';
import 'package:tripto/core/services/api.dart';

class CarRepository {
  final storage = const FlutterSecureStorage();

  Future<List<Carmodel>> fetchCars({
    int? subDestinationId,
    int? category,
  }) async {
    try {
      final token = await storage.read(key: 'token');
      final uri = Uri.parse('${ApiConstants.baseUrl}cars').replace(
        queryParameters: {
          if (subDestinationId != null)
            'sub_destination_id': subDestinationId.toString(),
          if (category != null) 'category': category.toString(),
        },
      );

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

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        List<dynamic>? carList;

        if (decoded is List) {
          carList = decoded;
        } else if (decoded is Map<String, dynamic>) {
          carList = decoded['cars'] ?? decoded['data'];
        }

        if (carList == null) throw Exception('بيانات السيارات غير صالحة');

        return carList.map((e) => Carmodel.fromJson(e)).toList();
      }
      throw Exception('فشل تحميل السيارات: ${response.statusCode}');
    } catch (e) {
      debugPrint('خطأ في CarRepository: $e');
      rethrow;
    }
  }
}
