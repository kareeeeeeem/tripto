import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tripto/bloc&repo/GetTrip/GetTrip_model.dart';

class FilteredTripsByCategoryRepository {
  Future<List<GetTripModel>> fetchTripsByCategory(String category) async {
    final response = await http.get(
      Uri.parse(
        'https://tripto.blueboxpet.com/api/trips/category?category=$category',
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final tripsJson = data['trips'] as List;
      return tripsJson.map((json) => GetTripModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch trips by category');
    }
  }
}
