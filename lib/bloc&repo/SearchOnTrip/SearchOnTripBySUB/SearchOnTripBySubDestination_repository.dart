import 'package:http/http.dart' as http;
import 'package:tripto/bloc&repo/GetTrip/GetTrip_model.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class SearchTripBySubDestinationRepository {
  Future<List<GetTripModel>> fetchTripsBySubDestination(String subDestination) async {
    try {
      final uri = Uri.https(
        'tripto.blueboxpet.com',
        '/api/trips/search/subdestination',
        {'query': subDestination},
      );
      
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        // فك تشفير JSON كخريطة (Map)
        final Map<String, dynamic> responseData = json.decode(response.body);
        
        // استخراج قائمة الرحلات من مفتاح 'trips'
        final List<dynamic> tripsData = responseData['trips'] ?? [];
        
        // تحويل البيانات إلى قائمة من كائنات GetTripModel
        return tripsData.map((e) => GetTripModel.fromJson(e)).toList();
      } else {
        debugPrint('Error: Failed to load trips with status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      debugPrint('Error in fetchTripsBySubDestination: $e');
      return [];
    }
  }
}