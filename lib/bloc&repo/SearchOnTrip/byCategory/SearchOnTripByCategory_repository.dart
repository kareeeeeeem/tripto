import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchTripByCategoryRepository {
  final String baseUrl = 'https://tripto.blueboxpet.com/api/trips/category';

  Future<List<dynamic>> fetchTripsByCategory(int category) async {
    final response = await http.get(Uri.parse('$baseUrl?category=$category'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['trips'] as List<dynamic>;
    } else {
      throw Exception('Failed to load trips for category $category');
    }
  }
}
