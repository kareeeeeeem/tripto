import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tripto/bloc&repo/GetTrip/GetTrip_model.dart';

class SearchTripByDateRepository {
  Future<List<GetTripModel>> fetchTripsByDate(DateTime from, DateTime to) async {
    final url = Uri.parse(
        'https://tripto.blueboxpet.com/api/trips/search/date?from=${from.toIso8601String().split("T")[0]}&to=${to.toIso8601String().split("T")[0]}');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final trips = (data['trips'] as List)
          .map((tripJson) => GetTripModel.fromJson(tripJson))
          .toList();
      return trips;
    } else {
      throw Exception('Failed to fetch trips');
    }
  }
}