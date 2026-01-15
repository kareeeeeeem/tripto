// import trip model
import 'package:tripto/bloc&repo/GetTrip/GetTrip_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchTripByCategoryRepository {
  final String baseUrl = 'https://tripto.blueboxpet.com/api/trips/category';

  Future<List<GetTripModel>> fetchTripsByCategory(int category) async {
    final response = await http.get(Uri.parse('$baseUrl?category=$category'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final tripsJson = data['trips'] as List<dynamic>;
      return tripsJson.map((j) => GetTripModel.fromJson(j as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load trips for category $category');
    }
  }
}
