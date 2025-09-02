import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tripto/bloc&repo/GetTrip/GetTrip_model.dart';
import 'package:tripto/core/services/api.dart';

class FilteredTripsByDateRepository {
  final storage = const FlutterSecureStorage();

  Future<List<GetTripModel>> fetchTripsByDate(
    DateTime from,
    DateTime to,
  ) async {
    try {
      final token = await storage.read(key: 'token');
      final fromStr = from.toIso8601String().split('T').first;
      final toStr = to.toIso8601String().split('T').first;

      final url = Uri.parse(
        '${ApiConstants.baseUrl}trips/search/date?from=$fromStr&to=$toStr',
      );

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
        if (decoded is Map && decoded.containsKey('trips')) {
          return (decoded['trips'] as List)
              .map((json) => GetTripModel.fromJson(json))
              .toList();
        }
      }

      throw Exception('Failed to fetch trips by date: ${response.statusCode}');
    } catch (e) {
      rethrow;
    }
  }
}
