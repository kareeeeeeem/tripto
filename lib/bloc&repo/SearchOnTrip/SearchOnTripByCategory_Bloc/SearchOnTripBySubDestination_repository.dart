import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tripto/bloc&repo/GetTrip/GetTrip_repository.dart'; // لو عندك موديل Trip

class SearchSubDestinationRepository {
  final String baseUrl =
      'https://tripto.blueboxpet.com/api/trips/search/subdestination';

  Future<List<dynamic>> searchSubDestination(String query) async {
    final url = Uri.parse('$baseUrl?query=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data is List) {
        return data;
      } else if (data['data'] != null) {
        return data['data'] as List;
      }
      return [];
    } else {
      throw Exception('Failed to fetch sub-destination trips');
    }
  }
}
